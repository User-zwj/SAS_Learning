/* Missing numeric: period */
/* Missing character: blank */


/* Raw data -> SAS data set */
/* "Input" -> Read 1st raw data to input buffer -> execute the assignment statement -> Write 1st obs to data set*/
/* Loop back, start next iteration, _N_ & _ERROR_ & set to missing values */


/* Page34: Styles of Input */
/* 1. List Input */
data scores;
	Infile datalines delimiter=" ";    /*why not working???*/
	Length Name $7;
	input Name $ Test_1 Test_2 Test_3;
	datalines;
	Bill 	187	97 103
	Carlos 	156 76 74
	Monique	99 	102	129
	;
run;


data scores;
	infile datalines delimiter=',';
	input Name $ Test_1 Test_2 Test_3;
	datalines;
	Bill, 187, 97, 103
	Carlos, 156, 76, 74
	Monique, 99, 102, 129
	;
run;


/* 2. Column input */
data scores;
	input Name $ 1-7 Test_1 9-11 Test_2 13-15 Test_3 17-19;
	datalines;
	Bill    187 97  103
	Carlos  156 76  74
	Monique 99  102 129
	;
run;


/* 3. Formatted input */
data total_sales;
	input Date mmddyy10. +2 Amount comma5.;
	datalines;    /*Indent or not????*/
09/05/2000 1,382
10/19/2000 1,235
11/30/2000 2,391
	;
run;


/* Page36: Indicating the Locatin of Your Data */
/* 1. Raw Data in the Job Stream (datalines statement)*/
data weight_club;
	input IdNumber 1-4 Name $6-24 Team $ StartWeight EndWeight;
	Loss = StartWeight - EndWeight;
	datalines;
	1023 David Shaw          red    189 165
	1049 Amelia Serrano      yellow 145 124
	1219 Alan Nance          red    210 192
	1246 Ravi Sinha          yellow 194 177
	1078 Ashley McKnight     red    127 118
	;
run;

data weight_club;
	input IdNumber 1-4 Name $6-24 Team $25-32 StartWeight EndWeight;
	Loss = StartWeight - EndWeight;
	datalines;
	1023 David Shaw          red      189 165
	1049 Amelia Serrano      yellow   145 124
	1219 Alan Nance          red      210 192
	1246 Ravi Sinha          yellow   194 177
	1078 Ashley McKnight     red      127 118
	;
run;

/* 2. Data in an External File */
data cars;
	infile "/home/u58907790/sasuser.v94/excel_files/salary.csv" delimiter=',';
	input employee $1-7 salary;    /*???*/
run;
	
/* 3. Data in a SAS Data Set */
/* Statement: SET, MERGE, MODIFY, UPDATE */
data red;
	set weight_club;
	LossPercent = Loss/StartWeight*100;
run;

/* 4. Data in a DBMS File */


/* infile or filename+infile */
/* filename fitclub ’your-input-file’; */
/* data temp; */
/* 	infile fitclub; */
/* 	input IdNumber $ 1-4 Name $ 6-23 StartWeight 24-26 EndWeight 28-30; */
/* run; */






