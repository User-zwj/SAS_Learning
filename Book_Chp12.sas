libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.tourrevenue;
	infile '/home/u58907790/sasuser.v94/excel_files/tourrevenue' truncover;
	input Country $1-11 LandCost Vendor $ NumberOfBookings;
run;

proc print data=mylib.tourrevenue;
	title 'SAS Data Set mylib.tourrevenue';
run;

/* Page189 - Creating a Running Total */
data total;
	set mylib.tourrevenue;
	TotalBookings+NumberOfBookings;
run;

proc print data=total;
	var Country NumberOfBookings TotalBookings;
	title 'Total Tours Booked';
run;

/* Page190 - Printing Only the Total */
/* the name after end= can be set to be any names */
data total2(keep=TotalBookings);
	set mylib.tourrevenue end=a;
	TotalBookings+NumberOfBookings;
	if a;     /*Do not forget!!!*/
run;

proc print data=total2;
	title 'Total Number of Tours Booked';
run;

/* Page191 - Obtaining a Total for Each By Group */
proc sort data=mylib.tourrevenue out=mylib.sorttour;
	by Vendor;
run;

proc print data=mylib.sorttour;
	title 'Sorted Tourrevenue';
run;

data totalby;
	set mylib.sorttour;
	by Vendor;
	if First.Vendor then VendorBookings=0;
	VendorBookings+NumberOfBookings;
run;

proc print data=totalby;
	title 'Summary of Bookings by Vendor';
run;

/* Page192 */
data totalby(drop=country landcost);
	set mylib.sorttour;
	by Vendor;
	if First.vendor then VendorBookings=0;
	VendorBookings+NumberOfBookings;
	if Last.Vendor;
run;

proc print data=totalby;
	title 'Total Bookings by Vendor';
run;

/* Page193 - Writing Observations to Separate Data Sets */
data tourdetails vendordetails;    /*Exact the same info in two data sets*/
	set mylib.sorttour;
	by Vendor;
run;

proc print data=tourdetails;
	title 'Data Set tourdetials';
run;

proc print data=vendordetails;
	title 'Data Set vendordetails';
run;

data tourdetails(drop=VendorBookings VendorMoney)
	vendordetails(keep=Vendor VendorBookings VendorMoney);
	set mylib.sorttour;
	by Vendor;
	Money=LandCost*NumberOfBookings;
	output tourdetails;
	if first.vendor then
		do;
			VendorBookings=0;
			VendorMoney=0;
		end;
	VendorBookings+NumberOfBookings;
	VendorMoney+Money;
	if last.vendor then output vendordetails;
run;

proc print data=tourdetails;
	title 'Detail Recoreds: Dollars Spent on Individual Tours';
run;

proc print data=vendordetails;
	title 'Vendor Totals: Dollars Spent and Bookings by Vendor';
run;

/* Page196 - Using a Value in a Later Observation */
/* Explore1 - Comment output */
/* Explore2 - Comment retain */
data temp;
	set mylib.tourrevenue;
	retain HoldRevenue;
	Revenue=LandCost*NumberOfBookings;
	output;
	HoldRevenue=Revenue;
run;

proc print data=temp;
	var Country LandCost NumberOfBookings Revenue HoldRevenue;
	title 'Tour Revenue';
run;

/* Page197 - Largest value of Revenue */
data mostrevenue;
	set mylib.tourrevenue;
	retain HoldRevenue;
	Revenue = LandCost*NumberOfBookings;
	if Revenue>HoldRevenue then HoldRevenue=Revenue;
run;

proc print data=mostrevenue;
	var Country LandCost NumberOfBookings Revenue HoldRevenue;
	title 'Tour Revenue';
run;

/* Page198 -  */
data mostrevenue(keep=HoldRevenue HoldCountry);
	set mylib.tourrevenue end=lastobs;
	retain HoldRevenue HoldCountry;
	Revenue = LandCost*NumberOfBookings;
	if Revenue>HoldRevenue then
		do;
			HoldRevenue = Revenue;
			HoldCountry = Country;
		end;
	if lastobs;
run;

proc print data=mostrevenue;
	title 'Country with the Largest Value of Revenue';
run;

