/* Page82 - Input SAS Data Set for Examples */
/* Reading Selected Observations */
/* data name2; */
/* 	set lib.name (firstobs=4 obs=10); */
/* run; */

/* Page86 - Keeping Selected Variables */
/* 1. keep option */
/* data name2; */
/* 	set lib.name (keep=var1 var2 var3); */
/* run; */

/* 2. keep statement */
/* data name2; */
/* 	set lib.name ; */
/* 	Keep var1 var2 var3; */
/* run; */

/* 3. */
/* data name2 (keep=var1 var2 var3); */
/* 	set lib.name; */
/* run; */

/* Page87 - Dropping Selected Variables */
/* 1. drop option */
/* data name2; */
/* 	set lib.name (drop=var1 var2 var3); */
/* run; */

/* 2. drop statement */
/* data name2; */
/* 	drop var1 var2 var3; */
/* run; */

/* Page89 - Creating More Than One Data Set in a Single Data Step */
/* data name1(keep=var1 var3 var5) */
/* 	name2(keep=var2 var4 var6); */
/* 	set lib.name; */
/* run; */



