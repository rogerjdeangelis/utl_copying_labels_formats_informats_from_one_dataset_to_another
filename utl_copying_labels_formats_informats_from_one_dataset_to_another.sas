Convert to metric and copy attributes from a 0 observation template table to the new dataset

github
https://tinyurl.com/y9axwvru
https://github.com/rogerjdeangelis/utl_copying_labels_formats_informats_from_one_dataset_to_another

Not as efficient as proc datasets except when doing data manipulation.


INPUT
=====

WORK.HAVE
---------

 Variables in Creation Order

 #    Variable    Type    Len

 1    NAME        Char      8    ** no labels (we need to add them)
 2    SEX         Char      1
 3    AGE         Num       8
 4    HEIGHT      Num       8
 5    WEIGHT      Num       8


 WORK.TEMPLATE Observations=0 (Has labels, formats and informats)
 -----------------------------------------------------------------

            Variables in Creation Order

  Variable    Type    Len    Format    Label

  NAME        Char      8              Student Name
  AGE         Num       8              Student Age
  SEX         Char      1              Student Sex
  HEIGHT      Num       8    6.        Student Height Centimeters
  WEIGHT      Num       8    6.        Student Weight Kilograms


                        Need to Convert to metric
                        ------------------------
  NAME       SEX    AGE    HEIGHT     WEIGHT

  Alfred      M      14     69.0      112.5
  Alice       F      13     56.5       84.0
  Barbara     F      13     65.3       98.0
  Carol       F      14     62.8      102.5




 OUTPUT
 ======

 WORK.WANT Observations=19 (NEW labels, formats and informats)
 -----------------------------------------------------------------

            Variables in Creation Order

  Variable    Type    Len    Format    Label

  NAME        Char      8              Student Name
  AGE         Num       8              Student Age
  SEX         Char      1              Student Sex
  HEIGHT      Num       8    6.        Student Height Centimeters
  WEIGHT      Num       8    6.        Student Weight Kilograms

  and conversionx

                           Converted to metric
                           -------------------
  NAME       SEX    AGE     HEIGHT    WEIGHT

  Alfred      M      14     172.50    51.1364
  Alice       F      13     141.25    38.1818
  Barbara     F      13     163.25    44.5455
  Carol       F      14     157.00    46.5909


PROCESS
========

  data want;
    if _n_=0 then set template;
    set have;
    weight=weight/2.2;
    height=height/.4;
  run;quit;


OUTPUT
======
see above

*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

proc datasets lib=work kill;
run;quit;

data have; * no labels;
  set sashelp.class;
run;quit;

* 0 ob template table;
data template;
 label
    name ="Student Name"
    age ="Student Age"
    sex="Student Sex"
    height="Student Height Centimeters"
    weight="Student Weight Kilograms";
 ;
 format weight height 6.;
 set have;
 stop;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

data want;
  if _n_=0 then set template;
  set have;
  weight=weight/2.2;
  height=height/.4;
run;quit;


