/* Page120 - Input SAS Data Set for Examples */
libname mylib '/home/u58907790/sasuser.v94/sas_tables';

data mylib.departures;
	input Country $ 1-9 CitiesInTour 11-12 USGate $14-26
		ArrivalDepartureGates $28-48;
	datalines;
Japan     5  San Francisco Tokyo, Osaka
Italy     8  New York      Rome, Naples
Australia 12 Honolulu      Sydney, Brisbane
Venezuela 4  Miami         Caracas, Maracaibo
Brazil    4                Rio de Janeiro, Belem
;

proc print data=mylib.departures;
	title 'Data Set AIR.DEPARTURES';
run;

/* Page122 -  */
data charvars;
	set mylib.departures;
	Schedule = '3-4 tours per season';
	Remarks = "See last year's schedule";
	if USGate = 'San Francisco' then Airport = 'SFO';
	else if USGate = 'Honolulu' then Airport = 'HNL';
run;
/* noobs option suppresses the display of observation number */
proc print data=charvars noobs;
	var Country Schedule Remarks USGate Airport;
	title 'Tours By City of Departure';
run;

/* Page123 */
data aircode;
	set mylib.departures;
	if USGate = 'San Francisco' then Airport = 'SFO';
	else if USGate = 'Honolulu' then Airport = 'HNL';
	else if USGate = 'New York' then Airport = 'JFK or LGA';
run;

proc print data=aircode;
	var Country USGate Airport;
	title 'Country by US Point of Departure';
run;

/* Page124 */
data aircode2;
	length Airport $10;
	set mylib.departures;
	if USGate = 'San Francisco' then Airport = 'SFO';
	else if USGate = 'Honolulu' then Airport = 'HNL';
	else if USGate = 'New York' then Airport = 'JFK or LGA';
	else if USGate = 'Miami' then Airport = 'MIA';
run;

proc print data=aircode2;
	var Country USGate Airport;
	title 'Country by US Point of Departure';
run;

/* Page125 - Checking for Missing Character Values */
data checkgate;
	length GateInformation $15;
	set mylib.departures;
	if USGate=' ' then GateInformation = 'Missing';
	else GateInformation = 'Available';
run;

proc print data=checkgate;
	var Country CitiesIntour USGate ArrivalDepartureGates GateInformation;
	title 'Checking For Missing Gate Information';
run;

/* Page126 - Setting a Character Variable Value to Missing */
data departuredays;
	set mylib.departures;
	length DayOfDepartures $8;
	if CitiesInTour <= 7 then DayOfDeparture = 'Sunday';
	else DayOfDeparture = ' ';
run;

proc print data=departuredays;
	var Country CitiesInTour DayOfDeparture;
	title 'Departure Day is Sunday or Missing';
run;

/* Page127 - Extractinga Portion of a Character Value */
/* Page128 - Aligning New Values */
/* Note: The default length of a target variable where the expression contains */
/* the SCAN function is 200 bytes. */
data gates;
	length ArrivalGate $14 DepartureGate $9;
	set mylib.departures;
	ArrivalGate = scan(ArrivalDepartureGates,1,',');
	DepartureGate = left(scan(ArrivalDepartureGates,2,','));
run;

proc print data=gates;
	var Country ArrivalDepartureGates ArrivalGate DepartureGate;
	title 'Arrival and Departure Gates';
run;

/* Page130 - Performing a Simple Concatenation */
data all;
	set mylib.departures;
	AllGate = USGate || ArrivalDepartureGates;
run;

proc print data=all;
	var Country USGate ArrivalDepartureGates AllGate;
	title 'All Tour Gates';
run;

/* Page130 - Removing Interior Blanks */
data all2;
	set mylib.departures;
	AllGate2 = trim(USGate) || ArrivalDepartureGates;
run;

proc print data=all2;
	var Country USGate ArrivalDepartureGates AllGate2;
	title 'All Tour Gates';
run;

/* Page132 - Adding Additional Characters */
data all3;
	set mylib.departures;
	AllGate3 = trim(USGate) || ', ' || ArrivalDepartureGates;
	if Country = 'Brazil' then AllGate3 = ArrivalDepartureGates;
run;

proc print data=all3;
	var Country USGate ArrivalDepartureGates AllGate3;
	title 'All Tour Gates';
run;

/* Page134 -  */
/* Remove length won't affect the other output */
data gates3;
/* 	length ADGates $30; */
	set gates;
	ADGates = trim(ArrivalGate) || ', ' || DepartureGate;
	ADLength = vlength(ADGates);
run;

proc print data=gates3;
	var Country ArrivalDepartureGates ADGates ADLength;
	title 'All Tour Gates';
run;

/* Page134 - Saving Storage Space by Treating Numbers as Characters */
/* why three rows are missing after adding the test row */
data hotels;
	input Country $1-9 HotelRank $11 LandCost test;
/* 	test = HotelRank + 1; */
	datalines;
Italy     2 498
Italy     4 698
Australia 2 915
Australia 3 1169
Australia 4 1399
;
run;

proc print data=hotels;
	title 'Hotel Rankings';
run;


