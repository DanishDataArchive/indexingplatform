xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare function local:main() as node()? {
    let $search-parameters := request:get-data()/*
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults := ddi:advancedSearch($search-parameters)
    let $params := <parameters />
    
    return transform:transform($searchResults, $searchResultsStylesheet, $params)
};

local:main()