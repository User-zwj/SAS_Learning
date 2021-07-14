libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data data1;
	input Year;
	datalines;
1996
1997
1998
1999
2000
;

data data2;
	input Year;
	datalines;
1996
1997
1998
1999
2000
;

proc print data=data1;
	title 'DATA1';
run;

proc print data=data2;
	title 'DATA2';
run;

/* ------------------- */
data data1;
	input Year;
	datalines;
1995
1996
1997
1998
1999
;

data data2;
	input Year;
	datalines;
1996
1997
1998
1999
2000
;

/* Page234 - Concatenating */
data combined;
	set data1 data2;
run;

proc print data=combined;
	title 'Set without by';
run;

/* Page235 - Interleaving */
data combined2;
	set data1 data2;
	by Year;
run;

proc print data=combined2;
	title 'Set with by';
run;

data data1;
	input VarX;
	datalines;
1
2
3
4
5
;

data data2;
	input VarY;
	datalines;
11
22
33
44
55
;

/* Page235 - Merging */
data combined3;
	merge data1 data2;
run;

proc print data=combined3;
	title 'Merge without by';
run;

/* Page236 - Match-Merging */
data data1;
	input Year VarX $2.;
	datalines;
1996 X1
1997 X2
1998 X3
1999 X4
2000 X5
;

data data2;
	input Year VarY $2.;
	datalines;
1996 Y1
1996 Y2
1998 Y3
1999 Y4
2000 Y5
;

data combined4;
	merge data1 data2;
	by Year;
run;

proc print data=combined4;
	title 'Merge with By';
run;

/* Page Update */
data master;
	input Year VarX $2. +1 VarY $2.;
	datalines;
1990 X1 Y1
1991 X1 Y1
1992 X1 Y1
1993 X1 Y1
1994 X1 Y1
1995 X1 Y1
1996 X1 Y1 
1997 X1 Y1
1998 X1 Y1
;

data transaction;
	input Year VarX $2. +1 VarY $2.;
	datalines;
1996 X2  
1997 X2 Y2
1998 X2 
1998    Y2
2000 X2 Y2
;

data combined5;
	update master transaction;
	by Year;
run;

data master;
	modify master transaction;
	by Year;
run;

proc print data=combined5;
	title 'Update with by';
run;

/* Output is different!!! */
proc print data=master;
	title 'Modify with by';
run;




