libname mylib '/home/u58907790/sasuser.v94/sas_tables';

/* Page213 - Reading a Data Value */
data mylib.tourdates;
	infile '/home/u58907790/sasuser.v94/excel_files/tourdates' truncover;
	input Country $1-11 @13 DepartureDate date9. Nights;
run;

proc print data=mylib.tourdates;
	title 'Tour Departure Dates as SAS Date Values';
run;

/* Page215 - Using Good Programming Practices to Read Dates */
data mylib.tourdates7;
	infile '/home/u58907790/sasuser.v94/excel_files/tourdates' truncover;
	input Country $1-11 @13 DepartureDate date7. Nights;
run;

proc print data=mylib.tourdates7;
	title 'Tour Departure Dates Using the DATA7. Informat';
	title2 'Displayed as Two-Digit Calendar Dates';
	format DepartureDate date7.;
run;

proc print data=mylib.tourdates7;
	title 'Tour Departure Dates Using the DATE7. Informat';
	title2 'Displayed as Four-Digit Calendar Dates';
	format DepartureDate date9.;
run;

/* Page217 - Using Dates as Constants */
data correctdates;
	set mylib.tourdates;
	if Country='Switzerland' then DepartureDate='21jan2001'd;
run;

proc print data=correctdates;
	title 'Corrected Departure Date for Switzerland';
	format DepartureDate date9.;
run;

/* Page218 - Formatting a Date Value */
proc print data=mylib.tourdates;
	title 'Departure Dates in Two-Digit Calendar Format';
	format DepartureDate mmddyy8.;
run;

proc print data=mylib.tourdates;
	title 'Departure Dates in Four-Digit Calendar Format';
	format DepartureDate mmddyy10.;
run;

/* Page219 - Assigning Permanent Date Formats to Variables */
data mylib.fmttourdate;
	set mylib.tourdates;
	format DepartureDate date9.;
run;

proc contents data=mylib.fmttourdate nodetails;
run;

/* Page220 - Changing Formats Temporarily */
proc print data=mylib.tourdates;
	title 'Tour Departure Dates';
	format DepartureDate worddate18.;
run;

/* Page221 - Sorting Dates */
proc sort data=mylib.fmttourdate out=sortdate;
	by DepartureDate;
run;

proc print data=sortdate;
	var DepartureDate Country Nights;
	title 'Departure Dates Listed in Chronological Order';
run;

/* Page222 - Creating New Date Variables */
data home;
	set mylib.tourdates;
	Return = DepartureDate + Nights;
	format Return date9.;
run;

proc print data=home;
	title 'Dates of Departure and Return';
run;

/* Page223 - Finding the Day of the Week */
data pay;
	set mylib.tourdates;
	DueDate = DepartureDate - 30;
	if WeekDay(DueDate) = 1 then DueDate=DueDate-1;
	format DueDate weekdate29.;
run;

proc print data=pay;
	var Country DueDate;
	title 'Date and Day of Week Payment is Due';
run;

/* Page225 - Calculating a Date from Today */
options yearcutoff=1920 pagesize=60 linesize=80 pageno=1 nodate;
data ads;
	set mylib.tourdates;
	now = today();
	if now+90 <= DepartureDate <= now+180;
run;

proc print data=ads;
	title 'Tours Departing between 90 and 180 Days from Today';
	format DepartureDate Now date9.;
run;

/* Page226 - Comparing Duration and SAS Date Values */
data ttage;
	Start = '08feb82'd;
	RightNow=today();
	Age = RightNow-Start;
	format Start RightNow date9.;
run;

proc print data=ttage;
	title 'Age of Tradewinds Travel';
run;

/* Page227 */
data ttage2;
	Start = '08feb82'd;
	RightNow=today();
	AgeInDays = RightNow-Start;
	AgeInYears = AgeInDays/365.25;
	format AgeInYears 4.1 Start RightNow date9.;
run;

proc print data=ttage2;
	title 'Age in Years of Tradewinds Travel';
run;


