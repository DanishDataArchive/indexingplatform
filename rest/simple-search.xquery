xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/search.xquery";


declare option exist:serialize "method=xhtml media-type=text/xml";

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

local:main()