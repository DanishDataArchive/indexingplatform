(: Example code for jfreechart module :)
(: Load the data files into /db :)
(: $Id: piedata.xq 8838 2009-04-14 18:01:51Z dizzzz $ :)
declare namespace jfreechart = "http://exist-db.org/xquery/jfreechart";

jfreechart:stream-render("PieChart",

<configuration>
    <orientation>Horizontal</orientation>
    <height>500</height>
    <width>500</width>
    <title>Example 2</title>
</configuration>, 

doc('/db/piedata.xml'))
