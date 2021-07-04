/* YouTube Video */

/* 13:50 */
data test;
name = "word";
run;


/* 29:20 */
data employee_details;
input name $6. Salary;
datalines;
sameer	123
kumar	2349
Johan	1209
Rocky	1232
;
run;



/* 30:44 */
data inlib.first_data;
input employee $6. salary;
datalines;
sameer	123
kumar	2349
Johan	1209
Rocky	1232
;
run;



/* 34:40 */
/* Save things in libraries */
/* Library: collection of sas tables */
/* Create TEST1 */
/* Libraries -> Name:TEST1 -> Path:/home/u58907790/sasuser.v94/sas_tables */
data TEST1.employee_details;
input name $6. Salary;
datalines;
sameer	123
kumar	2349
Johan	1209
Rocky	1232
;
run;



/* 36:25 */
/* Fail to upload data using Safari, success with Chrome */
proc import datafile="/home/u58907790/sasuser.v94/excel_files/Categories.xlsx"
	out=cat
	dbms=xlsx replace;
	sheet="categories";
run;



/* 40:50 */
/* Reading a data in SAS */
/* Assign library named inlib in Libraries*/
libname inlib "/home/u58907790/sasuser.v94/sas_tables";


/* 42:05 */
data test;
set inlib.employee_details;
run;


/* Questions: How to generate .sas7 file; how to put the sas data in a specific library */


data orderdetails;



/* 43:06 */
/* How to get this mylib.orderdetails */
proc import datafile="/home/u58907790/sasuser.v94/excel_files/Order_Details.xlsx"
	out=mylib.OrderDetails(drop=price)
	dbms=xlsx replace;
	sheet="OrderDetails";
run;



