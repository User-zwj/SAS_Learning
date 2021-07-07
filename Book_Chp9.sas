libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.arttours;
	infile '/home/u58907790/sasuser.v94/excel_files/arttours' truncover;
	input City $1-9 Nights 11 LandCost 13-16 NumberOfEvents 18
		EventDescription $20-36 TourGuide $38-45
		BackUpGuide $47-54;
run;

proc print data=mylib.arttours;
	title 'Data Set mylib.arttours';
run;

/* Page142 - Selecting Observations Based on a Simple Condition */
data revise;
	set mylib.arttours;
	if City='Rome' then LandCost = LandCost+30;
	if NumberOfEvents>Nights then Calendar='Check schedule';
	if TourGuide='Lucas' and Nights>7 then TourGuide='Torres';
run;

proc print data=revise;
	var City Nights LandCost NumberOfEvents TourGuide Calendar;
	title 'Tour Information';
run;

/* Page143 - Providing an Alternative Action */
data revise2;
	set mylib.arttours;
	if City='Rome' then LandCost=LandCost+30;
	if NumberOfEvents>Nights then Calendar='Check schedule';
		else Calendar='No problems';
	if TourGuide='Lucas' and Nights>7 then TourGuide='Torres';
run;

proc print data=revise2;
	var City Nights LandCost NumberOfEvents TourGuide Calendar;
	title 'Tour Information';
run;

/* Page144 - Creating a Series of Mutually Exclusive Conditions */
data prices;
	set mylib.arttours;
	if LandCost>=1500 then Price='High  ';
		else if LandCost>=700 then Price='Midum';
			else Price='Low';
run;

proc print data=prices;
	var City LandCost Price;
	title 'Tour Prices';
run;

/* Page146 - Selecting an Observation Based on Simple Conditions */
data changes;
	set mylib.arttours;
	if Nights>=6 then Stay='Week+';
		else Stay='Days';
	if LandCost ne . then Remarks='OK  ';
		else Remarks='Redo';
	if LandCost lt 600 then Budget='Low ';
		else Budget='Medium';
	if NumberOfEvents/Nights>2 then Pace='Too fast';
		else Pace='OK';
run;

proc print data=changes;
	var City Nights LandCost NumberOfEvents Stay Remarks Budget Pace;
	title 'Tour Information';
run;

/* Page147 - Specifying Multiple Comparisons */
data showand;
	set mylib.arttours;
	if City='Paris' and TourGuide='Lucas' then Remarks='Bilingual';
	if 1000<=LandCost<=1500 then Price='1000-1500';
run;

proc print data=showand;
	var City LandCost TourGuide Remarks Price;
	title 'Tour Information';
run;

/* Page148 - When only one Condition Must Be True */
data showor;
	set mylib.arttours;
	if LandCost gt 1500 or LandCost/Nights gt 200 then Level='Deluxe';
run;

proc print data=showor;
	var City LandCost Nights Level;
	title 'Tour Information';
run;

/* Page149 - Using Negative Operators with AND or OR */
data test;
	set mylib.arttours;
	if TourGuide ne BackUpGuide or TourGuide ne ' ' then GuideCheckUsingOR = 'OK';
		else GuideCheckUsingOR = 'No';
	if TourGuide ne BackUpGuide and TourGuide ne ' ' then GuideCheckUsingAND = 'OK';
		else GuideCheckUsingAND = 'No';
run;

proc print data=test;
	var City TourGuide BackUpGuide GuideCheckUsingOR GuideCheckUsingAND;
	title 'Negative Operators with OR and AND';
run;

/* Page 150 - Using Complex Comparisons that Require AND and OR */
data combine;
	set mylib.arttours;
	if (City='Paris' or City='Rome') and (TourGuide='Lucas' or TourGuide="D'Amico") then Topic='Art History';
run;

proc print data=combine;
	var City TourGuide Topic;
	title 'Tour Information';
run;

/* Page151 - Abbreviating Numeric Comparisons */
data morecomp;
	set mylib.arttours;
	if LandCost then Remarks='Ready to budget';
		else Remarks='Need land cost';
	if Nights=6 or Nights=8 then Stay='Medium';
		else Stay='Short';
run;

proc print data=morecomp;
	var City Nights LandCost Remarks Stay;
	title 'Tour Information';
run;

/* Page152 - Comparing Uppercase and Lowercase Characters */
data newguide;
	set mylib.arttours;
	if upcase(City)='MADRID' then TourGuide='Balarezo';
run;

proc print data=newguide;
	var City TourGuide;
	title 'Tour Guides';
run;

/* Page153 - Selecting All Values that Begin with the Same Group of Characters */
data dguide;
	set mylib.arttours;
	if TourGuide =: 'D' then Chosen ='Yes';
		else Chosen='No';
run;

proc print data=dguide;
	var City TourGuide Chosen;
	title 'Guides Whose Names Begin with D';
run;

/* Page154 - Selecting a Range of Character Values */
data guidegrp;
	set mylib.arttours;
	if TourGuide <=: 'L' then TourGuideGroup = 'A-L';
		else TourGuideGroup = 'M-Z';
run;

proc print data=guidegrp;
	var City TourGuide TourGuideGroup;
	title 'Tour Guide Groups';
run;

/* Page155 - Finding a Value Anywhere within Another Character Value */
data otherevent;
	set mylib.arttours;
	if index(EventDescription, 'other') then OtherEvents='Yes';
		else OtherEvents='No';
run;

proc print data=otherevent;
	var City EventDescription OtherEvents;
	title 'Tour Events';
run;



