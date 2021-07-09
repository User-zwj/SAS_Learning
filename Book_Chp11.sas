/* Page173 */
libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.arch_or_scen;
	infile '/home/u58907790/sasuser.v94/excel_files/arch_or_scen' truncover;
	input Country $1-11 TourType $13-24 Nights LandCost Vendor $;
run;

proc print data=mylib.arch_or_scen;
	title 'Data Set Mylib.arch_or_scen';
run;

/* Page175 - Goruping observations with the SORT procedure */
proc sort data=mylib.arch_or_scen out=tourorder;
	by TourType;
run;

proc print data=tourorder;
	var TourType Country Nights LandCost Vendor;
	title 'Tours Sorted by Architecture or Scenic Tours';
run;

/* Page177 - Grouping by More Than One Variable */
proc sort data=mylib.arch_or_scen out=tourorder2;
	by TourType Vendor Landcost;
run;

proc print data=tourorder2;
	var TourType Vendor Landcost Country Nights;
	title 'Tours Grouped by Type of Tour, Vendor, and Price';
run;


/* Page177 - Arranging Groups in Descending Order */
proc sort data=mylib.arch_or_scen out=tourorder3;
	by descending TourType Vendor LandCost;
run;

proc print data=tourorder3;
	var TourType Vendor Landcost Country Nights;
	title 'Descending order of TourType';
run;

/* Page178 - Finding the First or Last Observation in a Group */
proc sort data=mylib.arch_or_scen out=tourorder4;
	by TourType LandCost;
run;

proc print data=tourorder4;
	var TourType Landcost Country Nights Vendor;
	title 'Tours Arranged by TourType and LandCost';
run;

data temp;
	set tourorder4;
	by TourType;
	FirstTour = first.TourType;
	LastTour = last.TourType;
run;

proc print data=temp;
	var Country TourType FirstTour LastTour;
	title 'Specifying FIRST.TOURTYPE and LAST.TOURTYPE';
run;

proc print data=tourorder4;
	title 'TOURORDER4';
run;

/* Page180 */
proc sort data=mylib.arch_or_scen out=tourorder4;
	by TourType LandCost;
run;

data lowcost;
	set tourorder4;
	by TourType;
	if first.TourType;
run;

proc print data=lowcost;
	title 'Least Expensive Tour for Each Type of Tour';
run;

/* Page */
proc sort data=mylib.arch_or_scen out=bycountry;
	by Country;
run;

proc print data=bycountry;
	title 'Tours in Alphabetical Order by Country';
run;

/* Page182 - Deleting Duplicate Observations */
data mylib.arch_or_scen2;
	infile '/home/u58907790/sasuser.v94/excel_files/arch_or_scen2' truncover;
	input Country $1-11 TourType $13-24 Nights LandCost Vendor $;
run;

proc print data=mylib.arch_or_scen2;
	title 'Data Set Mylib.arch_or_scen2';
run;

/* Page182 - Deleting Duplicate Observations */
proc sort data=mylib.arch_or_scen out=fixed noduprecs;
	by Country;
run;

proc print data=fixed;
	title 'Data Set FIXED: MYLIB.ARCH_OR_SCEN2 With Duplicates Removed';
run;
	
/* Page184 - Understanding Collating Sequences  */
/* ASCII Collating Sequence */
/* blank < digits < uppercase letters < lowercase letters */

/* EBCDIC Collating Sequence */
/* blank < lowercase letters < uppercase letters < digits */