xquery version "1.0";

(:~
 : This module contains the search functions and is used by other XQuery scripts to retrieve the data from the database.
 : The main functions for this are <b>dda:simpleSearch</b>  and <b>dda:advancedSearch</b>.
 : Additionally, it is possible to retrieve a specific DDI element by its ID using the <b>dda:lookupXXX</b> functions.<br />
 : The rest of the functions are local and cannot be used externally.
 :)
module namespace ddi = "http://dda.dk/ddi";

import module namespace result = "http://dda.dk/ddi/result" at "xmldb:exist:///db/apps/dda/lib/result-functions.xquery";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

declare namespace ssp="http://dda.dk/ddi/simple-search-parameters";
declare namespace asp="http://dda.dk/ddi/advanced-search-parameters";
declare namespace smd="http://dda.dk/ddi/search-metadata";
declare namespace s="http://dda.dk/ddi/scope";
declare namespace d="http://dda.dk/ddi/denormalized-ddi";


(:~
 : Makes a free-text search in StudyUnit elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function ddi:getDdiStudy($studyId as xs:string) as element()* {
    let $study := collection('/db/apps/dda')//su:StudyUnit[ft:query(@id, $studyId)]
    return $study/ancestor::i:DDIInstance
};

(:~
 : Makes a free-text search in StudyUnit elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryStudyUnit($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//su:StudyUnit[ft:query(@id, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Citation/r:Creator, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Citation/r:Title, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Coverage/r:TopicalCoverage/r:Keyword, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Coverage/r:SpatialCoverage/r:TopLevelReference/r:LevelName, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(su:Abstract/r:Content, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(su:Purpose/r:Content, $search-string)] |
        collection('/db/apps/dda')//su:StudyUnit[ft:query(su:KindOfData, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in Concept elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryConcept($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//cc:Concept[ft:query(r:Label, $search-string)] |
        collection('/db/apps/dda')//cc:Concept[ft:query(r:Description, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in Universe elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryUniverse($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//cc:Universe[ft:query(r:Label, $search-string)] |
        collection('/db/apps/dda')//cc:Universe[ft:query(cc:HumanReadable, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in QuestionItem elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryQuestionItem($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//dc:QuestionItem[ft:query(dc:QuestionText/dc:LiteralText/dc:Text, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in MultipleQuestionItem elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryMultipleQuestionItem($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//dc:MultipleQuestionItem[ft:query(dc:MultipleQuestionItemName, $search-string)] |
        collection('/db/apps/dda')//dc:MultipleQuestionItem[ft:query(dc:QuestionText/dc:LiteralText/dc:Text, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in Variable elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryVariable($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//lp:Variable[ft:query(lp:VariableName, $search-string)] |
        collection('/db/apps/dda')//lp:Variable[ft:query(r:Label, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Makes a free-text search in Category elements and returns the element(s) containing the match
 : It also sorts the list by score in descending order
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryCategory($search-string as xs:string) as element()* {
    let $list :=
        collection('/db/apps/dda')//lp:Category[ft:query(r:Label, $search-string)]
    for $element in $list
        order by ft:score($element) descending
        return $element
};

(:~
 : Searches for a QuestionItem and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $questionItemId    the ID of the QuestionItem
 :)
declare function ddi:lookupQuestionItem($questionItemId as xs:string) as element() {
    let $questionItem := collection('/db/apps/dda')//dc:QuestionItem[ft:query(@id, $questionItemId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($questionItem)}
    </dl:LightXmlObjectList>
};

(:~
 : Searches for a MultipleQuestionItem and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $multipleQuestionItemId    the ID of the MultipleQuestionItem
 :)
declare function ddi:lookupMultipleQuestionItem($multipleQuestionItemId as xs:string) as element() {
    let $multipleQuestionItem := collection('/db/apps/dda')//dc:MultipleQuestionItem[ft:query(@id, $multipleQuestionItemId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($multipleQuestionItem)}
    </dl:LightXmlObjectList>
};

(:~
 : Searches for a Variable and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $variableId    the ID of the Variable
 :)
declare function ddi:lookupVariable($variableId as xs:string) as element() {
    let $variable := collection('/db/apps/dda')//lp:Variable[ft:query(@id, $variableId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($variable)}
    </dl:LightXmlObjectList>
};

(:~
 : Searches for a Concept and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $conceptId    the ID of the Concept
 :)
declare function ddi:lookupConcept($conceptId as xs:string) as element() {
    let $concept := collection('/db/apps/dda')//cc:Concept[ft:query(@id, $conceptId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($concept)}
    </dl:LightXmlObjectList>
};

(:~
 : Searches for a Universe and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $universeId    the ID of the Universe
 :)
declare function ddi:lookupUniverse($universeId as xs:string) as element() {
    let $universe := collection('/db/apps/dda')//cc:Universe[ft:query(@id, $universeId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($universe)}
    </dl:LightXmlObjectList>
};

(:~
 : Searches for a Category and returns a LightXmlObjectList element with the result
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $categoryId    the ID of the Category
 :)
declare function ddi:lookupCategory($categoryId as xs:string) as element() {
    let $category := collection('/db/apps/dda')//lp:Category[ft:query(@id, $categoryId)]
    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:smd="http://dda.dk/ddi/search-metadata">
            {result:buildResultListItem($category)}
    </dl:LightXmlObjectList>
};

(:~
 : Makes a LightXmlObjectList element containing the info based on the result list
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $results the result list to process
 : @param   $hits-perpage  the number of hits to be shown per page
 : @param   $hit-start     number of the first hit to be shown on the page
 :)
declare function ddi:buildLightXmlObjectList($results as element()*, $hits-perpage as xs:integer, $hit-start as xs:integer, $search-parameters as element()) as element() {
    let $result-count := count($results)
    let $hit-end := if ($result-count lt $hits-perpage) then $result-count
                    else $hit-start + $hits-perpage - 1
    let $hit-end-corrected := if ($result-count lt $hit-end) then $result-count
                    else $hit-end
    let $number-of-pages :=  xs:integer(ceiling($result-count div $hits-perpage))
    let $current-page := xs:integer(($hit-start + $hits-perpage) div $hits-perpage)

    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:rmd="http://dda.dk/ddi/result-metadata">
        {$search-parameters}
        <rmd:ResultMetaData
            result-count="{$result-count}"
            hit-start="{$hit-start}"
            hit-end="{$hit-end-corrected}"
            hits-perpage="{$hits-perpage}"
            number-of-pages="{$number-of-pages}"
            current-page="{$current-page}"/>
        {
        for $result in $results[position() = $hit-start to $hit-end]
            return result:buildResultListItem($result)
        }
    </dl:LightXmlObjectList>
};

(:~
 : Makes a free-text search in all indexed elements and returns a list of LightXmlObject elements with the results
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-parameters the search parameters wrapped in a SimpleSearchParameters element with the following format:<br/>
 :<pre>
 :&lt;ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"<br/>
 : xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"<br/>
 : xmlns:s="http://dda.dk/ddi/scope"<br/>
 : xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;<br/>
 :    &lt;ssp:search-string&gt;some text&lt;/ssp:search-string&gt;        &lt;!-- The text we are searching for (xs:string). Required. --&gt;<br/>
 :    &lt;smd:SearchMetaData hits-perpage="10" hit-start="0"/&gt;         &lt;!-- The number of hits we wish to show per page (xs:positiveInteger) and the number of the first result we wish to get (xs:nonNegativeInteger). Both required. --&gt;<br/>
 :    &lt;s:Scope&gt;                                                     &lt;!-- The scope of our search. Each child-element is optional and if it is present the search will return results of the type specified by that element (if found). The child-elements have no type or content; only the existence is checked. --&gt;<br/>
 :        &lt;s:StudyUnit/&gt;<br/>
 :        &lt;s:Variable/&gt;<br/>
 :        &lt;s:QuestionItem/&gt;<br/>
 :        &lt;s:MultipleQuestionItem/&gt;<br/>
 :        &lt;s:Universe/&gt;<br/>
 :        &lt;s:Concept/&gt;<br/>
 :        &lt;s:Category/&gt;<br/>
 :    &lt;/s:Scope&gt;<br/>
 :&lt;/ssp:SimpleSearchParameters&gt;<br/>
 :</pre>
 : With this function it is not possible to set the reference scope, i.e. the list of types we wish to return references to.
 : It sends results to processing with an empty scope resulting in the default list being used, which is:
 :<pre>
 :  For Variable:              &lt;s:Scope&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;s:RepresentationType/&gt;&lt;/s:Scope&gt;<br />
 :  For QuestionItem:          &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;s:DomainType/&gt;&lt;/s:Scope&gt;<br />
 :  For MultipleQuestionItem:  &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;/s:Scope&gt;<br />
 :  For Universe:              &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;/s:Scope&gt;<br />
 :  For Concept:               &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;/s:Scope&gt;<br />
 :  For Category:              &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;/s:Scope&gt;<br />
 :</pre>
 :)
declare function ddi:simpleSearch($search-parameters as element()) as element() {
    let $search-string := data($search-parameters/ssp:search-string)
    let $search-metadata := $search-parameters/smd:SearchMetaData
    let $search-scope := $search-parameters/s:Scope

    (: For each element type check if we wish to include it in our search (if it is included in the scope). :)
    let $studyUnitScope := if ($search-scope/s:StudyUnit) then local:queryStudyUnit($search-string) else ()
    let $conceptScope := if ($search-scope/s:Concept) then local:queryConcept($search-string) else ()
    let $universeScope := if ($search-scope/s:Universe) then local:queryUniverse($search-string) else ()
    let $questionItemScope := if ($search-scope/s:QuestionItem) then local:queryQuestionItem($search-string) else ()
    let $multipleQuestionItemScope := if ($search-scope/s:MultipleQuestionItem) then local:queryMultipleQuestionItem($search-string) else ()
    let $variableScope := if ($search-scope/s:Variable) then local:queryVariable($search-string) else ()
    let $categoryScope := if ($search-scope/s:Category) then local:queryCategory($search-string) else ()
    
    let $results :=
    (
        $studyUnitScope            ,
        $conceptScope              ,
        $universeScope             ,
        $questionItemScope         ,
        $multipleQuestionItemScope ,
        $variableScope             ,
        $categoryScope
    )

    return ddi:buildLightXmlObjectList($results, data($search-metadata/@hits-perpage), data($search-metadata/@hit-start), $search-parameters)
};

(:~
 : Makes a free-text search in all indexed elements and returns a list of LightXmlObject elements with the results
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-parameters the search parameters wrapped in a AdvancedSearchParameters element with the following format:<br/>
 :<pre>
 :&lt;asp:AdvancedSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"<br/>
 : xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"<br/>
 : xmlns:s="http://dda.dk/ddi/scope"<br/>
 : xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"&gt;<br/>
 :    &lt;asp:studyId&gt;studyId0&lt;/asp:studyId&gt;                                              &lt;!-- Id of the StudyUnit we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:title&gt;title0&lt;/asp:title&gt;                                                    &lt;!-- Title of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:topicalCoverage&gt;topicalCoverage0&lt;/asp:topicalCoverage&gt;                      &lt;!-- TopicalCoverage of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:spatialCoverage&gt;spatialCoverage0&lt;/asp:spatialCoverage&gt;                      &lt;!-- SpatialCoverage of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:abstract-purpose&gt;abstract-purpose0&lt;/asp:abstract-purpose&gt;                   &lt;!-- Purpose of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:creator&gt;creator0&lt;/asp:creator&gt;                                              &lt;!-- Creator of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:kindOfData&gt;kindOfData0&lt;/asp:kindOfData&gt;                                     &lt;!-- KindOfData of the StudyUnit(s) we wish to limit the results to (xs:string). Optional. --&gt;<br/>
 :    &lt;asp:coverageFrom&gt;2006-05-04&lt;/asp:coverageFrom&gt;                                  &lt;!-- Starting coverage date of the StudyUnit we wish to limit the results to (xs:date). Optional. --&gt;<br/>
 :    &lt;asp:coverageTo&gt;2006-05-04&lt;/asp:coverageTo&gt;                                      &lt;!-- Ending coverage date of the StudyUnit we wish to limit the results to (xs:date). Optional. --&gt;<br/>
 :    &lt;asp:Variable&gt;variable text&lt;/asp:Variable&gt;                                       &lt;!-- Search-text for the Variable(s) we wish to find (xs:string). If left out Variable will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;asp:QuestionItem&gt;questionItem text&lt;/asp:QuestionItem&gt;                           &lt;!-- Search-text for the QuestionItem(s) we wish to find (xs:string). If left out QuestionItem will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;asp:MultipleQuestionItem&gt;multipleQuestionItem text&lt;/asp:MultipleQuestionItem&gt;   &lt;!-- Search-text for the MultipleQuestionItem(s) we wish to find (xs:string). If left out MultipleQuestionItem will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;asp:Universe&gt;universe text&lt;/asp:Universe&gt;                                       &lt;!-- Search-text for the Universe(s) we wish to find (xs:string). If left out Universe will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;asp:Concept&gt;concept text&lt;/asp:Concept&gt;                                          &lt;!-- Search-text for the Coverage(s) we wish to find (xs:string). If left out Coverage will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;asp:Category&gt;category text&lt;/asp:Category&gt;                                       &lt;!-- Search-text for the Category(s) we wish to find (xs:string). If left out Category will not be searched and returned. Optional. --&gt;<br/>
 :    &lt;smd:SearchMetaData hits-perpage="2" hit-start="1"/&gt;                                   &lt;!-- The number of hits we wish to show per page (xs:positiveInteger) and the number of the first result we wish to get (xs:nonNegativeInteger). Both required. --&gt;<br/>
 :    &lt;s:Scope&gt;                                                                              &lt;!-- The scope of our results. Each child-element is optional and if it is present the search will return results of that type. The child-elements have no type or content; only the existence is checked. --&gt;<br/>
 :        &lt;s:StudyUnit/&gt;<br/>
 :        &lt;s:Variable/&gt;<br/>
 :        &lt;s:QuestionItem/&gt;<br/>
 :        &lt;s:MultipleQuestionItem/&gt;<br/>
 :        &lt;s:Universe/&gt;<br/>
 :        &lt;s:Concept/&gt;<br/>
 :        &lt;s:Category/&gt;<br/>
 :    &lt;/s:Scope&gt;<br/>
 :&lt;/asp:AdvancedSearchParameters&gt;<br/>
 :</pre>
 :)
declare function ddi:advancedSearch($search-parameters as element()) as element()* {
    (: Note that in the comments below the word "element" referes to either Variable, QuestionItem, MultipleQuestionItem, Universe, Concept or Category. :)
    let $search-scope := $search-parameters/s:Scope
    
    let $studyUnits := local:studyUnitsFromParameters($search-parameters)
    
    
    
    
    
    (:  NEW SEARCH IMPLEMENTATION  :)
    
    
    (: For each element type find out if we want to filter by that type of element (if the parameter specifying the search-text for that element is set and not empty). :)
    let $variableSearch := if (data($search-parameters/asp:Variable)) then true() else false()
    let $questionItemSearch := if (data($search-parameters/asp:QuestionItem)) then true() else false()
    let $multipleQuestionItemSearch := if (data($search-parameters/asp:MultipleQuestionItem)) then true() else false()
    let $universeSearch := if (data($search-parameters/asp:Universe)) then true() else false()
    let $conceptSearch := if (data($search-parameters/asp:Concept)) then true() else false()
    let $categorySearch := if (data($search-parameters/asp:Category)) then true() else false()

    let $searchSpecificElements :=
        $variableSearch             or
        $questionItemSearch         or
        $multipleQuestionItemSearch or
        $universeSearch             or
        $conceptSearch              or
        $categorySearch
        
    let $studyParametersEntered := $search-parameters/asp:studyId          or
                                   $search-parameters/asp:title            or
                                   $search-parameters/asp:topicalCoverage  or
                                   $search-parameters/asp:spatialCoverage  or
                                   $search-parameters/asp:abstract-purpose or
                                   $search-parameters/asp:creator          or
                                   $search-parameters/asp:kindOfData       or
                                   $search-parameters/asp:coverageFrom     or
                                   $search-parameters/asp:coverageTo
                                   
    (: If any of the element-specific parameters are set than we want to filter by those elements. :)
    (: In that case we do not look for our results in the list of studies acquired by the study-specific parameters, but in the list of elements found by the element-specific parameters. :)
    (: We will query for a specific element type if (and only if) its parameter has been set. :)
    (: The studies are used to limit the list of elements to the studies that satisfy certain criteria. :)
    (: This means that if no elements are found we will return 0 results, regardless of the list of found studies. :)
    let $variableResults := if ($variableSearch) then local:queryVariable($search-parameters/asp:Variable) else ()
    let $usableVariables :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $variable in $variableResults
                    let $denormalizedVariable := collection('/db/apps/dda-denormalization')//d:Variable[ft:query(@id, $variable/@id)]
                    return if ($studyUnits[@id = $denormalizedVariable/@studyId]) then $variable else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $variableResults
            
    let $questionItemResults := if ($questionItemSearch) then local:queryQuestionItem($search-parameters/asp:QuestionItem) else ()
    let $usableQuestionItems :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $questionItem in $questionItemResults
                    let $denormalizedQuestionItem := collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(@id, $questionItem/@id)]
                    return if ($studyUnits[@id = $denormalizedQuestionItem/@studyId]) then $questionItem else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $questionItemResults
            
    let $multipleQuestionItemResults := if ($multipleQuestionItemSearch) then local:queryMultipleQuestionItem($search-parameters/asp:MultipleQuestionItem) else ()
    let $usableMultipleQuestionItems :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $multipleQuestionItem in $multipleQuestionItemResults
                    let $denormalizedMultipleQuestionItem := collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(@id, $multipleQuestionItem/@id)]
                    return if ($studyUnits[@id = $denormalizedMultipleQuestionItem/@studyId]) then $multipleQuestionItem else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $multipleQuestionItemResults
    
    let $universeResults := if ($universeSearch) then local:queryUniverse($search-parameters/asp:Universe) else ()
    let $usableUniverses :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $universe in $universeResults
                    let $denormalizedUniverse := collection('/db/apps/dda-denormalization')//d:Universe[ft:query(@id, $universe/@id)]
                    return if ($studyUnits[@id = $denormalizedUniverse/@studyId]) then $universe else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $universeResults
            
    let $conceptResults := if ($conceptSearch) then local:queryConcept($search-parameters/asp:Concept) else ()
    let $usableConcepts :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $concept in $conceptResults
                    let $denormalizedConcept := collection('/db/apps/dda-denormalization')//d:Concept[ft:query(@id, $concept/@id)]
                    return if ($studyUnits[@id = $denormalizedConcept/@studyId]) then $concept else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $conceptResults
            
    let $categoryResults := if ($categorySearch) then local:queryCategory($search-parameters/asp:Category) else ()
    let $usableCategories :=
            (: If study unit parameters were set then we limit the found elements to those which are in the specified study units. :)
            if ($studyParametersEntered) then
                (: For each element-type we get the ID of the StudyUnit in which it resides and if that study exists in the study-list previously found we return the element. :)
                for $category in $categoryResults
                    let $denormalizedCategory := collection('/db/apps/dda-denormalization')//d:Category[ft:query(@id, $category/@id)]
                    return if ($studyUnits[@id = $denormalizedCategory/@studyId]) then $category else ()
            (: If no study unit parameters were set then we just use all the found elements. :)
            else $categoryResults
    
        
    let $foundVariables :=
        if ($search-scope/s:Variable) then
            let $variablesFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(@id, $element/@id)]
            let $variablesFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(@studyId, $element/@id)]
            let $variablesFromQuestionItems := for $element in $usableQuestionItems return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(d:QuestionItemReference/@id, $element/@id)]
            let $variablesFromMultipleQuestionItems := for $element in $usableMultipleQuestionItems return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(d:MultipleQuestionItemReference/@id, $element/@id)]
            let $variablesFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(d:UniverseReference/@id, $element/@id)]
            let $variablesFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(d:ConceptReference/@id, $element/@id)]
            let $variablesFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:Variable[ft:query(d:CategoryReference/@id, $element/@id)]
            return local:conditionalIntersection($variablesFromVariables, $variableSearch,
                                                 $variablesFromStudies, $studyParametersEntered,
                                                 $variablesFromQuestionItems, $questionItemSearch,
                                                 $variablesFromMultipleQuestionItems, $multipleQuestionItemSearch,
                                                 $variablesFromUniverses, $universeSearch,
                                                 $variablesFromConcepts, $conceptSearch,
                                                 $variablesFromCategories, $categorySearch)
        else ()
        
    let $foundQuestionItems :=
        if ($search-scope/s:QuestionItem) then
            let $questionItemsFromQuestionItems := for $element in $usableQuestionItems return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(@id, $element/@id)]
            let $questionItemsFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(@studyId, $element/@id)]
            let $questionItemsFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(d:VariableReference/@id, $element/@id)]
            let $questionItemsFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(d:UniverseReference/@id, $element/@id)]
            let $questionItemsFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(d:ConceptReference/@id, $element/@id)]
            let $questionItemsFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:QuestionItem[ft:query(d:CategoryReference/@id, $element/@id)]
            return local:conditionalIntersection($questionItemsFromQuestionItems, $questionItemSearch,
                                                 $questionItemsFromStudies, $studyParametersEntered,
                                                 $questionItemsFromVariables, $variableSearch,
                                                 $questionItemsFromUniverses, $universeSearch,
                                                 $questionItemsFromConcepts, $conceptSearch,
                                                 $questionItemsFromCategories, $categorySearch,
                                                 (), false())
        else ()
        
    let $foundMultipleQuestionItems :=
        if ($search-scope/s:MultipleQuestionItem) then
            let $multipleQuestionItemsFromMultipleQuestionItems := for $element in $usableMultipleQuestionItems return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(@id, $element/@id)]
            let $multipleQuestionItemsFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(@studyId, $element/@id)]
            let $multipleQuestionItemsFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(d:VariableReference/@id, $element/@id)]
            let $multipleQuestionItemsFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(d:UniverseReference/@id, $element/@id)]
            let $multipleQuestionItemsFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(d:ConceptReference/@id, $element/@id)]
            let $multipleQuestionItemsFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:MultipleQuestionItem[ft:query(d:CategoryReference/@id, $element/@id)]
            return local:conditionalIntersection($multipleQuestionItemsFromMultipleQuestionItems, $multipleQuestionItemSearch,
                                                 $multipleQuestionItemsFromStudies, $studyParametersEntered,
                                                 $multipleQuestionItemsFromVariables, $variableSearch,
                                                 $multipleQuestionItemsFromUniverses, $universeSearch,
                                                 $multipleQuestionItemsFromConcepts, $conceptSearch,
                                                 $multipleQuestionItemsFromCategories, $categorySearch,
                                                 (), false())
        else ()
        
    let $foundUniverses :=
        if ($search-scope/s:Universe) then
            let $universesFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(@id, $element/@id)]
            let $universesFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(@studyId, $element/@id)]
            let $universesFromQuestionItems := for $element in $usableQuestionItems return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(d:QuestionItemReference/@id, $element/@id)]
            let $universesFromMultipleQuestionItems := for $element in $usableMultipleQuestionItems return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(d:MultipleQuestionItemReference/@id, $element/@id)]
            let $universesFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(d:VariableReference/@id, $element/@id)]
            let $universesFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(d:ConceptReference/@id, $element/@id)]
            let $universesFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:Universe[ft:query(d:CategoryReference/@id, $element/@id)]
            return local:conditionalIntersection($universesFromUniverses, $universeSearch,
                                                 $universesFromStudies, $studyParametersEntered,
                                                 $universesFromQuestionItems, $questionItemSearch,
                                                 $universesFromMultipleQuestionItems, $multipleQuestionItemSearch,
                                                 $universesFromVariables, $variableSearch,
                                                 $universesFromConcepts, $conceptSearch,
                                                 $universesFromCategories, $categorySearch)
        else ()
        
    let $foundConcepts :=
        if ($search-scope/s:Concept) then
            let $conceptsFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(@id, $element/@id)]
            let $conceptsFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(@studyId, $element/@id)]
            let $conceptsFromQuestionItems := for $element in $usableQuestionItems return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(d:QuestionItemReference/@id, $element/@id)]
            let $conceptsFromMultipleQuestionItems := for $element in $usableMultipleQuestionItems return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(d:MultipleQuestionItemReference/@id, $element/@id)]
            let $conceptsFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(d:UniverseReference/@id, $element/@id)]
            let $conceptsFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(d:VariableReference/@id, $element/@id)]
            let $conceptsFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:Concept[ft:query(d:CategoryReference/@id, $element/@id)]
            return local:conditionalIntersection($conceptsFromConcepts, $conceptSearch,
                                                 $conceptsFromStudies, $studyParametersEntered,
                                                 $conceptsFromQuestionItems, $questionItemSearch,
                                                 $conceptsFromMultipleQuestionItems, $multipleQuestionItemSearch,
                                                 $conceptsFromUniverses, $universeSearch,
                                                 $conceptsFromVariables, $variableSearch,
                                                 $conceptsFromCategories, $categorySearch)
        else ()
        
    let $foundCategories :=
        if ($search-scope/s:Category) then
            let $categoriesFromCategories := for $element in $usableCategories return collection('/db/apps/dda-denormalization')//d:Category[ft:query(@id, $element/@id)]
            let $categoriesFromStudies := for $element in $studyUnits return collection('/db/apps/dda-denormalization')//d:Category[ft:query(@studyId, $element/@id)]
            let $categoriesFromQuestionItems := for $element in $usableQuestionItems return collection('/db/apps/dda-denormalization')//d:Category[ft:query(d:QuestionItemReference/@id, $element/@id)]
            let $categoriesFromMultipleQuestionItems := for $element in $usableMultipleQuestionItems return collection('/db/apps/dda-denormalization')//d:Category[ft:query(d:MultipleQuestionItemReference/@id, $element/@id)]
            let $categoriesFromUniverses := for $element in $usableUniverses return collection('/db/apps/dda-denormalization')//d:Category[ft:query(d:UniverseReference/@id, $element/@id)]
            let $categoriesFromConcepts := for $element in $usableConcepts return collection('/db/apps/dda-denormalization')//d:Category[ft:query(d:ConceptReference/@id, $element/@id)]
            let $categoriesFromVariables := for $element in $usableVariables return collection('/db/apps/dda-denormalization')//d:Category[ft:query(d:VariableReference/@id, $element/@id)]
            return local:conditionalIntersection($categoriesFromCategories, $categorySearch,
                                                 $categoriesFromStudies, $studyParametersEntered,
                                                 $categoriesFromQuestionItems, $questionItemSearch,
                                                 $categoriesFromMultipleQuestionItems, $multipleQuestionItemSearch,
                                                 $categoriesFromUniverses, $universeSearch,
                                                 $categoriesFromConcepts, $conceptSearch,
                                                 $categoriesFromVariables, $variableSearch)
        else ()
    
    (:let $studyUnitScope := if ($search-scope/s:StudyUnit) then local:queryStudyUnit($search-string) else ()
    let $conceptScope := if ($search-scope/s:Concept) then local:queryConcept($search-string) else ()
    let $universeScope := if ($search-scope/s:Universe) then local:queryUniverse($search-string) else ()
    let $questionItemScope := if ($search-scope/s:QuestionItem) then local:queryQuestionItem($search-string) else ()
    let $multipleQuestionItemScope := if ($search-scope/s:MultipleQuestionItem) then local:queryMultipleQuestionItem($search-string) else ()
    let $variableScope := if ($search-scope/s:Variable) then local:queryVariable($search-string) else ()
    let $categoryScope := if ($search-scope/s:Category) then local:queryCategory($search-string) else ():)
    
    
    let $results := ($foundVariables, $foundQuestionItems, $foundMultipleQuestionItems, $foundUniverses, $foundConcepts, $foundCategories)

    return ddi:buildLightXmlObjectList($results, data($search-parameters/smd:SearchMetaData/@hits-perpage), data($search-parameters/smd:SearchMetaData/@hit-start), $search-parameters)
    (:return $results:)
};

declare function local:studyUnitsFromParameters($search-parameters as element()) as element()* {
    (: First check if any of the parameters regarding StudyUnit are set, and for each one that is get a separate list of StudyUnits based on that criteria. :)
    (: We will later use intersection to only get the list of StudyUnits that satisfy all the set criteria. :)
    (: The reason why we do not simply put all the criteria in one query is that all the parameters are optional, which means that we have to check if they are set and only use them if they are. :)
    let $studyFromId :=
        if($search-parameters/asp:studyId) then
            let $studyId := string($search-parameters/asp:studyId)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(@id, $studyId)] else ()
    let $studyFromTitle :=
        if($search-parameters/asp:title) then
            let $studyTitle := string($search-parameters/asp:title)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Citation/r:Title, $studyTitle)] else ()
    let $studyFromTopicalCoverage :=
        if($search-parameters/asp:topicalCoverage) then
            let $studyTopicalCoverage := string($search-parameters/asp:topicalCoverage)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Coverage/r:TopicalCoverage/r:Keyword, $studyTopicalCoverage)] else ()
    let $studyFromSpatialCoverage :=
        if($search-parameters/asp:spatialCoverage) then
            let $studySpatialCoverage := string($search-parameters/asp:spatialCoverage)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Coverage/r:SpatialCoverage/r:TopLevelReference/r:LevelName, $studySpatialCoverage)] else ()
    let $studyFromAbstractPurpose :=
        if($search-parameters/asp:abstract-purpose) then
            let $studyAbstractPurpose := string($search-parameters/asp:abstract-purpose)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(su:Abstract/r:Content, $studyAbstractPurpose)] | 
                   collection('/db/apps/dda')//su:StudyUnit[ft:query(su:Purpose/r:Content, $studyAbstractPurpose)] else ()
    let $studyFromCreator :=
        if($search-parameters/asp:creator) then
            let $studyCreator := string($search-parameters/asp:creator)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(r:Citation/r:Creator, $studyCreator)] else ()
    let $studyFromKindOfData :=
        if($search-parameters/asp:kindOfData) then
            let $studyKindOfData := string($search-parameters/asp:kindOfData)
            return collection('/db/apps/dda')//su:StudyUnit[ft:query(su:KindOfData, $studyKindOfData)] else ()
    let $studyFromTemporalCoverage :=
        (: Is start-date for TemporalCoverage is entered ... :)
        if($search-parameters/asp:coverageFrom) then
            let $studyFrom := dateTime($search-parameters/asp:coverageFrom, xs:time('00:00:00.000+01:00'))
            (: ... check if end-date also is entered. If so then find only those studies whose both start and end dates are within the specified interval (both dates including) :)
            return if($search-parameters/asp:coverageTo) then
                let $studyTo := dateTime($search-parameters/asp:coverageTo, xs:time('00:00:00.000+01:00'))
                return collection('/db/apps/dda')//su:StudyUnit[r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:StartDate ge $studyFrom and r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:EndDate le $studyTo] 
            (: If no end-date is entered then find those studies whose start-date is later (or same) then the specified start-date. :)
            else
                collection('/db/apps/dda')//su:StudyUnit[r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:StartDate ge $studyFrom]
        (: If no start-date is entered ... :)
        else
            (: ... check if end-date is entered. If so then find those studies whose end-date is earlier (or same) then the specified end-date. :)
            if($search-parameters/asp:coverageTo) then
                let $studyTo := dateTime($search-parameters/asp:coverageTo, xs:time('00:00:00.000+01:00'))
                return collection('/db/apps/dda')//su:StudyUnit[r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:EndDate le $studyTo]
            else ()
    
    let $studyUnitUnion :=
        $studyFromId               |
        $studyFromTitle            |
        $studyFromTopicalCoverage  |
        $studyFromSpatialCoverage  |
        $studyFromAbstractPurpose  |
        $studyFromCreator          |
        $studyFromKindOfData       |
        $studyFromTemporalCoverage
    (: Use intersection to only get the list of StudyUnits that satisfy all the set criteria. :)
    (: We use if-then-else to handle cases when one or more of the lists are empty (meaning that the entire intersection would be empty). :)
    return
        (if ($studyFromId) then $studyFromId else $studyUnitUnion)                            intersect
        (if ($studyFromTitle) then $studyFromTitle else $studyUnitUnion)                      intersect
        (if ($studyFromTopicalCoverage) then $studyFromTopicalCoverage else $studyUnitUnion)  intersect
        (if ($studyFromSpatialCoverage) then $studyFromSpatialCoverage else $studyUnitUnion)  intersect
        (if ($studyFromAbstractPurpose) then $studyFromAbstractPurpose else $studyUnitUnion)  intersect
        (if ($studyFromCreator) then $studyFromCreator else $studyUnitUnion)                  intersect
        (if ($studyFromKindOfData) then $studyFromKindOfData else $studyUnitUnion)            intersect
        (if ($studyFromTemporalCoverage) then $studyFromTemporalCoverage else $studyUnitUnion)
};

declare function local:conditionalIntersection($set1 as element()*, $required1 as xs:boolean,
                                               $set2 as element()*, $required2 as xs:boolean,
                                               $set3 as element()*, $required3 as xs:boolean,
                                               $set4 as element()*, $required4 as xs:boolean,
                                               $set5 as element()*, $required5 as xs:boolean,
                                               $set6 as element()*, $required6 as xs:boolean,
                                               $set7 as element()*, $required7 as xs:boolean) as node()* {
    let $union := $set1 | $set2 | $set3 | $set4 | $set5 | $set6 | $set7
    return
        (if ($required1) then $set1 else $union) intersect
        (if ($required2) then $set2 else $union) intersect
        (if ($required3) then $set3 else $union) intersect
        (if ($required4) then $set4 else $union) intersect
        (if ($required5) then $set5 else $union) intersect
        (if ($required6) then $set6 else $union) intersect
        (if ($required7) then $set7 else $union)
};