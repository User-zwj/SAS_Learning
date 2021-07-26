libname mylib '/home/u58907790/sasuser.v94/sas_tables';

/* Set: first dominates */
/* Append: force option; Var in 2nd is del; base is replaced by the new*/


/* Page 242 - Using the SET statement */
options pagesize=60 linesize=80 pageno=1 nodate;

data sales;
	input EmployeeID $1-9 Name $11-29 @30 HireDate date9. Salary HomePhone $;
	format HireDate date9.;
	datalines;
429685482 Martin, Virginia   09aug1990 34800 493-0824
244967839 Singleton, MaryAnn 24apr1995 27900 929-2623
996740216 Leighton, Maurice  16dec1993 32600 933-6908
675443925 Freuler, Carl      15feb1998 29900 493-3993
845729308 Cage, Merce        19oct1992 39800 286-0519
;

proc print data=sales;
	title ’Sales Department Employees’;
run;

data customer_support;
	input EmployeeID $1-9 Name $11-29 @30 HireDate date9. Salary HomePhone $;
	format HireDate date9.;
	datalines;
324987451 Sayre, Jay         15nov1994 44800 933-2998
596771321 Tolson, Andrew     18mar1998 41200 929-4800
477562122 Jensen, Helga      01feb1991 47400 286-2816
894724859 Kulenic, Marie     24jun1993 41400 493-1472
988427431 Zweerink, Anna     07jul1995 43700 929-3885
;

proc print data=customer_support;
	title ’Customer Support Department Employees’;
run;

/* Page244 */
data dept1_2;
	set sales customer_support;
run;

proc print data=dept1_2;
	title ’Employees in Sales and Customer Support Departments’;
run;

/* Page245 - Data Sets with different Variables */
data security;
	input EmployeeID $1-9 Name $11-29 Gender $30 @32 HireDate date9. Salary;
	format HireDate date9.;
	datalines;
744289612 Saparilas, Theresa F 09may1998 33400
824904032 Brosnihan, Dylan   M 04jan1992 38200
242779184 Chao, Daeyong      M 28sep1995 37500
544382887 Slifkin, Leah      F 24jul1994 45000
933476520 Perry, Marguerite  F 19apr1992 39900
;

proc print data=security;
	title ’Security Department Employees’;
run;

data dept1_3;
	set sales customer_support security;
run;

proc print data=dept1_3;
	title ’Employees in Sales, Customer Support,’;
	title2 ’and Security Departments’;
run;

/* Page246 - Variables with Different Attributes */
/* Page247 - Variables with different types */
/* EmployeeID is numeric here */
data accounting;
	input EmployeeID 1-9 Name $11-29 Gender $30 @32 HireDate date9. Salary;
	format HireDate date9.;
	datalines;
634875680 Gardinski, Barbara F 29may1998 49800
824576630 Robertson, Hannah  F 14mar1995 52700
744826703 Gresham, Jean      F 28apr1992 54000
824447605 Kruize, Ronald     M 23may1994 49200
988674342 Linzer, Fritz      M 23jul1992 50400
;

proc print data=accounting;
	title ’Accounting Department Employees’;
run;

data dept1_4;
	set sales customer_support security accounting;
run;

/* Page248 - Changing the Type of a Variable */
/* Change the type of EmployeeID from numeric to character */
/* Drop is applied before rename option */
data new_accounting (rename=(a=EmployeeID)drop=EmployeeID); 
	set accounting; 
	a=put(EmployeeID, 9.); 
run;

proc print data=new_accounting;
	title ’New Accounting Department Employees’;
run;

/* The datasets procedure enables you to verify the new attribute type for EmployeeID */
proc datasets library=work; 
	contents data=new_accounting;
run;

/* Page249 -  */
data dept1_4;
	set sales customer_support security new_accounting;
run;

proc print data=dept1_4;
	title ’Employees in Sales, Customer Support, Security,’;
	title2 ’and Accounting Departments’;
run;

/* Page250 - Variables with Different Formats */
/* First data set dominates */
/* HireDate */
data shipping;
	input employeeID $1-9 Name $11-29 Gender $30 @32 HireDate date9. @42 Salary;
	format HireDate date7.
	Salary comma6.;
	datalines;
688774609 Carlton, Susan     F 28jan1995 29200
922448328 Hoffmann, Gerald   M 12oct1997 27600
544909752 DePuis, David      M 23aug1994 32900
745609821 Hahn, Kenneth      M 23aug1994 33300
634774295 Landau, Jennifer   F 30apr1996 32900
;

proc print data=shipping;
	title ’Shipping Department Employees’;
run;

/* Page251 */
data dept1_5;
	set sales customer_support security new_accounting shipping;
run;

proc print data=dept1_5;
	title ’Employees in Sales, Customer Support, Security,’;
	title2 ’Accounting, and Shipping Departments’;
run;

/* Page252 */
/* First data set dominates */
data dept5_1;
	set shipping new_accounting security customer_support sales;
run;

proc print data=dept5_1;
	title ’Employees in Shipping, Accounting, Security,’;
	title2 ’Customer Support, and Sales Departments’;
run;

/* Page253 - Variables with Different Lengths */
/* Name (19 vs 27)*/
data research;
	input EmployeeID $1-9 Name $11-37 Gender $38 @40 HireDate date9. Salary;
	format HireDate date9.;
	datalines;
922854076 Schoenberg, Marguerite     F 19nov1994 39800
770434994 Addison-Hardy, Jonathon    M 23feb1992 41400
242784883 McNaughton, Elizabeth      F 24jul1993 45000
377882806 Tharrington, Catherine     F 28sep1994 38600
292450691 Frangipani, Christopher    M 12aug1990 43900
;

proc print data=research;
	title ’Research Department Employees’;
run;

/* Method1: Make it length 27, put research first */
data dept6_1;
	set research shipping new_accounting security customer_support sales;
run;

/* Method2: Define the length */
data dept1_6a;
	length Name $ 27;
	set sales customer_support security new_accounting shipping research;
run;

proc print data=dept1_6a;
	title ’Employees in All Departments’;
run;

/* Concatenating Data Sets Using the APPEND Procedure */
proc print data=sales;
	title ’Sales Department Employees’;
run;

proc print data=customer_support;
	title ’Customer Support Department Employees’;
run;

proc append base=sales data=customer_support;
run;

proc print data=sales;
	title ’Employees in Sales and Customer Support Departments’;
run;

/* Page257 - Data Sets with Different Variables */
proc print data=sales;       /*There is 'Home Phone' in it*/
	title ’Sales Department Employees’;
run;

proc print data=security;    /*There is 'Gender' in it*/
	title ’Security Department Employees’;
run;

/* Error!!! */
/* proc append base=sales data=security; */
/* run; */

proc append base=sales data=security force;
run;

proc print data=sales;
	title ’Employees in the Sales and the Security Departments’;
run;
