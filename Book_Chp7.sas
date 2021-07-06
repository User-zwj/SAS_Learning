/* Page109 */
/* New Zealand is not completely displayed */
libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.populartours;
	infile '/home/u58907790/sasuser.v94/excel_files/populartours' dlm=',';
	input Country $ Nights AirCost LandCost Vendor $;
run;

proc print data=mylib.populartours;
	title 'Data Set mylib.populartours';
run;

/* Page110 - Using Arithmetic Operators in Assignment Statements */
data newtour;
	set mylib.populartours;
	TotalCost = AirCost + LandCost;
	PeakAir = AirCost*1.10+8;
	NightCost = LandCost/Nights;
run;

proc print data=newtour;
	var Country Nights AirCost LandCost TotalCost PeakAir NightCost;
	title 'Costs for Tours';
run;

/* Page113 - Combining Functions */
/* Sum will ignore missing values; Sum is different from + */
data moretour;
	set mylib.populartours;
	RoundAir = round(AirCost,50);
	TotalCostR = round(AirCost+LandCost,100);
	CostSum = sum(AirCost,LandCost);
	RoundSum = round(sum(AirCost,LandCost),100);
run;

proc print data=moretour;
	var Country AirCost LandCost RoundAir TotalCostR CostSum RoundSum;
	title 'Rounding and Summing Values';
run;

/* Page114 - Comparing Numeric Variables */
data toursunder2K;
	set mylib.populartours;
	TotalCost = AirCost + LandCost;
	if TotalCost gt 2000 then delete;
run;

proc print data=toursunder2K;
	var Country Nights AirCost LandCost TotalCost Vendor;
	title 'Tours $2000 or less';
run;

data toursunder2K2;
	set mylib.populartours;
	TotalCost = AirCost + LandCost;
	if TotalCost gt 2000 or TotalCost =. then delete;
run;

proc print data=toursunder2K2;
	var Country Nights AirCost LandCost TotalCost Vendor;
	title 'Tours $2000 or less';
run;





