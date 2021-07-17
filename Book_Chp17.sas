libname mylib '/home/u58907790/sasuser.v94/sas_tables';

/* proc sort replaces the original data set */

/* Page264 */
data research_development;
	length Department Manager $10;
	input Project $ Department $ Manager $ StaffCount;
	datalines;
MP971 Designing Daugherty 10
MP971 Coding Newton 8
MP971 Testing Miller 7
SL827 Designing Ramirez 8
SL827 Coding Cho 10
SL827 Testing Baker 7
WP057 Designing Hascal 11
WP057 Coding Constant 13
WP057 Testing Slivko 10
;
run;

proc print data=research_development;
	title ’Research and Development Project Staffing’;
run;

data publications;
	length Department Manager $10;
	input Manager $ Department $ Project $ StaffCount;
	datalines;
Cook Writing WP057 5
Deakins Writing SL827 7
Franscombe Editing MP971 4
Henry Editing WP057 3
King Production SL827 5
Krysonski Production WP057 3
Lassiter Graphics SL827 3
Miedema Editing SL827 5
Morard Writing MP971 6
Posey Production MP971 4
Spackle Graphics WP057 2
;
run;

proc sort data=publications;
	by Project;
run;

proc print data=publications;
	title ’Publications Project Staffing’;
run;

/* Page266 - Using the Interleaving Process */
data rnd_pubs;
	set research_development publications;
	by Project;
run;

proc print data=rnd_pubs;
	title ’Project Participation by Research and Development’;
	title2 ’and Publications Departments’;
	title3 ’Sorted by Project’;
run;