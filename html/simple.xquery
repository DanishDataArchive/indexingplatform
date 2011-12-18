xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/search.xquery";(:"xmldb:exist:///db/dda/result-functions.xquery":)


declare option exist:serialize "method=xhtml media-type=text/html";

declare function local:main() as node()? {
    session:create(),
    let $search-string := request:get-parameter("search-string", ())
    let $scope :=
    <SearchScope xmlns="http://dda.dk/ddi/search-scope"
    xsi:schemaLocation="http://dda.dk/ddi/search-scope xmldb:exist:///db/dda/schema/search-scope.xsd">
        { if (request:get-parameter("studyUnit", ())) then <StudyUnit/> else () }
        { if (request:get-parameter("concept", ())) then <Concept/> else () }
        { if (request:get-parameter("universe", ())) then <Universe/> else () }
        { if (request:get-parameter("question", ())) then <Question/> else () }
        { if (request:get-parameter("variable", ())) then <Variable/> else () }
        { if (request:get-parameter("category", ())) then <Category/> else () }
    </SearchScope>
    let $result := ddi:simpleSearch($search-string, 10, 0, $scope)
    return
		if ($search-string) then
		    if ($result) then
		        $result
		    else
		        <p>Ingen elementer matcher søgeordet '{$search-string}'.</p>
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