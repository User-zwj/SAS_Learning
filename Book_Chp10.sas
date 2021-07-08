/* Page160 - Input SAS Data Set for Examples */
libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.arts;
	infile '/home/u58907790/sasuser.v94/excel_files/arts' truncover;
	input City $1-9 Nights 11 LandCost 13-16 Budget $18-23 TourGuide $25-32;
run;

proc print data=mylib.arts;
	title 'Data Set Mylib.arts';
run;

/* Page161 - Deleting Observations Based on a Condition */
data remove;
	set mylib.arts;
	if LandCost=. then delete;
;

proc print data=remove;
	title 'Tours with complete land costs';
run;

/* Page162 - Accepting Observations Based on a Condition */
data subset6;
	set mylib.arts;
	if nights=6;
;

proc print data=subset6;
	title 'Six-Night Tours';
run;

/* Page163 - Comparing the DELETE and Subsetting IF Statements */
data lowmed;
	set mylib.arts;
	if upcase(Budget)='HIGH' then delete;
;

proc print data=lowmed;
	title 'Medium and Low Priced Tours';
run;

data lowmed2;
	set mylib.arts;
	if upcase(Budget)='MEDIUM' or upcase(Budget)='LOW';
;

proc print data=lowmed2;
	title 'Medium and Low Priced Tours';
run;

/* Page165 - Example for Conditionally Writing Observations to Multiple Data Sets */
data lucastour othertours;
	set mylib.arts;
	if TourGuide='Lucas' then output lucastour;
		else output othertours;
;

proc print data=lucastour;
	title "Data Set with TourGuide='Lucas'";
	
proc print data=othertours;
	title "Data Set with Other Guides";
run;

/* Page166 - A Common Mistake when Writing to Multiple Data Sets */
data lucastour2 othertour2;
	set mylib.arts;
	if TourGuide='Lucas' then output lucastour2;
run;

proc print data=lucastour2;
	title "Data Set with TourGuide='Lucas'";
	
proc print data=othertours2;
	title "Data Set with Other Guides";
run;
/* No observations are written to OTHERTOUR2 because output was not directed to it. */

/* Page167 - Understanding why the Placement of the Output Statement is Important */
data lucasdays otherdays;
	set mylib.arts;
	if TourGuide='Lucas' then output lucasdays;
		else output otherdays;
	Days = Nights+1;
run;

proc print data=lucasdays;
	title "Number of Days in Lucas' Tours";
	
proc print data=otherdays;
	title "Number of Days in Other Guides' Tours";
run;

/* Page167 */
data lucasdays2 otherdays2;
	set mylib.arts;
	Days = Nights+1;
	if TourGuide='Lucas' then output lucasdays2;
		else output otherdays2;
run;

proc print data=lucasdays2;
	title "Number of Days in Lucas' Tours";
	
proc print data=otherdays2;
	title "Number of Days in Other Guides' Tours";
run;

/* Page168 */
data lucastour othertour weektour daytour;
	set mylib.arts;
	if TourGuide='Lucas' then output lucastour;
		else output othertour;
	if nights>=6 then output weektour;
		else output daytour;
run;

proc print data=lucastour;
	title "Lucas's Tours";
run;

proc print data=othertour;
	title "Other Guides' Tours";
run;

proc print data=weektour;
	title "Tours Lasting a week or more";
run;

proc print data=daytour;
	title "Tours Lasting Less than a week";
run;




