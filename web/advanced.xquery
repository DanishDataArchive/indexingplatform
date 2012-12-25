xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {
    let $search-parameters := 
    <asp:AdvancedSearchParameters xmlns:sm="http://dda.dk/ddi/search-metadata"
     xmlns:s="http://dda.dk/ddi/scope"
     xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
     {
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
        <sm:SearchMetaData hits-perpage="10" hit-start="0"/>
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
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults := ddi:advancedSearch($search-parameters)
    let $params := <parameters>
            <param name="type" value="advanced"/>
            <param name="lang" value="da"/>
        </parameters>
    
    return transform:transform($searchResults, $searchResultsStylesheet, $params)
};

local:main()