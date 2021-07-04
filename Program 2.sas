/* Videos from SAS website */

proc print data=sashelp.cars;
	by make;   /*group by make */
	var make model type;   /* columns */
run;


/* Tasks and Utilities -> Tasks -> Statistics -> Summary Statistics */
/* Data; Roles; Options -> Run */
/* Data: SASHELP.CARS; Roles: Weight */



/* Tasks and Utilities -> Tasks -> Graph -> Bar Chart */
/* Data: SASHELP.FISH; Category: Species; Variable: Weight; Statistic: Mean */
/* Appearance: Color, Effect-Sheen, Title: Average Weight for Different Species */



/* Writing a Basic SAS Program */
data europeancars;
	set sashelp.cars;
	where origin='Europe'; /*rows*/
run;

proc print data=europeancars;
run;





data highchol;
	set sashelp.heart;
	where Chol_Status="High";
run;

proc print data=highchol;
run;



/* Assessing Data in SAS Libraries */
/* Create a library */
libname libsas '/home/u58907790/sasuser.v94/sas_tables';   /*libref*/

data libsas.europeancars;
	set sashelp.cars;
	where Origin="Europe";
run;

proc print data=libsas.europeancars;
run;





/* Creating a SAS Table from a CSV File */
data car;
	infile "/home/u58907790/sasuser.v94/excel_files/CARS.csv" dlm=',' firstobs=2;
	input Make $ Model $ Type $ Origin $ DriveTrain $ EngineSize Cylinders Horsepower MPG_City MPG_Highway Weight Wheelbase Length;
RUN;




/* Working in SAS Studio */
/* Tasks -> Data -> List Data -> Data: SASHELP.BASEBALL, List Var:Name,Team,Salary, Group:Team */
/* Open a new SAS program -> Snippets -> HBar Plot -> Add to my Snippets(Top of the working area)

/*--HBar Plot--*/
title 'Average Salary by Team';
proc sgplot data=sashelp.baseball ;
  hbar team / response=salary  stat=mean;
  yaxis display=(nolabel) grid;
  xaxis display=(nolabel);
  run;



/* Using the Import Data Utility in SAS Studio */
/* Way1: Tasks and Utilities -> Utilities -> Import Data -> Server Files and Folders -> Select File and drag*/
/* Way2: Find the file in Server Files and Folders -> Rightclick Import Data */
/* Then use "Settings" */
/* '09'x for tab */



/* Creating a New Column in SAS */
data work.cardata;
	set sashelp.cars;
	Markup=MSRP-Invoice;   /*Assignment statement*/
run;



/* Merging SAS Tables in a Data Step */
/* key col: */
/* proc sort data=libsas.testscores out=work.testsort; */
/* 	by IDNumber; */
/* run; */
data work.SATScoreAddress;
	merge libsas.sataddress work.testsort;
	by IDNumber;
run;



/* Filtering a SAS Table in a DATA Step */
data work.highchol;
	set sashelp.heart;
/* 	where Cholesterol>200 and Status="Alive"; */
	where BP_Status="High" or Chol_Status="High";
run;



/* Performing Conditional Logic in SAS */
data bmi_groups;
	set sashelp.heart;
	length BMI_Range $11;
	BMI=(weight/height**2)*703;
	keep weight height bmi bmi_range;
	
	if bmi>=30 then bmi_range="Obese";
	else if bmi>=25 and bmi<30 then bmi_range="Overweight";
	else if bmi>=18.5 and bmi<25 then bmi_range="Normal";
	else bmi_range="Underweight";
run;

data bmi_high bmi_low;
	set sashelp.heart;
	length BMI_Range $11;
	BMI=(weight/height**2)*703;
	keep weight height bmi bmi_range;
	
	if bmi>=30 then do;
		bmi_range="Obese";
		output bmi_high;
	end;
	else if bmi>=25 and bmi<30 then do;
		bmi_range="Overweight";
		output bmi_high;
	end;
	else if bmi>=18.5 and bmi<25 then do; 
		bmi_range="Normal";
		output bmi_low;
	end;
	else do;
		bmi_range="Underweight";
		output bmi_low;
	end;
run;


