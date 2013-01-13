xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {
    let $searchSubmitted := request:get-parameter('studyId', ()) or
                            request:get-parameter('title', ()) or
                            request:get-parameter('topicalCoverage', ()) or
                            request:get-parameter('spatialCoverage', ()) or
                            request:get-parameter('abstract-purpose', ()) or
                            request:get-parameter('creator', ()) or
                            request:get-parameter('kindOfData', ()) or
                            request:get-parameter('coverageFrom', ()) or
                            request:get-parameter('coverageTo', ()) or
                            request:get-parameter('QuestionItem', ()) or
                            request:get-parameter('Variable', ()) or
                            request:get-parameter('Category', ()) or
                            request:get-parameter('Concept', ()) or
                            request:get-parameter('Universe', ())
                          
    let $hits-perpage := request:get-parameter('hits-perpage', 50)
    let $lang := request:get-parameter('lang', "da")
                            
    let $search-parameters :=
    if($searchSubmitted) then
        <asp:AdvancedSearchParameters xmlns:sm="http://dda.dk/ddi/search-metadata"
         xmlns:s="http://dda.dk/ddi/scope"
         xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
         {
            if (request:get-parameter('studyId', ())) then <asp:studyId>{request:get-parameter('studyId', ())}</asp:studyId> else (),
            if (request:get-parameter('title', ())) then <asp:title>{request:get-parameter('title', ())}</asp:title> else (),
            if (request:get-parameter('topicalCoverage', ())) then <asp:topicalCoverage>{request:get-parameter('topicalCoverage', ())}</asp:topicalCoverage> else (),
            if (request:get-parameter('spatialCoverage', ())) then <asp:spatialCoverage>{request:get-parameter('spatialCoverage', ())}</asp:spatialCoverage> else (),
            if (request:get-parameter('abstract-purpose', ())) then <asp:abstract-purpose>{request:get-parameter('abstract-purpose', ())}</asp:abstract-purpose> else (),
            if (request:get-parameter('creator', ())) then <asp:creator>{request:get-parameter('creator', ())}</asp:creator> else (),
            if (request:get-parameter('kindOfData', ())) then <asp:kindOfData>{request:get-parameter('kindOfData', ())}</asp:kindOfData> else (),
            if (request:get-parameter('coverageFrom', ())) then <asp:coverageFrom>{request:get-parameter('coverageFrom', ())}</asp:coverageFrom> else (),
            if (request:get-parameter('coverageTo', ())) then <asp:coverageTo>{request:get-parameter('coverageTo', ())}</asp:coverageTo> else (),
            if (request:get-parameter('QuestionItem', ())) then (<asp:QuestionItem>{request:get-parameter('QuestionItem', ())}</asp:QuestionItem>, <asp:MultipleQuestionItem>{request:get-parameter('QuestionItem', ())}</asp:MultipleQuestionItem>) else (),
            if (request:get-parameter('Variable', ())) then <asp:Variable>{request:get-parameter('Variable', ())}</asp:Variable> else (),
            if (request:get-parameter('Category', ())) then <asp:Category>{request:get-parameter('Category', ())}</asp:Category> else (),
            if (request:get-parameter('Concept', ())) then <asp:Concept>{request:get-parameter('Concept', ())}</asp:Concept> else (),
            if (request:get-parameter('Universe', ())) then <asp:Universe>{request:get-parameter('Universe', ())}</asp:Universe> else ()
         }
            <sm:SearchMetaData hits-perpage="{$hits-perpage}" hit-start="{request:get-parameter('hit-start', 1)}" lang="{$lang}"/>
            <s:Scope>
            {
                if (request:get-parameter('StudyUnitChecked', ())) then <s:StudyUnit/> else (),
                if (request:get-parameter('VariableChecked', ())) then <s:Variable/> else (),
                if (request:get-parameter('QuestionItemChecked', ())) then (<s:QuestionItem/>,<s:MultipleQuestionItem/>) else (),
                if (request:get-parameter('UniverseChecked', ())) then <s:Universe/> else (),
                if (request:get-parameter('ConceptChecked', ())) then <s:Concept/> else (),
                if (request:get-parameter('CategoryChecked', ())) then <s:Category/> else ()
            }
            </s:Scope>
        </asp:AdvancedSearchParameters>
    else
        <asp:AdvancedSearchParameters xmlns:sm="http://dda.dk/ddi/search-metadata"
        xmlns:s="http://dda.dk/ddi/scope"
        xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
           <asp:studyId/>
           <asp:title/>
           <asp:topicalCoverage/>
           <asp:spatialCoverage/>
           <asp:abstract-purpose/>
           <asp:creator/>
           <asp:kindOfData/>
           <asp:coverageFrom/>
           <asp:coverageTo/>
           <asp:Variable/>
           <asp:QuestionItem/>
           <asp:MultipleQuestionItem/>
           <asp:Universe/>
           <asp:Concept/>
           <asp:Category/>
           <sm:SearchMetaData hits-perpage="{$hits-perpage}" hit-start="1" lang="{$lang}"/>
           <s:Scope>
               <s:StudyUnit/>
               <s:Variable/>
               <s:QuestionItem/>
               <s:MultipleQuestionItem/>
               <s:Universe/>
               <s:Concept/>
               <s:Category/>
           </s:Scope>
       </asp:AdvancedSearchParameters>
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults :=
    if($searchSubmitted) then
        ddi:advancedSearch($search-parameters)
    else
        ddi:buildLightXmlObjectList((), $hits-perpage, 1, $search-parameters, <advanced/>)
    
    let $grouped := request:get-parameter('grouped', ())
    
    let $params := <parameters>
            <param name="type" value="advanced"/>
            <param name="grouped" value="{$grouped}"/>
            <param name="lang" value="{$lang}"/>
            <param name="hostname" value="localhost" />
        </parameters>
    
    return transform:transform($searchResults, $searchResultsStylesheet, $params)
};

local:main()