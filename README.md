Read SBE bottle file
================
David Kaiser
2018/01/19

Description
-----------

This function **reads bottle files** produced during Seabird Electronics CTD casts. It was written for data recorded during various cruises by the [IOW](https://www.io-warnemuende.de) and some adjustments might be necessary before application to data recorded elsewhere. However, the function offers optional input of identifiers for **geographic position**, **cruise** name, **station** name, and the station's **bottom depth**. The idea is that the user knows any character string that identifies these meta variables in the header of the .btl file and the function finds the corresponding position in the file using grep() and extracts the values using sub().

Arguments
---------

*filename* -- the file to be imported

*position.identifer* -- any string identifying the GPS position in the header, defaults to "GPS\_Posn",

*cruise.identifier* -- any string identifying the curise name in the header, defaults to "ReiseNr",

*station.identifier* -- any string identifying the station name in the header, defaults to "StationNr",

*bottom.identifier* -- any string identifying the station depth in the header, defaults to "Echolote"

Format requirements
-------------------

Currently the identifiers must have a format of ".\*= (.\*)" where "(.\*)" contains the value. <!-- ??? What do you mean ??? -->

Examples
--------

``` r
Ex1 <- read_btl_DK("example_data/EMB.btl")
Ex2 <- read_btl_DK("example_data/POS.btl")
```

### Full data frame

Each record is represented by 4 lines in the table:

-   average,
-   standard deviation,
-   minimum,
-   maximum
    (see column *statistic*)

``` r
library(pander)

pander(Ex1$df, emphasize.strong.rows = which(Ex1$df$statistic == "(avg)"))
```

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">DepSM</th>
<th align="center">PrDM</th>
<th align="center">C0mS/cm</th>
<th align="center">C1mS/cm</th>
<th align="center">T090C</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>6.444000</strong></td>
<td align="center"><strong>6.502000</strong></td>
<td align="center"><strong>8.628613</strong></td>
<td align="center"><strong>8.628918</strong></td>
<td align="center"><strong>8.0352</strong></td>
</tr>
<tr class="even">
<td align="center">0.054000</td>
<td align="center">0.055000</td>
<td align="center">0.000143</td>
<td align="center">0.000147</td>
<td align="center">0.000700</td>
</tr>
<tr class="odd">
<td align="center">6.363</td>
<td align="center">6.420</td>
<td align="center">8.628318</td>
<td align="center">8.628656</td>
<td align="center">8.034100</td>
</tr>
<tr class="even">
<td align="center">6.547</td>
<td align="center">6.606</td>
<td align="center">8.628855</td>
<td align="center">8.629196</td>
<td align="center">8.036100</td>
</tr>
<tr class="odd">
<td align="center"><strong>6.539000</strong></td>
<td align="center"><strong>6.598000</strong></td>
<td align="center"><strong>8.629836</strong></td>
<td align="center"><strong>8.628778</strong></td>
<td align="center"><strong>8.0412</strong></td>
</tr>
<tr class="even">
<td align="center">0.089000</td>
<td align="center">0.090000</td>
<td align="center">0.001851</td>
<td align="center">0.000368</td>
<td align="center">0.008800</td>
</tr>
<tr class="odd">
<td align="center">6.418</td>
<td align="center">6.476</td>
<td align="center">8.628203</td>
<td align="center">8.627847</td>
<td align="center">8.034300</td>
</tr>
<tr class="even">
<td align="center">6.712</td>
<td align="center">6.772</td>
<td align="center">8.633761</td>
<td align="center">8.629196</td>
<td align="center">8.060600</td>
</tr>
</tbody>
</table>

<table style="width:96%;">
<caption>Table continues below</caption>
<colgroup>
<col width="18%" />
<col width="18%" />
<col width="18%" />
<col width="19%" />
<col width="22%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">T190C</th>
<th align="center">Sal00</th>
<th align="center">Sal11</th>
<th align="center">Sbeox0ML/L</th>
<th align="center">Sbeox1ML/L</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>8.0342</strong></td>
<td align="center"><strong>7.3207</strong></td>
<td align="center"><strong>7.3212</strong></td>
<td align="center"><strong>7.66560</strong></td>
<td align="center"><strong>7.6430e+00</strong></td>
</tr>
<tr class="even">
<td align="center">0.000700</td>
<td align="center">0.0001</td>
<td align="center">0.0001</td>
<td align="center">0.0058</td>
<td align="center">0.0046</td>
</tr>
<tr class="odd">
<td align="center">8.033300</td>
<td align="center">7.320500</td>
<td align="center">7.321100</td>
<td align="center">7.6539</td>
<td align="center">7.6306</td>
</tr>
<tr class="even">
<td align="center">8.035500</td>
<td align="center">7.320900</td>
<td align="center">7.321400</td>
<td align="center">7.6715</td>
<td align="center">7.6462</td>
</tr>
<tr class="odd">
<td align="center"><strong>8.0332</strong></td>
<td align="center"><strong>7.3206</strong></td>
<td align="center"><strong>7.3213</strong></td>
<td align="center"><strong>7.66180</strong></td>
<td align="center"><strong>7.6463e+00</strong></td>
</tr>
<tr class="even">
<td align="center">0.002000</td>
<td align="center">0.0002</td>
<td align="center">0.0001</td>
<td align="center">0.0055</td>
<td align="center">0.0005</td>
</tr>
<tr class="odd">
<td align="center">8.028100</td>
<td align="center">7.320000</td>
<td align="center">7.321100</td>
<td align="center">7.6527</td>
<td align="center">7.6458</td>
</tr>
<tr class="even">
<td align="center">8.035400</td>
<td align="center">7.320800</td>
<td align="center">7.321600</td>
<td align="center">7.6689</td>
<td align="center">7.6474</td>
</tr>
</tbody>
</table>

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="20%" />
<col width="17%" />
<col width="15%" />
<col width="17%" />
<col width="14%" />
<col width="14%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Par</th>
<th align="center">Spar</th>
<th align="center">FlECO-AFL</th>
<th align="center">TurbWETntu0</th>
<th align="center">statistic</th>
<th align="center">Btl_Posn</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>3.7804e+00</strong></td>
<td align="center"><strong>28.9350</strong></td>
<td align="center"><strong>0.8226</strong></td>
<td align="center"><strong>0.1008</strong></td>
<td align="center"><strong>(avg)</strong></td>
<td align="center"><strong>10</strong></td>
</tr>
<tr class="even">
<td align="center">0.11931</td>
<td align="center">1.3487e-06</td>
<td align="center">0.0428</td>
<td align="center">0.0081</td>
<td align="center">(sdev)</td>
<td align="center">10</td>
</tr>
<tr class="odd">
<td align="center">3.5786</td>
<td align="center">28.9350</td>
<td align="center">0.71760</td>
<td align="center">8.8900e-02</td>
<td align="center">(min)</td>
<td align="center">10</td>
</tr>
<tr class="even">
<td align="center">3.9694</td>
<td align="center">28.9350</td>
<td align="center">0.90800</td>
<td align="center">1.1820e-01</td>
<td align="center">(max)</td>
<td align="center">10</td>
</tr>
<tr class="odd">
<td align="center"><strong>3.7751e+00</strong></td>
<td align="center"><strong>28.9350</strong></td>
<td align="center"><strong>0.7726</strong></td>
<td align="center"><strong>0.0928</strong></td>
<td align="center"><strong>(avg)</strong></td>
<td align="center"><strong>11</strong></td>
</tr>
<tr class="even">
<td align="center">0.17619</td>
<td align="center">1.3487e-06</td>
<td align="center">0.0207</td>
<td align="center">0.0099</td>
<td align="center">(sdev)</td>
<td align="center">11</td>
</tr>
<tr class="odd">
<td align="center">3.4970</td>
<td align="center">28.9350</td>
<td align="center">0.74690</td>
<td align="center">7.4200e-02</td>
<td align="center">(min)</td>
<td align="center">11</td>
</tr>
<tr class="even">
<td align="center">4.0153</td>
<td align="center">28.9350</td>
<td align="center">0.82010</td>
<td align="center">1.0840e-01</td>
<td align="center">(max)</td>
<td align="center">11</td>
</tr>
</tbody>
</table>

<table style="width:47%;">
<colgroup>
<col width="12%" />
<col width="34%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Btl_ID</th>
<th align="center">time</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>61</strong></td>
<td align="center"><strong>2014 Dec 6 09:11:53</strong></td>
</tr>
<tr class="even">
<td align="center">61</td>
<td align="center">2014 Dec 6 09:11:53</td>
</tr>
<tr class="odd">
<td align="center">61</td>
<td align="center">2014 Dec 6 09:11:53</td>
</tr>
<tr class="even">
<td align="center">61</td>
<td align="center">2014 Dec 6 09:11:53</td>
</tr>
<tr class="odd">
<td align="center"><strong>62</strong></td>
<td align="center"><strong>2014 Dec 6 09:12:01</strong></td>
</tr>
<tr class="even">
<td align="center">62</td>
<td align="center">2014 Dec 6 09:12:01</td>
</tr>
<tr class="odd">
<td align="center">62</td>
<td align="center">2014 Dec 6 09:12:01</td>
</tr>
<tr class="even">
<td align="center">62</td>
<td align="center">2014 Dec 6 09:12:01</td>
</tr>
</tbody>
</table>

``` r
pander(Ex1$meta)
```

-   **filename**: example\_data/EMB.btl
-   **cruise**: EMB-91
-   **station**: 0001
-   **bottom**: 56.34
-   **position**: \*\* GPS\_Posn = 55 43.6488N 17 43.7241E
-   **longitude decdeg**: *17.73*
-   **longitude decdir**: E
-   **latitude decdeg**: *55.73*
-   **latitude decdir**: N

<!-- end of list -->
### Only averages

``` r
pander(subset(Ex2$df, statistic == "(avg)"))
```

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="11%" />
<col width="17%" />
<col width="14%" />
<col width="14%" />
<col width="13%" />
<col width="14%" />
<col width="14%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">DepSM</th>
<th align="center">PrDM</th>
<th align="center">C0mS/cm</th>
<th align="center">T090C</th>
<th align="center">T190C</th>
<th align="center">Sal00</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">519.171000</td>
<td align="center">523.6850</td>
<td align="center">40.51506</td>
<td align="center">11.6249</td>
<td align="center">11.62690</td>
<td align="center">35.6325</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">519.152000</td>
<td align="center">523.6670</td>
<td align="center">40.51616</td>
<td align="center">11.6261</td>
<td align="center">11.62780</td>
<td align="center">35.6325</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">518.595000</td>
<td align="center">523.1030</td>
<td align="center">40.52125</td>
<td align="center">11.6320</td>
<td align="center">11.63240</td>
<td align="center">35.6321</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">518.503000</td>
<td align="center">523.0100</td>
<td align="center">40.52035</td>
<td align="center">11.6310</td>
<td align="center">11.63130</td>
<td align="center">35.6322</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">518.571000</td>
<td align="center">523.0800</td>
<td align="center">40.51825</td>
<td align="center">11.6286</td>
<td align="center">11.63020</td>
<td align="center">35.6324</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">519.067000</td>
<td align="center">523.5800</td>
<td align="center">40.51696</td>
<td align="center">11.6271</td>
<td align="center">11.62680</td>
<td align="center">35.6323</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">519.352000</td>
<td align="center">523.8680</td>
<td align="center">40.51602</td>
<td align="center">11.6258</td>
<td align="center">11.62600</td>
<td align="center">35.6326</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">519.428000</td>
<td align="center">523.9450</td>
<td align="center">40.51778</td>
<td align="center">11.6277</td>
<td align="center">11.62760</td>
<td align="center">35.6324</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">518.608000</td>
<td align="center">523.1160</td>
<td align="center">40.52083</td>
<td align="center">11.6313</td>
<td align="center">11.63010</td>
<td align="center">35.6323</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">519.172000</td>
<td align="center">523.6860</td>
<td align="center">40.51578</td>
<td align="center">11.6256</td>
<td align="center">11.62700</td>
<td align="center">35.6326</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">519.025000</td>
<td align="center">523.5370</td>
<td align="center">40.51822</td>
<td align="center">11.6284</td>
<td align="center">11.62870</td>
<td align="center">35.6323</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">518.378000</td>
<td align="center">522.8840</td>
<td align="center">40.52086</td>
<td align="center">11.6315</td>
<td align="center">11.63090</td>
<td align="center">35.6322</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">518.617000</td>
<td align="center">523.1260</td>
<td align="center">40.51936</td>
<td align="center">11.6297</td>
<td align="center">11.62920</td>
<td align="center">35.6324</td>
</tr>
</tbody>
</table>

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="12%" />
<col width="18%" />
<col width="18%" />
<col width="16%" />
<col width="16%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Sbeox0ML/L</th>
<th align="center">SvCM</th>
<th align="center">OxsatML/L</th>
<th align="center">FlECO-AFL</th>
<th align="center">TurbWETntu0</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">4.38939</td>
<td align="center">1504.95000</td>
<td align="center">6.07554</td>
<td align="center">0.0198</td>
<td align="center">0.03800</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">4.38940</td>
<td align="center">1504.95000</td>
<td align="center">6.07538</td>
<td align="center">0.0225</td>
<td align="center">0.04040</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">4.39386</td>
<td align="center">1504.97000</td>
<td align="center">6.07463</td>
<td align="center">0.0260</td>
<td align="center">0.03390</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">4.39184</td>
<td align="center">1504.96000</td>
<td align="center">6.07476</td>
<td align="center">0.0075</td>
<td align="center">0.03530</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">4.39213</td>
<td align="center">1504.95000</td>
<td align="center">6.07506</td>
<td align="center">0.0162</td>
<td align="center">0.03430</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">4.39466</td>
<td align="center">1504.96000</td>
<td align="center">6.07526</td>
<td align="center">0.0133</td>
<td align="center">0.03620</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">4.40639</td>
<td align="center">1504.96000</td>
<td align="center">6.07542</td>
<td align="center">0.0112</td>
<td align="center">0.03620</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">4.39426</td>
<td align="center">1504.97000</td>
<td align="center">6.07518</td>
<td align="center">0.0144</td>
<td align="center">0.03510</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">4.39066</td>
<td align="center">1504.96000</td>
<td align="center">6.07472</td>
<td align="center">0.0112</td>
<td align="center">0.04050</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">4.40335</td>
<td align="center">1504.95000</td>
<td align="center">6.07545</td>
<td align="center">0.0223</td>
<td align="center">0.03780</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">4.39666</td>
<td align="center">1504.96000</td>
<td align="center">6.07509</td>
<td align="center">0.0173</td>
<td align="center">0.03370</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">4.39643</td>
<td align="center">1504.96000</td>
<td align="center">6.07469</td>
<td align="center">0.0144</td>
<td align="center">0.03860</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">4.39890</td>
<td align="center">1504.96000</td>
<td align="center">6.07492</td>
<td align="center">0.0227</td>
<td align="center">0.03940</td>
</tr>
</tbody>
</table>

<table style="width:88%;">
<caption>Table continues below</caption>
<colgroup>
<col width="12%" />
<col width="15%" />
<col width="16%" />
<col width="16%" />
<col width="15%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Latitude</th>
<th align="center">Longitude</th>
<th align="center">statistic</th>
<th align="center">Btl_Posn</th>
<th align="center">Btl_ID</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">1</td>
<td align="center">27</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23366</td>
<td align="center">(avg)</td>
<td align="center">2</td>
<td align="center">28</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">3</td>
<td align="center">29</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23367</td>
<td align="center">(avg)</td>
<td align="center">4</td>
<td align="center">30</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">5</td>
<td align="center">31</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">6</td>
<td align="center">32</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">7</td>
<td align="center">33</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">8</td>
<td align="center">34</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">10</td>
<td align="center">36</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23368</td>
<td align="center">(avg)</td>
<td align="center">11</td>
<td align="center">37</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23367</td>
<td align="center">(avg)</td>
<td align="center">12</td>
<td align="center">38</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23366</td>
<td align="center">(avg)</td>
<td align="center">13</td>
<td align="center">39</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">36.67108</td>
<td align="center">-16.23367</td>
<td align="center">(avg)</td>
<td align="center">14</td>
<td align="center">40</td>
</tr>
</tbody>
</table>

<table style="width:43%;">
<colgroup>
<col width="12%" />
<col width="30%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">time</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">2014 May 28 12:46:59</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">2014 May 28 12:47:04</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">2014 May 28 12:47:07</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">2014 May 28 12:47:14</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">2014 May 28 12:47:16</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">2014 May 28 12:47:19</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">2014 May 28 12:47:21</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">2014 May 28 12:47:23</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">2014 May 28 12:47:29</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">2014 May 28 12:47:32</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">2014 May 28 12:47:35</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">2014 May 28 12:47:37</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">2014 May 28 12:47:39</td>
</tr>
</tbody>
</table>

``` r
pander(Ex2$meta)
```

-   **filename**: example\_data/POS.btl
-   **cruise**: POS-470
-   **station**: 0001
-   **bottom**: 4027.41 m
-   **position**: \*\* GPS\_Posn = 36 40.2677N 16 14.0217W
-   **longitude decdeg**: *16.23*
-   **longitude decdir**: W
-   **latitude decdeg**: *36.67*
-   **latitude decdir**: N

<!-- end of list -->
Issues / ToDo's
---------------

**Time**: date and time are currently class character, need to be changed to strptime, but the user can of course do that in post
**Generalization**: as described above, the function was build for a specific data set and should become more generally useable with time
