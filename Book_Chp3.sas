/* 3 Input styles: list, column, formatted */

/* Page45 - Program: Basic List Input */
data club1;
	input IdNumber Name $ Team $ StartWeight EndWeight;
	datalines;
	1023 David red 189 165
	1049 Amelia yellow 145 124
	1219 Alan red 210 192
	1246 Ravi yellow 194 177
	1078 Ashley red 127 118
	1221 Jim yellow 220 .
	;
	
proc print data = club1;
	title "Weight of Club Members";
run;

/* Page46 - Program: When the Data is Delimited by Characters, Not Blanks */
options pagesize=60 linesize=80 pageno=1 nodate;   /*Use???*/
data club1;
	infile datalines dlm=",";
	input IdNumber Name $ Team $ StartWeight EndWeight;
	datalines;
	1023,David,red,189,165
	1049,Amelia,yellow,145,124
	1219,Alan,red,210,192
	1246,Ravi,yellow,194,177
	1078,Ashley,red,127,118
	1221,Jim,yellow,220,.
	;
	
proc print data = club1;
	title "Weight of Club Members";
run;

/* Page47 - Program: Reading Data Aligned in Columns */
/* Note that with column input you are not required to indicate missing values with a placeholder such as a period. */
data club1;
	input IdNumber 1-4 Name $ 6-11 Team $ 13-18 StartWeight 20-22 EndWeight 24-26;
	datalines;
	1023 David  red    189 165
	1049 Amelia yellow 145 124
	1219 Alan   red    210 192
	1246 Ravi   yellow 194 177
	1078 Ashley red    127 118
	1221 Jim    yellow 220 
	;
	
proc print data=club1;
	title "Weight of Club Members";
run;

/* Page48 - Reading Embedded Blanks and Creating Longer Variables */
data club2;
	input IdNumber 1-4 Name $ 6-23 Team $ 25-30 StartWeight 32-34 EndWeight 36-38;
	datalines;
	1023 David Shaw         red    189 165
	1049 Amelia Serrano     yellow 145 124
	1219 Alan Nance         red    210 192
	1246 Ravi Sinha         yellow 194 177
	1078 Ashley McKnight    red    127 118
	1221 Jim Brown          yellow 220
	;
	
proc print data=club2;
	title "Weight Club Members";
run;

/* Page49 - Program: Skipping Fields When Reading Data Records */
data club2;
	input Team $ 25 Name $6-23 StartWeight 32-34 EndWeight 36-38;
	datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220
;
	
proc print data=club2;
	title "Weight Club Members";
run;

/* Page50 - Program: Reading Data that Requires Special Instructions */
/* The numbers don't correspond??? No tab will be correct */
data january_sales;
	input Item $ 1-16 Amount comma5.;
	datalines;
trunks          1,382
vans            1,235
sedans          2,391
;
	
proc print data=january_sales;
	title 'January Sales in Thousands';
run;

/* Page52: Understanding How to Control the Position of the Pointer */
/* Absolute column-pointer control @17 */
data january_sales;
	input Item $10. @17 Amount comma5.;
	datalines;
trunks          1,382
vans            1,235
sedans          2,391
;
	
proc print data=january_sales;
	title 'January Sales in Thousands';
run;

/* Relative column-pointer control +6 */
data january_sales;
	input Item $10. +6 Amount comma5.;
	datalines;
trunks          1,382
vans            1,235
sedans          2,391
;
	
proc print data=january_sales;
	title 'January Sales in Thousands';
run;

/* Page53 -  colon format modifier: longer variables & numeric data with special characters*/
data january_sales;
	input Item : $12. Amount : comma5.;
	datalines;
Trunks 1,381
Vans 1,235
Sedans 2,391
SportUtility 987
;

/* Page54 - ampersand format modifier: character data with embedded blanks */
/* The data lines must have two blank spaces between the values for the variable Name and the variable Team */
data club2;
	input IdNumber Name & $18. Team $ StartWeight EndWeight;
	datalines;
1023 David Shaw  red 189 165
1049 Amelia Serrano  yellow 145 124
1219 Alan Nance  red 210 192
1246 Ravi Sinha  yellow 194 177
1078 Ashley McKnight  red 127 118
1221 Jim Brown  yellow 220 .
;

proc print data=club2;
	title "Weight Club Members";
run;

/* Page55 - An Example of Mixed Input */
data club1;
	input IdNumber
		Name $18.
		Team $25-30
		StartWeight EndWeight;
	datalines;
1023 David Shaw         red    189 165
1049 Amelia Serrano     yellow 145 124
1219 Alan Nance         red    210 192
1246 Ravi Sinha         yellow 194 177
1078 Ashley McKnight    red    127 118
1221 Jim Brown          yellow 220 .
;

proc print data=club1;
	title "Weight Club Members";
run;

/* Page 56 - Pointer location with column and formatted input */
data scores;
	input Team $ 1-6 Score 12-13;
	datalines;
red        59
blue       95
yellow     63
green      76
;

proc print data=scores;
	title "Colors";
run;

/* It is still correct without "+5" or "@12" */
data scores;
	input Team $6. @12 Score 12-13;
	datalines;
red        59
blue       95
yellow     63
green      76
;

proc print data=scores;
	title "Colors";
run;


/* Currency sign */
data money;
	input ID Money dollar5.;
	datalines;
1 $1000
2 $1200
3 $2913
;

proc print data=money;
	title 'Cash';
run;
