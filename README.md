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

pander(Ex1$data, emphasize.strong.rows = which(Ex1$data$statistic == "(avg)"))
```

<table>
<caption>Table continues below</caption>
<colgroup>
<col width="14%" />
<col width="36%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Btl_Posn</th>
<th align="center">Date</th>
<th align="center">DepSM</th>
<th align="center">PrDM</th>
<th align="center">C0mS.cm</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>10</strong></td>
<td align="center"><strong>Dec 06 2014 09:11:53</strong></td>
<td align="center"><strong>6.444</strong></td>
<td align="center"><strong>6.502</strong></td>
<td align="center"><strong>8.629</strong></td>
</tr>
<tr class="even">
<td align="center">10</td>
<td align="center">Dec 06 2014 09:11:53</td>
<td align="center">0.054</td>
<td align="center">0.055</td>
<td align="center">0.000143</td>
</tr>
<tr class="odd">
<td align="center">10</td>
<td align="center">Dec 06 2014 09:11:53</td>
<td align="center">6.363</td>
<td align="center">6.42</td>
<td align="center">8.628</td>
</tr>
<tr class="even">
<td align="center">10</td>
<td align="center">Dec 06 2014 09:11:53</td>
<td align="center">6.547</td>
<td align="center">6.606</td>
<td align="center">8.629</td>
</tr>
<tr class="odd">
<td align="center"><strong>11</strong></td>
<td align="center"><strong>Dec 06 2014 09:12:01</strong></td>
<td align="center"><strong>6.539</strong></td>
<td align="center"><strong>6.598</strong></td>
<td align="center"><strong>8.63</strong></td>
</tr>
<tr class="even">
<td align="center">11</td>
<td align="center">Dec 06 2014 09:12:01</td>
<td align="center">0.089</td>
<td align="center">0.09</td>
<td align="center">0.001851</td>
</tr>
<tr class="odd">
<td align="center">11</td>
<td align="center">Dec 06 2014 09:12:01</td>
<td align="center">6.418</td>
<td align="center">6.476</td>
<td align="center">8.628</td>
</tr>
<tr class="even">
<td align="center">11</td>
<td align="center">Dec 06 2014 09:12:01</td>
<td align="center">6.712</td>
<td align="center">6.772</td>
<td align="center">8.634</td>
</tr>
</tbody>
</table>

<table style="width:100%;">
<caption>Table continues below</caption>
<colgroup>
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">C1mS.cm</th>
<th align="center">T090C</th>
<th align="center">T190C</th>
<th align="center">Sal00</th>
<th align="center">Sal11</th>
<th align="center">Sbeox0ML.L</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>8.629</strong></td>
<td align="center"><strong>8.035</strong></td>
<td align="center"><strong>8.034</strong></td>
<td align="center"><strong>7.321</strong></td>
<td align="center"><strong>7.321</strong></td>
<td align="center"><strong>7.666</strong></td>
</tr>
<tr class="even">
<td align="center">0.000147</td>
<td align="center">7e-04</td>
<td align="center">7e-04</td>
<td align="center">1e-04</td>
<td align="center">1e-04</td>
<td align="center">0.0058</td>
</tr>
<tr class="odd">
<td align="center">8.629</td>
<td align="center">8.034</td>
<td align="center">8.033</td>
<td align="center">7.321</td>
<td align="center">7.321</td>
<td align="center">7.654</td>
</tr>
<tr class="even">
<td align="center">8.629</td>
<td align="center">8.036</td>
<td align="center">8.036</td>
<td align="center">7.321</td>
<td align="center">7.321</td>
<td align="center">7.671</td>
</tr>
<tr class="odd">
<td align="center"><strong>8.629</strong></td>
<td align="center"><strong>8.041</strong></td>
<td align="center"><strong>8.033</strong></td>
<td align="center"><strong>7.321</strong></td>
<td align="center"><strong>7.321</strong></td>
<td align="center"><strong>7.662</strong></td>
</tr>
<tr class="even">
<td align="center">0.000368</td>
<td align="center">0.0088</td>
<td align="center">0.002</td>
<td align="center">2e-04</td>
<td align="center">1e-04</td>
<td align="center">0.0055</td>
</tr>
<tr class="odd">
<td align="center">8.628</td>
<td align="center">8.034</td>
<td align="center">8.028</td>
<td align="center">7.32</td>
<td align="center">7.321</td>
<td align="center">7.653</td>
</tr>
<tr class="even">
<td align="center">8.629</td>
<td align="center">8.061</td>
<td align="center">8.035</td>
<td align="center">7.321</td>
<td align="center">7.322</td>
<td align="center">7.669</td>
</tr>
</tbody>
</table>

<table style="width:100%;">
<colgroup>
<col width="15%" />
<col width="14%" />
<col width="14%" />
<col width="15%" />
<col width="16%" />
<col width="14%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Sbeox1ML.L</th>
<th align="center">Par</th>
<th align="center">Spar</th>
<th align="center">FlECO.AFL</th>
<th align="center">TurbWETntu0</th>
<th align="center">statistic</th>
<th align="center">Btl_ID</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>7.643</strong></td>
<td align="center"><strong>3.78</strong></td>
<td align="center"><strong>28.93</strong></td>
<td align="center"><strong>0.8226</strong></td>
<td align="center"><strong>0.1008</strong></td>
<td align="center"><strong>(avg)</strong></td>
<td align="center"><strong>61</strong></td>
</tr>
<tr class="even">
<td align="center">0.0046</td>
<td align="center">0.1193</td>
<td align="center">1.349e-06</td>
<td align="center">0.0428</td>
<td align="center">0.0081</td>
<td align="center">(sdev)</td>
<td align="center">61</td>
</tr>
<tr class="odd">
<td align="center">7.631</td>
<td align="center">3.579</td>
<td align="center">28.93</td>
<td align="center">0.7176</td>
<td align="center">0.0889</td>
<td align="center">(min)</td>
<td align="center">61</td>
</tr>
<tr class="even">
<td align="center">7.646</td>
<td align="center">3.969</td>
<td align="center">28.93</td>
<td align="center">0.908</td>
<td align="center">0.1182</td>
<td align="center">(max)</td>
<td align="center">61</td>
</tr>
<tr class="odd">
<td align="center"><strong>7.646</strong></td>
<td align="center"><strong>3.775</strong></td>
<td align="center"><strong>28.93</strong></td>
<td align="center"><strong>0.7726</strong></td>
<td align="center"><strong>0.0928</strong></td>
<td align="center"><strong>(avg)</strong></td>
<td align="center"><strong>62</strong></td>
</tr>
<tr class="even">
<td align="center">5e-04</td>
<td align="center">0.1762</td>
<td align="center">1.349e-06</td>
<td align="center">0.0207</td>
<td align="center">0.0099</td>
<td align="center">(sdev)</td>
<td align="center">62</td>
</tr>
<tr class="odd">
<td align="center">7.646</td>
<td align="center">3.497</td>
<td align="center">28.93</td>
<td align="center">0.7469</td>
<td align="center">0.0742</td>
<td align="center">(min)</td>
<td align="center">62</td>
</tr>
<tr class="even">
<td align="center">7.647</td>
<td align="center">4.015</td>
<td align="center">28.93</td>
<td align="center">0.8201</td>
<td align="center">0.1084</td>
<td align="center">(max)</td>
<td align="center">62</td>
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
pander(subset(Ex2$data, statistic == "(avg)"))
```

<table style="width:100%;">
<caption>Table continues below</caption>
<colgroup>
<col width="11%" />
<col width="14%" />
<col width="30%" />
<col width="10%" />
<col width="10%" />
<col width="13%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">Btl_Posn</th>
<th align="center">Date</th>
<th align="center">DepSM</th>
<th align="center">PrDM</th>
<th align="center">C0mS.cm</th>
<th align="center">T090C</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">1</td>
<td align="center">May 28 2014 12:46:59</td>
<td align="center">519.2</td>
<td align="center">523.7</td>
<td align="center">40.52</td>
<td align="center">11.62</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">2</td>
<td align="center">May 28 2014 12:47:04</td>
<td align="center">519.2</td>
<td align="center">523.7</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">3</td>
<td align="center">May 28 2014 12:47:07</td>
<td align="center">518.6</td>
<td align="center">523.1</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">4</td>
<td align="center">May 28 2014 12:47:14</td>
<td align="center">518.5</td>
<td align="center">523</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">5</td>
<td align="center">May 28 2014 12:47:16</td>
<td align="center">518.6</td>
<td align="center">523.1</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">6</td>
<td align="center">May 28 2014 12:47:19</td>
<td align="center">519.1</td>
<td align="center">523.6</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">7</td>
<td align="center">May 28 2014 12:47:21</td>
<td align="center">519.4</td>
<td align="center">523.9</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">8</td>
<td align="center">May 28 2014 12:47:23</td>
<td align="center">519.4</td>
<td align="center">523.9</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">10</td>
<td align="center">May 28 2014 12:47:29</td>
<td align="center">518.6</td>
<td align="center">523.1</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">11</td>
<td align="center">May 28 2014 12:47:32</td>
<td align="center">519.2</td>
<td align="center">523.7</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">12</td>
<td align="center">May 28 2014 12:47:35</td>
<td align="center">519</td>
<td align="center">523.5</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">13</td>
<td align="center">May 28 2014 12:47:37</td>
<td align="center">518.4</td>
<td align="center">522.9</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">14</td>
<td align="center">May 28 2014 12:47:39</td>
<td align="center">518.6</td>
<td align="center">523.1</td>
<td align="center">40.52</td>
<td align="center">11.63</td>
</tr>
</tbody>
</table>

<table style="width:96%;">
<caption>Table continues below</caption>
<colgroup>
<col width="12%" />
<col width="11%" />
<col width="11%" />
<col width="18%" />
<col width="9%" />
<col width="16%" />
<col width="16%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">T190C</th>
<th align="center">Sal00</th>
<th align="center">Sbeox0ML.L</th>
<th align="center">SvCM</th>
<th align="center">OxsatML.L</th>
<th align="center">FlECO.AFL</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.389</td>
<td align="center">1505</td>
<td align="center">6.076</td>
<td align="center">0.0198</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.389</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0225</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.394</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.026</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.392</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0075</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.392</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0162</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.395</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0133</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.406</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0112</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.394</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0144</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.391</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0112</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.403</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0223</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.397</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0173</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.396</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0144</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">11.63</td>
<td align="center">35.63</td>
<td align="center">4.399</td>
<td align="center">1505</td>
<td align="center">6.075</td>
<td align="center">0.0227</td>
</tr>
</tbody>
</table>

<table style="width:92%;">
<colgroup>
<col width="12%" />
<col width="19%" />
<col width="15%" />
<col width="16%" />
<col width="16%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center"> </th>
<th align="center">TurbWETntu0</th>
<th align="center">Latitude</th>
<th align="center">Longitude</th>
<th align="center">statistic</th>
<th align="center">Btl_ID</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center"><strong>1</strong></td>
<td align="center">0.038</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">27</td>
</tr>
<tr class="even">
<td align="center"><strong>5</strong></td>
<td align="center">0.0404</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">28</td>
</tr>
<tr class="odd">
<td align="center"><strong>9</strong></td>
<td align="center">0.0339</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">29</td>
</tr>
<tr class="even">
<td align="center"><strong>13</strong></td>
<td align="center">0.0353</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">30</td>
</tr>
<tr class="odd">
<td align="center"><strong>17</strong></td>
<td align="center">0.0343</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">31</td>
</tr>
<tr class="even">
<td align="center"><strong>21</strong></td>
<td align="center">0.0362</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">32</td>
</tr>
<tr class="odd">
<td align="center"><strong>25</strong></td>
<td align="center">0.0362</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">33</td>
</tr>
<tr class="even">
<td align="center"><strong>29</strong></td>
<td align="center">0.0351</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">34</td>
</tr>
<tr class="odd">
<td align="center"><strong>33</strong></td>
<td align="center">0.0405</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">36</td>
</tr>
<tr class="even">
<td align="center"><strong>37</strong></td>
<td align="center">0.0378</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">37</td>
</tr>
<tr class="odd">
<td align="center"><strong>41</strong></td>
<td align="center">0.0337</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">38</td>
</tr>
<tr class="even">
<td align="center"><strong>45</strong></td>
<td align="center">0.0386</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">39</td>
</tr>
<tr class="odd">
<td align="center"><strong>49</strong></td>
<td align="center">0.0394</td>
<td align="center">36.67</td>
<td align="center">-16.23</td>
<td align="center">(avg)</td>
<td align="center">40</td>
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
