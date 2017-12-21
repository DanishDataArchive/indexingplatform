xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {
    let $searchSubmitted := request:get-parameter('search-string', ())
    let $hits-perpage := request:get-parameter('hits-perpage', 50)
    let $lang := request:get-parameter('lang', "da")
    let $search-parameters :=
    if($searchSubmitted) then
        <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
            xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
            xmlns:s="http://dda.dk/ddi/scope"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ssp:search-string>{request:get-parameter('search-string', '')}</ssp:search-string>
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
    <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
        xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
        xmlns:s="http://dda.dk/ddi/scope"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <ssp:search-string></ssp:search-string>
        <smd:SearchMetaData hits-perpage="{$hits-perpage}" hit-start="1" lang="{$lang}"/>
        <s:Scope>
            <s:StudyUnit/>
            <!--s:Variable/-->
            <!--s:QuestionItem/>
            <s:MultipleQuestionItem/!-->
            <!--s:Universe/>
            <s:Concept/>
            <s:Category/-->
        </s:Scope>
    </ssp:SimpleSearchParameters>
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults :=
    if($searchSubmitted) then
        ddi:simpleSearch($search-parameters)
    else
        ddi:buildLightXmlObjectList((), $hits-perpage, 1, $search-parameters, false())
    
   let $grouped := request:get-parameter('grouped', '')
        
    let $params := <parameters>
            <param name="type" value="simple"/>
            <param name="grouped" value="{$grouped}"/>
            <param name="lang" value="{$lang}"/>
            <param name="hostname" value="@WEB-HOST_NAME@" />
            <param name="cataloguePath" value="/catalogue/" />            
        </parameters>
    
    return transform:transform($searchResults, $searchResultsStylesheet, $params)
};

local:main()
