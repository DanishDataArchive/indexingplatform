xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/lib/search.xquery";


declare option exist:serialize "method=xhtml media-type=text/html";

declare function local:main() as node()? {
    session:create(),
    let $search-string := request:get-parameter("search-string", ())
    let $search-parameters :=
    <SearchParameters xmlns="http://dda.dk/ddi/search-parameters" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        { if (request:get-parameter("studyId", ())) then <studyId>{ request:get-parameter("studyId", ()) }</studyId> else () }
        { if (request:get-parameter("title", ())) then <title>{ request:get-parameter("title", ()) }</title> else () }
        { if (request:get-parameter("topicalCoverage", ())) then <topicalCoverage>{ request:get-parameter("topicalCoverage", ()) }</topicalCoverage> else () }
        { if (request:get-parameter("spatialCoverage", ())) then <spatialCoverage>{ request:get-parameter("spatialCoverage", ()) }</spatialCoverage> else () }
        { if (request:get-parameter("abstract-purpose", ())) then <abstract-purpose>{ request:get-parameter("abstract-purpose", ()) }</abstract-purpose> else () }
        { if (request:get-parameter("creator", ())) then <creator>{ request:get-parameter("creator", ()) }</creator> else () }
        { if (request:get-parameter("kindOfData", ())) then <kindOfData>{ request:get-parameter("kindOfData", ()) }</kindOfData> else () }
        { if (request:get-parameter("coverageFrom", ())) then <coverageFrom>{ request:get-parameter("coverageFrom", ()) }</coverageFrom> else () }
        { if (request:get-parameter("coverageTo", ())) then <coverageTo>{ request:get-parameter("coverageTo", ()) }</coverageTo> else () }
        { if (request:get-parameter("concept", ())) then <concept>{ request:get-parameter("concept", ()) }</concept> else () }
        { if (request:get-parameter("universe", ())) then <universe>{ request:get-parameter("universe", ()) }</universe> else () }
        { if (request:get-parameter("question", ())) then <question>{ request:get-parameter("question", ()) }</question> else () }
        { if (request:get-parameter("variable", ())) then <variable>{ request:get-parameter("variable", ()) }</variable> else () }
        { if (request:get-parameter("category", ())) then <category>{ request:get-parameter("category", ()) }</category> else () }
    </SearchParameters>
    
    let $result := ddi:advancedSearch($search-parameters, 10, 0)
    return
		if ($result) then
		    $result
		else
		        <p>Ingen resultater fundet.</p>
};

<html>
  <head><title>Simpel søgning</title></head>
  <body>
    <form action="{session:encode-url(request:get-uri())}">
      <table>
        <tr>
          <td>Study ID</td>
          <td><input type="text" name="studyId" size="40" /></td>
        </tr>
        <tr>
          <td>Title</td>
          <td><input type="text" name="title" size="40" /></td>
        </tr>
        <tr>
          <td>Topical Coverage</td>
          <td><input type="text" name="topicalCoverage" size="40" /></td>
        </tr>
        <tr>
          <td>Spatial Coverage</td>
          <td><input type="text" name="spatialCoverage" size="40" /></td>
        </tr>
        <tr>
          <td>Abstract/Purpose</td>
          <td><input type="text" name="abstract-purpose" size="40" /></td>
        </tr>
        <tr>
          <td>Creator</td>
          <td><input type="text" name="creator" size="40" /></td>
        </tr>
        <tr>
          <td>KindOfData</td>
          <td><input type="text" name="kindOfData" size="40" /></td>
        </tr>
        <tr>
          <td>Temporal Coverage</td>
          <td><input type="text" name="coverageFrom" size="17" /> <input type="text" name="coverageTo" size="16" /></td>
        </tr>
        <tr>
          <td colspan="2">-</td>
        </tr>
        <tr>
          <td>Concept</td>
          <td><input type="text" name="concept" size="40" /></td>
        </tr>
        <tr>
          <td>Universe</td>
          <td><input type="text" name="universe" size="40" /></td>
        </tr>
        <tr>
          <td>Question</td>
          <td><input type="text" name="question" size="40" /></td>
        </tr>
        <tr>
          <td>Variable</td>
          <td><input type="text" name="variable" size="40" /></td>
        </tr>
        <tr>
          <td>Category</td>
          <td><input type="text" name="category" size="40" /></td>
        </tr>
        <tr>
          <td colspan="2"><input type="submit" /></td>
        </tr>
      </table>
    </form>
        { local:main() }
  </body>
</html>