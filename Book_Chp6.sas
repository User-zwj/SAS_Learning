/* Page98 - */
options pagesize=60 linesize=80 pageno=1 nodate;
libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.internationaltours;
	input Country $ Nights AirCost LandCost Vendor $;
	datalines;
France 8 793 575 Major
Spain 10 805 510 Hispania
India 10 . 489 Royal
Peru 7 722 590 Mundial
;

proc print data=mylib.internationaltours;
	title 'Data Set Mylib.internationaltours';
run;

/* Page99 - Making Uniform Changes to Data by Creating a Variable */
data newair;
	set mylib.internationaltours;
	NewAirCost = AirCost + 10;
	
proc print data=newair;
	var Country AirCost NewAirCost;
	title 'Incresing the Air Fare by $10 for All Tours';
run;

/* Page100 - Adding Information to Some Observations but Not Others */
options pagesize=60 linesize=80 pageno=1 nodate;
data bonus;
	set mylib.internationaltours;
	if Vendor = 'Hispania' then BonusPoints = 'For 10+ people';
	else if Vendor = 'Mundial' then BonusPoints = 'Yes';
run;

proc print data=bonus;
	var Country Vendor BonusPoints;
	title1 'Adding Information to Observations for';
	title2 'Vendors Who Award Bonus Points';
run;

/* Page101 - Making Uniform Changes to Data Without Creating Variables */
options pagesize=60 linesize=80 pageno=1 nodate;
data newair2;
	set mylib.internationaltours;
	AirCost = AirCost + 10;
run;

proc print data=newair2;
	var Country AirCost;
	title 'Adding Tax to the Air Cost Without Adding a New Variable';
run;

/* Page102 - Using Variables Efficiently */
/* Inefficient use of variables */
data tourinfo;
	set mylib.internationaltours;
	if Vendor = 'Hispania' then BonusPoints = 'For 10+ people';
	else if Vendor = 'Mundial' then BonusPoints = 'Yes';
	else if Vendor = 'Major' then Discount = 'For 30+ people';
run;	
proc print data=tourinfo;
	var Country Vendor BonusPoints;
	title 'Information About Vendors';
run;

/* Efficient use of variables */
data newinfo;
	set mylib.internationaltours;
	if Vendor = 'Hispania' then Remarks = 'Bonus for 10+ people';
	else if Vendor = 'Mundial' then Remarks = 'Bonus points';
	else if Vendor = 'Major' then Remarks = 'Discount: 30+ people';
run;	
proc print data=newinfo;
	var Country Vendor Remarks;
	title 'Information About Vendors';
run;

/* Page103 - Defining Enough Storage Space for Variables */
data newlength;
	set mylib.internationaltours;
	length Remarks $ 30;
	if Vendor = 'Hispania' then Remarks = 'Bonus for 10+ people';
	else if Vendor = 'Mundial' then Remarks = 'Bonus points';
	else if Vendor = 'Major' then Remarks = 'Discount: 30+ people';
run;	
proc print data=newlength;
	var Country Vendor Remarks;
	title 'Information About Vendors';
run;

/* Page104 - Conditionally Deleting an Observation */
data subset;
	set mylib.internationaltours;
	if 'Country'='Peru' then delete;
run;
proc print data=mylib.internationaltours;
/* 	var Country Vendor; */
	title 'Omitting a Discontinued Tour';
run;




