/* 4 Starting with Raw Data: Beyond the Basics */

/* Page62 - Trailing @-sign */
/* Testing a Condition before Creating an Observation */
data red_team;
	input Team $ 13-18 @;
	if Team='red';
	input IdNumber 1-4 StartWeight 20-22 EndWeight 24-26;
	datalines;
1023 David  red    189 165
1049 Amelia yellow 145 124
1219 Alan   red    210 192
1246 Ravi   yellow 194 177
1078 Ashley red    127 118
1221 Jim    yellow 220 .
;
proc print data=red_team;
	title 'Red Team';
run;

/* Page63 - Double Trailing @-sign */
/* Creating Multiple Observations from a Single Record */
data body_fat;
	input Gender $ PercentFat @@;
	datalines;
m 13.3 f 22
m 22   f 23.2
m 16   m 12
;

proc print data=body_fat;
	title 'Results of Body Fat Testing';
run;

/* Reading Multiple Records to Create a Single Observation */
/* Method1: Using Multiple Input Statements */
data club2;
	input IdNumber 1-4;
	input;
	input StartWeight 1-3 EndWeight 5-7;
	datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow 
145 124
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220 .
;

proc print data=club2;
	title 'Weight Club Members';
run;

/* Method2: Using the / line-pointer Control */
data club2;
	input IdNumber 1-4 / / StartWeight 1-3 EndWeight 5-7;
	datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow 
145 124
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220 .
;

proc print data=club2;
	title 'Weight Club Members';
run;

/* Reading Variables from Multiple Records in Any Order */
/* One row indicates one record */
data club2;
	input #2 Team $ 1-6 #1 Name $6-23 IdNumber 1-4
		#3 StartWeight 1-3 EndWeight 5-7;
	datalines;
1023 David Shaw
red
189 165
1049 Amelia Serrano
yellow 
145 124
1219 Alan Nance
red
210 192
1246 Ravi Sinha
yellow
194 177
1078 Ashley McKnight
red
127 118
1221 Jim Brown
yellow
220 .
;

proc print data=club2;
	title 'Weight Club Members';
run;

/* Problem Solving: When an Input Record Unexpectedly Does Not Have Enough Values */
/* Four Options */
/* infile 'your-external-file' flowover; */
/* infile 'your-external-file' stopover; */
/* infile 'your-external-file' missover; */
/* infile 'your-external-file' truncover; */




