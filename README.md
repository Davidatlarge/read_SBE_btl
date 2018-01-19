Read SBE bottle file
================
David Kaiser
2018/01/19

Description
-----------

This function **reads bottle files** produced during Seabird Electronics CTD casts. It was written for data recorded during various cruises by the IOW (&lt;io-warnemuende.de&gt;) and some adjustments might be necessary before application to data recorded elsewhere. However, the function offers optional input of identifiers for **geographic position**, **cruise** name, **station** name, and the station's **bottom depth**. The idea is that the user knows any character string that identifies these meta variables in the header of the .btl file and the function finds the corresponding position in the file using grep() and extracts the values using sub().

Arguments
---------

*filename* -- the file to be imported

*position.identifer* -- any string identidying the GPS position in the header, defaults to "GPS\_Posn",

*cruise.identifier* -- any string identidying the curise name in the header, defaults to"ReiseNr",

*station.identifier* -- any string identidying the station name in the header, defaults to "StationNr",

*bottom.identifier* -- any string identidying the station depth in the header, defaults to "Echolote"

Format requirements
-------------------

Currently the identifiers must have a format of ".\*= (.\*)" where "(.\*)" contains the value.

Examples
--------

``` r
Ex1 <- read_btl_DK("example_data/EMB.btl")
head(Ex1)
```

         DepSM        PrDM  C0mS/cm     C1mS/cm    T090C    T190C    Sal00
    1 6.444000    6.502000 8.628613    8.628918   8.0352   8.0342   7.3207
    2 0.054000    0.055000 0.000143    0.000147 0.000700 0.000700   0.0001
    3    6.363       6.420 8.628318    8.628656 8.034100 8.033300 7.320500
    4    6.547       6.606 8.628855    8.629196 8.036100 8.035500 7.320900
    5 6.539000    6.598000 8.629836    8.628778   8.0412   8.0332   7.3206
    6 0.089000    0.090000 0.001851    0.000368 0.008800 0.002000   0.0002
         Sal11 Sbeox0ML/L Sbeox1ML/L        Par       Spar FlECO-AFL
    1   7.3212    7.66560 7.6430e+00 3.7804e+00    28.9350    0.8226
    2   0.0001     0.0058     0.0046    0.11931 1.3487e-06    0.0428
    3 7.321100     7.6539     7.6306     3.5786    28.9350   0.71760
    4 7.321400     7.6715     7.6462     3.9694    28.9350   0.90800
    5   7.3213    7.66180 7.6463e+00 3.7751e+00    28.9350    0.7726
    6   0.0001     0.0055     0.0005    0.17619 1.3487e-06    0.0207
      TurbWETntu0 statistic Btl_Posn Btl_ID                time longitude.degE
    1      0.1008     (avg)       10     61 2014 Dec 6 09:11:53       17.72874
    2      0.0081    (sdev)       10     61 2014 Dec 6 09:11:53       17.72874
    3  8.8900e-02     (min)       10     61 2014 Dec 6 09:11:53       17.72874
    4  1.1820e-01     (max)       10     61 2014 Dec 6 09:11:53       17.72874
    5      0.0928     (avg)       11     62 2014 Dec 6 09:12:01       17.72874
    6      0.0099    (sdev)       11     62 2014 Dec 6 09:12:01       17.72874
      latitude.degN cruise station bottom.m             filename
    1      55.72748 EMB-91    0001    56.34 example_data/EMB.btl
    2      55.72748 EMB-91    0001    56.34 example_data/EMB.btl
    3      55.72748 EMB-91    0001    56.34 example_data/EMB.btl
    4      55.72748 EMB-91    0001    56.34 example_data/EMB.btl
    5      55.72748 EMB-91    0001    56.34 example_data/EMB.btl
    6      55.72748 EMB-91    0001    56.34 example_data/EMB.btl

``` r
Ex2 <- read_btl_DK("example_data/POS.btl")
head(Ex2)
```

           DepSM      PrDM    C0mS/cm     T090C      T190C     Sal00
    1 519.171000  523.6850   40.51506   11.6249   11.62690   35.6325
    2    0.09300    0.0930   0.001120    0.0011    0.00140    0.0003
    3    518.990   523.503   40.51291   11.6231  11.625100   35.6318
    4    519.364   523.880   40.51727   11.6271  11.629700   35.6330
    5 519.152000  523.6670   40.51616   11.6261   11.62780   35.6325
    6    0.08500    0.0860   0.001277    0.0013    0.00140    0.0003
      Sbeox0ML/L       SvCM OxsatML/L  FlECO-AFL TurbWETntu0   Latitude
    1    4.38939 1504.95000   6.07554     0.0198     0.03800   36.67108
    2    0.00613     0.0000   0.00014    0.00930     0.00610    0.00000
    3    4.37792  1504.9400   6.07525     0.0003     0.03090   36.67108
    4    4.40020  1504.9600   6.07579     0.0369     0.05290   36.67108
    5    4.38940 1504.95000   6.07538     0.0225     0.04040   36.67108
    6    0.00528     0.0000   0.00018    0.01700     0.01760    0.00000
      Longitude statistic Btl_Posn Btl_ID                 time longitude.degW
    1 -16.23368     (avg)        1     27 2014 May 28 12:46:59        16.2337
    2   0.00000    (sdev)        1     27 2014 May 28 12:46:59        16.2337
    3 -16.23368     (min)        1     27 2014 May 28 12:46:59        16.2337
    4 -16.23368     (max)        1     27 2014 May 28 12:46:59        16.2337
    5 -16.23366     (avg)        2     28 2014 May 28 12:47:04        16.2337
    6   0.00000    (sdev)        2     28 2014 May 28 12:47:04        16.2337
      latitude.degN  cruise station   bottom.m             filename
    1      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl
    2      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl
    3      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl
    4      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl
    5      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl
    6      36.67113 POS-470    0001 4027.41 m  example_data/POS.btl

Issues / ToDo's
---------------

**Time**: date and time are currently class character, need to be changed to strptime, but the user can of course do that in post
**Generalization**: as described above, the function was build for a specific data set and should become more generally useable with time
