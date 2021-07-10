libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.attractions;
	infile '/home/u58907790/sasuser.v94/excel_files/attractions' truncover;
	input City $1-9 Museums 11 Galleries 13 Other 15 TourGuide $17-24 YearsExperience 26;
run;

proc print data=mylib.attractions;
	title 'Data set mylib.attractions';
run;

/* Page202 - Performing More Than One Action in an IF-THEN statement */
data updatedattractions;
	set mylib.attractions;
	if City='Madrid' then Museums=3;
	if CIty='Madrid' then Other=2;
	if City='Amsterdam' then TourGuide='Vandever';
	if City='Amsterdam' then YearsExperience=4;
run;

proc print data=updatedattractions;
	title 'Updated Data set mylib.attractions';
run;

/* Page203 */
data updatedattractions2;
	set mylib.attractions;
	if City='Madrid' then 
		do;
			Museums=3;
			Other=2;
		end;
	if City='Amsterdam' then 
		do;
			TourGuide='Vandever';
			YearsExperience=4;
		end;
run;

proc print data=updatedattractions2;
	title 'Updated Data set mylib.attractions';
run;

/* Page206 - Selecting the Current Variable */
data changes;
	set mylib.attractions;
	array changelist{3} Museums Galleries Other;
	do Count=1 to 3;
		if changelist{Count}=. then changelist{Count}=0;
	end;
run;

proc print data=changes;
	title 'Tour Attractions';
run;

/* Page207 */
data changes2(drop=Count);
	set mylib.attractions;
	array changelist{3} Museums Galleries Other;
	do Count=1 to 3;
		if changelist{Count}=. then changelist{Count}=0;
	end;
run;

proc print data=changes2;
	title 'Tour Attractions';
run;

