xquery version "3.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";
declare namespace json="http://www.json.org";
declare namespace smd="http://dda.dk/ddi/search-metadata";
declare namespace request="http://exist-db.org/xquery/request";

declare function local:main() as node()? {
    (: set serialization mime type :)
    let $response := 
    if (local:getAcceptType()='xml') then
        util:declare-option("exist:serialize", "media-type=text/xml")
    else
        util:declare-option("exist:serialize", "method=json media-type=text/javascript")

    (: define search parameters :)
    let $searchString := request:get-parameter('search-string', ())
    let $hits-perpage := request:get-parameter('hits-perpage', 50)
    let $lang := request:get-parameter('lang', "da")
    
    let $search-parameters :=
    if ($searchString) then
            (: url parameters :)
            <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
            xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
            xmlns:s="http://dda.dk/ddi/scope"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ssp:search-string>{$searchString}</ssp:search-string>
            <smd:SearchMetaData hits-perpage="{$hits-perpage}" hit-start="{request:get-parameter('hit-start', 1)}" lang="{$lang}"/>
            <s:Scope>
            {
                if (request:get-parameter('StudyUnit', ())) then <s:StudyUnit/> else (),
                if (request:get-parameter('Variable', ())) then <s:Variable/> else (),
                if (request:get-parameter('QuestionItem', ())) then (<s:QuestionItem/>,<s:MultipleQuestionItem/>) else (),
                if (request:get-parameter('Universe', ())) then <s:Universe/> else (),
                if (request:get-parameter('Concept', ())) then <s:Concept/> else (),
                if (request:get-parameter('Category', ())) then <s:Category/> else ()
            }
            </s:Scope>
            </ssp:SimpleSearchParameters>
    else
        (
            (: xml data request data :)
            request:get-data()/*
        )
        
    (: request search :)
    return ddi:simpleSearch($search-parameters)
};

declare %private function local:getAcceptType() {
    let $header := request:get-header("Accept")
    let $header := if (contains($header, ";")) then substring-before($header, ";") else $header
    let $types := tokenize($header, "\s*,\s*")
    
    let $result := 
    if (contains($types[1], 'json')) then
        'json'
    else if(contains($types[1], 'xml')) then
        'xml'
    else
        'xml'
    
    return $result
};

local:main()
