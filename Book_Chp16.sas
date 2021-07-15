libname mylib '/home/u58907790/sasuser.v94/sas_tables';

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
/* Page247 -  */