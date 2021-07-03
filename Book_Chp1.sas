/* Various Length??? */
data weight_club;
	input IdNumber Name $ 6-20 Team $ 22-27 StartWeight EndWeight;
	Loss = StartWeight - EndWeight;
	datalines;
	1023 David Shaw 	red 189 165
	1049 Amelia Serrano yellow 145 124
	1219 Alan Nance 	red 210 192
	1246 Ravi Sinha 	yellow 194 177
	1078 Ashley McKnight red 127 118
	;
run;


/* Infile datalines delimiter=","; */
data weight_club;
	Infile datalines delimiter=",";
	length Name $14 IdNumber 4;  /*This is needed*/
	input IdNumber Name $ Team $ StartWeight EndWeight;
	Loss = StartWeight - EndWeight;
	datalines;
	1023, David Shaw, red, 189, 165
	1049, Amelia Serrano, yellow, 145, 124
	1219, Alan Nance, red, 210, 192
	1246, Ravi Sinha, yellow, 194, 177
	1078, Ashley McKnight, red, 127, 118
	;
run;

/* How to switch the columns */
proc print data=weight_club;
	title "Health Club Data";
run;


Data test2;
	length str $9;
    Infile datalines delimiter=",";
    Input str $ num;
    datalines;
abcde fghi,0
zyxwvut,1
;
run;

/* Showing mean starting weight, ending weight, loss weight for each team */
proc tabulate data=weight_club;
	class team;
	var StartWeight EndWeight Loss;   
	table team, mean*(StartWeight EndWeight Loss);  /*horizontal split by team; col names are Start...*/
	title "Mean Starting Weight, Ending Weight,";
	title2 "and Weight Loss";
run;

/* If I put sex in table command line, there will be two tables */
/* How to store this table??? */
proc tabulate data=sashelp.class; 
	class sex;
	var age height;
	table (age height)*(N MEAN STD MIN MAX), SEX ALL; 
run;









