xquery version "1.0";

(:~
 : This module contains the functions used to process results and is used by the search module.
 : The entry function for this module is <b>result:buildResultListItem</b>.<br />
 : Additionally, it is possible to find references for a specific DDI element using the <b>result:getReferences</b> function.
 : This function is used by <b>result:buildResultListItem</b> and it is not necessary to call it manually.<br />
 : The rest of the functions are local and cannot be used externally.
 :)
module namespace result = "http://dda.dk/ddi/result";

import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";
declare namespace s="http://dda.dk/ddi/scope";
declare namespace d="http://dda.dk/ddi/denormalized-ddi";

(:~
 : Finds the element containing the human readable text and returns its value in a Label element(s)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $node the nodes which contains the human readable text in its descendants
 :)
declare function local:getLabel($node as element()) as element()* {
    let $node-name := local-name($node)
    return if ($node-name eq 'Concept' or $node-name eq 'Universe' or $node-name eq 'Variable' or $node-name eq 'Category') then
        local:createLabel($node/r:Label)
    else if ($node-name eq 'QuestionItem' or $node-name eq 'MultipleQuestionItem') then
        local:createLabel($node/dc:QuestionText/dc:LiteralText/dc:Text)
    else if ($node-name eq 'StudyUnit') then
        local:createLabel($node/r:Citation/r:Title)
    else
        local:createLabel($node)
};

(:~
 : Returns a Label element(s)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $nodes the element(s) containing the value for the Label
 :)
declare function local:createLabel($nodes as element()*) as element()* {
    for $node in $nodes
        return <Label lang="{data($node/@xml:lang)}">{data($node)}</Label>
};

(:~
 : Returns a Custom element(s) 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $nodes the element(s) containing the value for the Custom element
 :)
declare function local:createCustomLabel($nodes as element()*) as element()* {
    for $node in $nodes
        return if (data($node/@xml:lang)) then <Custom option="label" value="{data($node/@xml:lang)}">{data($node)}</Custom>
                                          else <Custom option="label">{data($node)}</Custom>
};

(:~
 : Returns a Custom element containing the info about the StudyUnit 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $result one element in the result list obtained by the query
 :)
declare function local:createStudyUnitCustom($result as element()) as element() {
    let $study-unit := $result/ancestor-or-self::su:StudyUnit    
    return <CustomList type="StudyUnit">
        <Custom option="id">{data($study-unit/@id)}</Custom>
        <Custom option="version">{data($study-unit/@version)}</Custom>
        {local:createCustomLabel($study-unit/r:Citation/r:Title)}
        <Custom option="start">{data($study-unit/r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:StartDate)}</Custom>
        <Custom option="end">{data($study-unit/r:Coverage/r:TemporalCoverage/r:ReferenceDate/r:EndDate)}</Custom>
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the Concept
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $conceptId the ID of the Concept
 :)
declare function local:createConceptCustomFromId($conceptId as xs:string) as element() {
    let $concept := collection('/db/dda')//cc:Concept[ft:query(@id, $conceptId)]
    return <CustomList type="Concept">
        <Custom option="id">{$conceptId}</Custom>
        {local:createCustomLabel($concept/r:Label)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the Universe
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $universeId the ID of the Universe
 :)
declare function local:createUniverseCustomFromId($universeId as xs:string) as element() {
    let $universe := collection('/db/dda')//cc:Universe[ft:query(@id, $universeId)]
    return <CustomList type="Universe">
        <Custom option="id">{$universeId}</Custom>
        {local:createCustomLabel($universe/r:Label)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the QuestionItem
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $questionItemId the ID of the QuestionItem
 :)
declare function local:createQuestionItemCustomFromId($questionItemId as xs:string) as element() {
    let $questionItem := collection('/db/dda')//dc:QuestionItem[ft:query(@id, $questionItemId)]
    return <CustomList type="QuestionItem">
        <Custom option="id">{data($questionItem/@id)}</Custom>
        {local:createCustomLabel($questionItem/dc:QuestionText/dc:LiteralText/dc:Text)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the MultipleQuestionItem
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $multipleQuestionItemId the ID of the MultipleQuestionItem
 :)
declare function local:createMultipleQuestionItemCustomFromId($multipleQuestionItemId as xs:string) as element() {
    let $multipleQuestionItem := collection('/db/dda')//dc:MultipleQuestionItem[ft:query(@id, $multipleQuestionItemId)]
    return <CustomList type="MultipleQuestionItem">
        <Custom option="id">{data($multipleQuestionItem/@id)}</Custom>
        {local:createCustomLabel($multipleQuestionItem/dc:QuestionText/dc:LiteralText/dc:Text)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the Variable
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $variableId the ID of the Variable
 :)
declare function local:createVariableCustomFromId($variableId as xs:string) as element() {
    let $variable := collection('/db/dda')//lp:Variable[ft:query(@id, $variableId)]
    return <CustomList type="Variable">
        <Custom option="id">{data($variable/@id)}</Custom>
        {local:createCustomLabel($variable/r:Label)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the Category
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $categoryId the ID of the Category
 :)
declare function local:createCategoryCustomFromId($categoryId as xs:string) as element() {
    let $category := collection('/db/dda')//lp:Category[ft:query(@id, $categoryId)]
    return <CustomList type="Category">
        <Custom option="id">{data($category/@id)}</Custom>
        {local:createCustomLabel($category/r:Label)}
    </CustomList>
};

(:~
 : Returns a single LightXmlObject element containing a single result 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $result one element in the result list obtained by the query
 :)
declare function result:buildResultListItem($result as element(), $scope as element()) as element() {
    let $result-name := local-name($result)
    let $label := local:getLabel($result)
    return <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        <Context>
        {(: Find and return the contexts where the matches were found with the matches highlighted. :)
            (:let $matches := util:expand($result)//exist:match
            for $ancestor in $matches/ancestor::*[1]
                for $match in $ancestor//exist:match
                    return kwic:get-summary($ancestor, $match, <config width="100"/>, ()):)
             let $matches := util:expand($result)//exist:match
             return $matches/ancestor::*[1]
        }
        </Context>
        {$label}
        {local:createStudyUnitCustom($result)}
        {result:getReferences($result, $scope)}
    </LightXmlObject>
};

(:~
 : Returns a list of references for s specific element, i.e. the elements either referred by or referring to that element.
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $resultElement a DDI element
 : @param   $scope the list of reference types we wish to return with the following format:<br/>
 :<pre>
 :    &lt;s:Scope&gt;
 :        &lt;s:StudyUnit/&gt;<br/>
 :        &lt;s:Variable/&gt;<br/>
 :        &lt;s:QuestionItem/&gt;<br/>
 :        &lt;s:MultipleQuestionItem/&gt;<br/>
 :        &lt;s:Universe/&gt;<br/>
 :        &lt;s:Concept/&gt;<br/>
 :        &lt;s:Category/&gt;<br/>
 :    &lt;/s:Scope&gt;<br/>
 :</pre>
 : Each child-element is optional and if it is present the search will for all found results return a list of references of the type specified by that element (if any exist).
 : The child-elements have no type or content; only the existence is checked.<br/>
 : If the scope is not specified the default list is used, which is:
 :<pre>
 :  For Variable:              &lt;s:Scope&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;s:RepresentationType/&gt;&lt;/s:Scope&gt;<br />
 :  For QuestionItem:          &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;s:DomainType/&gt;&lt;/s:Scope&gt;<br />
 :  For MultipleQuestionItem:  &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:Universe/&gt;&lt;s:Concept/&gt;&lt;s:Category/&gt;&lt;/s:Scope&gt;<br />
 :  For Universe:              &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;/s:Scope&gt;<br />
 :  For Concept:               &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;/s:Scope&gt;<br />
 :  For Category:              &lt;s:Scope&gt;&lt;s:Variable/&gt;&lt;s:QuestionItem/&gt;&lt;s:MultipleQuestionItem/&gt;&lt;/s:Scope&gt;<br />
 :</pre>
 :)
declare function result:getReferences($resultElement as element(), $scope as element()) as element()* {
    let $resultElementId := string($resultElement/@id)
    let $resultElementName := local-name($resultElement)
    (: Get a denormalized list of all elements referred by or referring to this element :)
    let $referenceList :=
             if ($resultElementName eq 'StudyUnit') then collection('/db/dda-denormalization')//d:StudyUnit[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'Variable') then collection('/db/dda-denormalization')//d:Variable[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'QuestionItem') then collection('/db/dda-denormalization')//d:QuestionItem[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'MultipleQuestionItem') then collection('/db/dda-denormalization')//d:MultipleQuestionItem[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'Universe') then collection('/db/dda-denormalization')//d:Universe[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'Concept') then collection('/db/dda-denormalization')//d:Concept[ft:query(@id, $resultElementId)]
        else if ($resultElementName eq 'Category') then collection('/db/dda-denormalization')//d:Category[ft:query(@id, $resultElementId)]
        else ()

    (: If the scope (list of types of referring elements) is set then use it. Otherwise fall back to a default list, specific for each element type. :)
    let $referenceScope :=
        if ($scope) then $scope
        else
                 if ($resultElementName eq 'Variable') then <s:Scope><s:QuestionItem/><s:MultipleQuestionItem/><s:Universe/><s:Concept/><s:Category/><s:RepresentationType/></s:Scope>
            else if ($resultElementName eq 'QuestionItem') then <s:Scope><s:Variable/><s:Universe/><s:Concept/><s:Category/><s:DomainType/></s:Scope>
            else if ($resultElementName eq 'MultipleQuestionItem') then <s:Scope><s:Variable/><s:Universe/><s:Concept/><s:Category/></s:Scope>
            else if ($resultElementName eq 'Universe') then <s:Scope><s:Variable/></s:Scope>
            else if ($resultElementName eq 'Concept') then <s:Scope><s:Variable/><s:QuestionItem/><s:MultipleQuestionItem/></s:Scope>
            else if ($resultElementName eq 'Category') then <s:Scope><s:Variable/><s:QuestionItem/><s:MultipleQuestionItem/></s:Scope>
            else ()

    (: For each reference type check if we wish to show it (if it is in scope) and if so create it as a Custom element. :)
    (: RepresentationType is not really a reference, but we wish to show it for variables. :)
    let $representationType :=
        if ($referenceScope/s:RepresentationType) then
                 if ($resultElement/lp:Representation/lp:TextRepresentation) then <CustomList type="RepresentationType"><Custom option="type">TextRepresentation</Custom></CustomList>
            else if ($resultElement/lp:Representation/lp:NumericRepresentation) then <CustomList type="RepresentationType"><Custom option="type" value="{data($resultElement/lp:Representation/lp:NumericRepresentation/@type)}">NumericRepresentation</Custom></CustomList>
            else if ($resultElement/lp:Representation/lp:CodeRepresentation) then <CustomList type="RepresentationType"><Custom option="type">CodeRepresentation</Custom></CustomList>
            else ()
        else ()
    (: DomainType is not really a reference, but we wish to show it for questions. :)
    let $domainType :=
        if ($referenceScope/s:DomainType) then
                 if ($resultElement/dc:TextDomain) then <CustomList type="DomainType"><Custom option="type">TextDomain</Custom></CustomList>
            else if ($resultElement/dc:NumericDomain) then <CustomList type="DomainType"><Custom option="type" value="{data($resultElement/dc:NumericDomain/@type)}">NumericDomain</Custom></CustomList>
            else if ($resultElement/dc:CodeDomain) then <CustomList type="DomainType"><Custom option="type">CodeDomain</Custom></CustomList>
            else ()
        else ()
    let $variables :=
        if ($referenceScope/s:Variable) then
            for $variableReference in $referenceList/d:VariableReference
                return local:createVariableCustomFromId($variableReference/@id)
        else ()
    let $questionItems :=
        if ($referenceScope/s:QuestionItem) then
            for $questionItemReference in $referenceList/d:QuestionItemReference
                return local:createQuestionItemCustomFromId($questionItemReference/@id)
        else ()
    let $multipleQuestionItems :=
        if ($referenceScope/s:MultipleQuestionItem) then
            for $multipleQuestionItemReference in $referenceList/d:MultipleQuestionItemReference
            return local:createMultipleQuestionItemCustomFromId($multipleQuestionItemReference/@id)
        else ()
    let $universes :=
        if ($referenceScope/s:Universe) then
            for $universeReference in $referenceList/d:UniverseReference
            return local:createUniverseCustomFromId($universeReference/@id)
        else ()
    let $concepts :=
        if ($referenceScope/s:Concept) then
            for $conceptReference in $referenceList/d:ConceptReference
            return local:createConceptCustomFromId($conceptReference/@id)
        else ()
    let $categories :=
        if ($referenceScope/s:Category) then
            for $categoryReference in $referenceList/d:CategoryReference
            return local:createCategoryCustomFromId($categoryReference/@id)
        else ()
    
    return $representationType | $domainType | $variables | $questionItems | $multipleQuestionItems | $universes | $concepts | $categories
};