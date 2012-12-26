xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {
    let $searchSubmitted := request:get-parameter('search-string', ())
    let $search-parameters :=
    if($searchSubmitted) then
        <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
            xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
            xmlns:s="http://dda.dk/ddi/scope"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ssp:search-string>{request:get-parameter('search-string', '')}</ssp:search-string>
            <smd:SearchMetaData hits-perpage="10" hit-start="{request:get-parameter('hit-start', 1)}"/>
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
    <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
        xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
        xmlns:s="http://dda.dk/ddi/scope"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <ssp:search-string></ssp:search-string>
        <smd:SearchMetaData hits-perpage="10" hit-start="1"/>
        <s:Scope>
            <s:StudyUnit/>
            <s:Variable/>
            <s:QuestionItem/>
            <s:MultipleQuestionItem/>
            <s:Universe/>
            <s:Concept/>
            <s:Category/>
        </s:Scope>
    </ssp:SimpleSearchParameters>
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults :=
    if($searchSubmitted) then
        ddi:simpleSearch($search-parameters)
    else
        ddi:buildLightXmlObjectList((), (), 10, 1, $search-parameters)
    
    let $params := <parameters>
            <param name="type" value="simple"/>
            <param name="lang" value="da"/>
        </parameters>
    
    return transform:transform($searchResults, $searchResultsStylesheet, $params)
};

local:main()