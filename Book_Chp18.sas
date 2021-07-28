libname mylib '/home/u58907790/sasuser.v94/sas_tables';

/* merge data1(drop=var1rename=(var2=var3)) */

/* Performing a Simple One-to-One Merge */
data class;
	input Name $ 1-25 Year $ 26-34 Major $ 36-50;
	datalines;
Abbott, Jennifer         first
Carter, Tom              third     Theater
Kirby, Elissa            fourth    Mathematics
Tucker, Rachel           first
Uhl, Roland              second
Wacenske, Maurice        third     Theater
;

proc print data=class;
	title ’Acting Class Roster’;
run;

data time_slot;
	input Date date9. @12 Time $ @19 Room $;
	format date date9.;
	datalines;
14sep2000  10:00  103
14sep2000  10:30  103
14sep2000  11:00  207
15sep2000  10:00  105
15sep2000  10:30  105
17sep2000  11:00  207
;

proc print data=time_slot;
	title ’Dates, Times, and Locations of Conferences’;
run;

/* proc print data=class; */
/* 	title ’Acting Class Roster’; */
/* run; */

/* Page272 - One-to-One Merge */
data schedule;
	merge class time_slot;
run;

proc print data=schedule;
	title ’Student Conference Assignments’;
run;

/* Page273 - One-to-One Merge on Data Sets with the Same Variables */
data class2;
	input Name $1-25 Year $26-34 Major $36-50;
	datalines;
Hitchcock-Tyler, Erin    second
Keil, Deborah            third     Theater
Nacewicz, Chester        third     Theater
Norgaard, Rolf           second
Prism, Lindsay           fourth    Anthropology
Singh, Rajiv             second
Wittich, Stefan          third     Physics
;

proc print data=class2;
	title ’Acting Class Roster’;
	title2 ’(second section)’;
run;

proc print data=class;
	title ’Acting Class Roster’;
run;

/* Page274 */
data exercise;
	merge class (drop=Year Major)
			class2 (drop=Year Major rename=(Name=Name2))
			time_slot;
run;

proc print data=exercise;
	title ’Acting Class Exercise Schedule’;
run;

/* Page276 - Match-Merging */
/* Merging with a BY Statement */
/* Sort first!!! */
data company;
	input Name $1-25 Age 27-28 Gender $30;
	datalines;
Vincent, Martina          34 F
Phillipon, Marie-Odile    28 F
Gunter, Thomas            27 M
Harbinger, Nicholas       36 M
Benito, Gisela            32 F
Rudelich, Herbert         39 M
Sirignano, Emily          12 F
Morrison, Michael         32 M
;

proc sort data=company;
	by Name;
run;

data finance;
	input IdNumber $ 1-11 Name $ 13-40 Salary;
	datalines;
074-53-9892 Vincent, Martina             35000
776-84-5391 Phillipon, Marie-Odile       29750
929-75-0218 Gunter, Thomas               27500
446-93-2122 Harbinger, Nicholas          33900
228-88-9649 Benito, Gisela               28000
029-46-9261 Rudelich, Herbert            35000
442-21-8075 Sirignano, Emily             5000
;

proc sort data=finance;
	by Name;
run;

proc print data=company;
	title ’Little Theater Company Roster’;
run;

proc print data=finance;
	title ’Little Theater Employee Information’;
run;		

/* Page278 */
data employee_info;
	merge company finance;
	by name;
run;

proc print data=employee_info;
	title ’Little Theater Employee Information’;
	title2 ’(including personal and financial information)’;
run;

/* Page279 - Match-Merging Data Sets with Multiple Observations in a BY Group */
data repertory;
	input Play $ 1-23 Role $ 25-48 IdNumber $ 50-60;
	datalines;
No Exit                 Estelle                  074-53-9892
No Exit                 Inez                     776-84-5391
No Exit                 Valet                    929-75-0218
No Exit                 Garcin                   446-93-2122
Happy Days              Winnie                   074-53-9892
Happy Days              Willie                   446-93-2122
The Glass Menagerie     Amanda Wingfield         228-88-9649
The Glass Menagerie     Laura Wingfield          776-84-5391
The Glass Menagerie     Tom Wingfield            929-75-0218
The Glass Menagerie     Jim O'Connor             029-46-9261
The Dear Departed       Mrs. Slater              228-88-9649
The Dear Departed       Mrs. Jordan              074-53-9892
The Dear Departed       Henry Slater             029-46-9261
The Dear Departed       Ben Jordan               446-93-2122
The Dear Departed       Victoria Slater          442-21-8075
The Dear Departed       Abel Merryweather        929-75-0218
;

proc print data=repertory;
	title ’Little Theater Season Casting Assignments’;
run;

proc sort data=finance;
	by IdNumber;
run;

proc sort data=repertory;
	by IdNumber;
run;

proc print data=finance;
	title ’Little Theater Employee Information’;
	title2 ’(sorted by employee ID number)’;
run;

proc print data=repertory;
	title ’Little Theater Season Casting Assignments’;
	title2 ’(sorted by employee ID number)’;
run;

data repertory_name;
	merge finance repertory;
	by IdNumber;
run;

proc print data=repertory_name;
	title ’Little Theater Season Casting Assignments’;
	title2 ’with employee financial information’;
run;

/* Page284 - Match-Merging Data Sets with Dropped Variables */
data newrep (drop=IdNumber);
	merge finance (drop=Salary) repertory;
	by IdNumber;
run;

proc print data=newrep;
	title ’Final Little Theater Season Casting Assignments’;
run;

/* Match-Merging Data Sets with the Same Variables */
/* Match-Merging Data Sets That Lack a Common Variable */
options linesize=120;
/* Sort FINANCE and COMPANY by Name */
proc sort data=finance;
	by Name;
run;

proc sort data=company;
	by Name;
run;

/* Merge COMPANY and FINANCE into a */
/* temporary data set. */
data temp;
	merge company finance;
	by Name;
run;

proc sort data=temp;
	by IdNumber;
run;

/* Merge the temporary data set with REPERTORY */
data all;
	merge temp repertory;
	by IdNumber;
run;

proc print data=all;
	title ’Little Theater Complete Casting Information’;
run;

/* Choosing between One-to-One Merging and Match-Merging */
data company2;
	input name $ 1-25 age 27-28 gender $ 30;
	datalines;
Benito, Gisela            32 F
Gunter, Thomas            27 M
Harbinger, Nicholas       36 M
Phillipon, Marie-Odile    28 F
Rudelich, Herbert         39 M
Sirignano, Emily          12 F
Vincent, Martina          34 F
;

proc print data=company2;
	title ’Little Theater Company Roster’;
run;

proc print data=finance;
	title ’Little Theater Employee Information’;
run;

/* One-to-one merge */
data one_to_one;
	merge company2 finance;
run;

proc print data=one_to_one;
	title ’Using a One-to-One Merge to Combine’;
	title2 ’COMPANY2 and FINANCE’;
run;

/* Match-merge */
data match;
	merge company2 finance;
	by name;
run;

proc print data=match;
	title ’Using a Match-Merge to Combine’;
	title2 ’COMPANY2 and FINANCE’;
run;

/* When to Use a Match-Merge */
proc print data=company;
	title ’Company data set’;
run;

proc print data=finance;
	title ’Finance data set’;
run;

data badmerge;
	merge company finance;
run;

proc print data=badmerge;
	title ’Using a One-to-One Merge Instead of a Match-Merge’;
run;

