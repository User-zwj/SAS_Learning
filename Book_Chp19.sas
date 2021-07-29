libname mylib '/home/u58907790/sasuser.v94/sas_tables';

/* Page295 - Update */
options pagesize=60 linesize=80 pageno=1 nodate;
data mail_list;
	input SubscriberId 1-8 Name $ 9-27 StreetAddress $ 28-47 City $ 48-62
		StateProv $ 63-64 PostalCode $ 67-73 Country $ ;
	datalines;
1001    Ericson, Jane      111 Clancey Court   Chapel Hill    NC  27514   USA
1002    Dix, Martin        4 Shepherd St.      Vancouver      BC  V6C 3E8 Canada
1003    Gabrielli, Theresa Via Pisanelli, 25   Roma               00196   Italy
1004    Clayton, Aria      14 Bridge St.       San Francisco  CA  94124   USA
1005    Archuleta, Ruby    Box 108             Milagro        NM  87429   USA
1006    Misiewicz, Jeremy  43-C Lakeview Apts. Madison        WI  53704   USA
1007    Ahmadi, Hafez      52 Rue Marston      Paris              75019   France
1008    Jacobson, Becky    1 Lincoln St.       Tallahassee    FL  32312   USA
1009    An, Ing            95 Willow Dr.       Toronto        ON  M5J 2T3 Canada
1010    Slater, Emily      1009 Cherry St.     York           PA  17407   USA
/* ...more data lines... */
;

proc print data=mail_list (obs=10);
	title ’Magazine Master Mailing List’;
run;

/* Page297 - Transaction data set */
data mail_trans;
	infile "/home/u58907790/sasuser.v94/excel_files/mail_trans" missover;
	input SubscriberId 1-8 Name $ 9-27 StreetAddress $ 28-47 City $ 48-62
		StateProv $ 63-64 PostalCode $ 67-73 Country $ 75-80;
run;

proc sort data=mail_trans;
	by SubscriberId;
run;

proc print data=mail_trans;
	title ’Magazine Mailing List Changes’;
	title2 ’(for current month)’;
run;

/* Page298 */
data mail_newlist;
	update mail_list mail_trans;
	by SubscriberId;
run;

proc print data=mail_newlist;
	title ’Magazine Mailing List’;
	title2 ’(updated for current month)’;
run;

/* Page300 - Updating with Incremental Values */
data year_sales;
	input Title $ 1-25 Author $ 27-50 Sales;
	datalines;
The Milagro Beanfield War Nichols, John            303
The Stranger              Camus, Albert            150
Always Coming Home        LeGuin, Ursula           79
Falling through Space     Gilchrist, Ellen         128
Don Quixote               Cervantes, Miguel de     87
The Handmaid’s Tale       Atwood, Margaret         64
;

proc sort data=year_sales;
	by title;
run;

proc print data=year_sales (obs=6);
	title ’Bookstore Sales, Year-to-Date’;
	title2 ’By Title’;
run;

/* Page300 */
data week_sales;
	input Title $ 1-25 Author $ 27-50 Sales;
	datalines;
The Milagro Beanfield War Nichols, John            32
The Stranger              Camus, Albert            17
Always Coming Home        LeGuin, Ursula           10
Falling through Space     Gilchrist, Ellen         12
The Accidental Tourist    Tyler, Anne              15
The Handmaid’s Tale       Atwood, Margaret         8
;

proc sort data=week_sales;
	by title;
run;

proc print data=week_sales;
	title ’Bookstore Sales for Current Week’;
	title2 ’By Title’;
run;

/* Page301 */
data total_sales;
	drop NewSales; 
	update year_sales week_sales (rename=(Sales=NewSales)); 
	by Title;
	sales=sum(Sales,NewSales); 
run;

proc print data=total_sales;
	title ’Updated Year-to-Date Sales’;
run;

/* Page303 - Comparison Between Updating and Merging */
data mail_merged;
	merge mail_list mail_trans;
	by SubscriberId;
run;

proc print data=mail_merged;
	title ’Magazine Mailing List’;
run;

proc print data=mail_trans;
	title ’Magazine Mailing List Changes’;
	title2 ’(for current month)’;
run;

/* Page305 - Handling Missing Values */
options pagesize=60 linesize=80 pageno=1 nodate;
data inventory;
	input PartNumber $ Description $ Stock @17
		ReceivedDate date9. @27 Price;
	format ReceivedDate date9.;
	datalines;
K89R seal 34    27jul2004 245.00
M4J7 sander 98  20jun2004 45.88
LK43 filter 121 19may2005 10.99
MN21 brace 43   10aug2005 27.87
BC85 clamp 80   16aug2005 9.55
NCF3 valve 198  20mar2005 24.50
;

proc sort data=inventory;
	by PartNumber;
run;

proc print data=inventory;
	title ’Master Data Set’;
	title2 ’Tool Warehouse Inventory’;
run;

/* Page307 */
data add_inventory;
	input PartNumber $ 1-4 Description $ 6-11 Stock 13-15 @17 Price;
	datalines;
K89R seal       245.00
M4J7 sander 121 45.88
LK43 filter 34  10.99
MN21 brace      28.87
BC85 clamp  57  11.64
NCF3 valve  121 .
;

proc sort data=add_inventory;
	by PartNumber;
run;

proc print data=add_inventory;
	title ’Transaction Data Set’;
	title2 ’Tool Warehouse Inventory’;
run;

/* Page307 */
data new_inventory;
	update inventory add_inventory updatemode=nomissingcheck;
	by PartNumber;
	ReceivedDate=today();
run;

proc print data=new_inventory;
	title ’Updated Master Data Set’;
	title2 ’Tool Warehouse Inventory’;
run;

/* The following is the default mode */
data new_inventory2;
	update inventory add_inventory;
	by PartNumber;
	ReceivedDate=today();
run;

proc print data=new_inventory2;
	title ’Updated Master Data Set’;
	title2 ’Tool Warehouse Inventory’;
run;
