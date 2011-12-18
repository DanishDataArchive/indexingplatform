xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/lib/search.xquery";


declare option exist:serialize "method=xhtml media-type=text/html";

declare function local:main() as node()? {
    session:create(),

    let $search-string := request:get-parameter("search-string", ())
    
    return if ($search-string) then
	    let $simple-search-parameters := <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
         xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
         xmlns:ss="http://dda.dk/ddi/search-scope"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ssp:search-string>{$search-string}</ssp:search-string>
            <smd:SearchMetaData hits-perpage="10" hit-start="0"/>
            <ss:SearchScope>
                { if (request:get-parameter("studyUnit", ())) then <ss:StudyUnit/> else () }
                { if (request:get-parameter("concept", ())) then <ss:Concept/> else () }
                { if (request:get-parameter("universe", ())) then <ss:Universe/> else () }
                { if (request:get-parameter("question", ())) then <ss:Question/> else () }
                { if (request:get-parameter("variable", ())) then <ss:Variable/> else () }
                { if (request:get-parameter("category", ())) then <ss:Category/> else () }
            </ss:SearchScope>
        </ssp:SimpleSearchParameters>
	    let $result := ddi:simpleSearch($simple-search-parameters)
	
	    return $result
	else
		<p>Tom søgestreng!</p>
};

<html>
    <head><title>Simpel søgning</title></head>
    <body>
        <form action="{session:encode-url(request:get-uri())}">
            <input type="text" name="search-string" size="80" />
            <input type="submit" />
            <br />
            <input type="checkbox" name="studyUnit" checked="checked" />Study unit
            <input type="checkbox" name="concept" checked="checked" />Concept
            <input type="checkbox" name="universe" checked="checked" />Universe
            <input type="checkbox" name="question" checked="checked" />Question
            <input type="checkbox" name="variable" checked="checked" />Variable
            <input type="checkbox" name="category" checked="checked" />Category
        </form>
        { local:main() }
    </body>
</html>