xquery version "3.0";

import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/apps/dda-urn/lib/urn.xquery";

declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace lp="ddi:logicalproduct:3_1";
declare namespace ddapre32="dda:ramp_up_to_ddi_3_2";

declare option exist:serialize "method=html media-type=text/xml omit-xml-declaration=no indent=yes";

declare function local:main() as item()* {
    let $urn := request:get-parameter("urn", ())
    let $ddi := urn:resolveUrn($urn)
    let $ddiElementName := $ddi/name()
    let $elementFragment := <ddapre32:Fragment>{$ddi}</ddapre32:Fragment>
    
    let $fragmentResult := 
    if($ddiElementName = 'Variable') then 
        local:fragmentizeVariable($ddi)
    else if($ddiElementName = 'QuestionItem') then 
        local:fragmentizeQuestionItem($ddi)
    else ()
    
    let $tmpResult := (local:getTopLevelReference($ddiElementName, string($urn)), $elementFragment, $fragmentResult)
    return <ddapre32:FragmentInstance>{$tmpResult}</ddapre32:FragmentInstance>
};

declare function local:fragmentizeVariable($ddi as node()) as item()* {
    let $questions :=  
    for $questionRef in $ddi/lp:QuestionReference
        return local:resolveRef($questionRef)
        
    let $concepts := 
    for $conceptRef in $ddi/lp:ConceptReference
        return local:resolveRef($conceptRef)
        
    let $universes := 
    for $universeRef in $ddi/r:UniverseReference
        return local:resolveRef($universeRef)
        
    let $codeScheme := 
    for $codeSchemeRef in $ddi//r:CodeSchemeReference
        return local:resolveRef($codeSchemeRef)
        
    let $catScheme :=     
    for $catSchemeRef in $codeScheme//lp:CategorySchemeReference
        return local:resolveRef($catSchemeRef)
        
    let $result := ($questions, $concepts, $universes, $codeScheme, $catScheme)
    return $result
};

declare function local:fragmentizeQuestionItem($ddi as node()) as item()* {
    let $variables := local:getVariableFromQuestionRef($ddi/@id/string())
        
    let $concepts := 
    for $conceptRef in $ddi/dc:ConceptReference
        return local:resolveRef($conceptRef)
        
    let $codeScheme := 
    for $codeSchemeRef in $ddi/dc:CodeDomain/r:CodeSchemeReference
        return local:resolveRef($codeSchemeRef)
        
    let $catScheme :=     
    for $catSchemeRef in $codeScheme//lp:CategorySchemeReference
        return local:resolveRef($catSchemeRef)
        
    let $result := ($concepts, $catScheme, $codeScheme, $variables)
    return $result
};

declare function local:getVariableFromQuestionRef($id as xs:string) as item()? {
    let $queryResult := collection('/db/apps/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $id)]
    let $result := if(empty($queryResult)) then
        ()
        else <ddapre32:Fragment>{$queryResult[1]}</ddapre32:Fragment>
    return $result
};

declare function local:getVariableStudyUnitRef($id as xs:string) as item()? {
    let $queryResult := collection('/db/apps/dda')//lp:Variable[ft:query(@id, $id)]/../../..
    let $result := if(empty($queryResult)) then
        ()
        else 
        <ddapre32:StudyUnitRefrence versionDate="{$queryResult/@versionDate}" analysisUnit="{$queryResult/r:AnalysisUnit}">
           <r:Agency>{$queryResult/@agency/string()}</r:Agency>
           <r:ID>{$queryResult/@id/string()}</r:ID>
           <r:Version>{$queryResult/@version/string()}</r:Version>
        </ddapre32:StudyUnitRefrence>
    return $result
};

declare function local:getQuestionItemStudyUnitRef($id as xs:string) as item()? {
    let $queryResult := collection('/db/apps/dda')//dc:QuestionItem[ft:query(@id, $id)]/../../..
    let $result := if(empty($queryResult)) then
        ()
        else 
        <ddapre32:StudyUnitRefrence versionDate="{$queryResult/@versionDate}" analysisUnit="{$queryResult/r:AnalysisUnit}">
           <r:Agency>{$queryResult/@agency/string()}</r:Agency>
           <r:ID>{$queryResult/@id/string()}</r:ID>
           <r:Version>{$queryResult/@version/string()}</r:Version>
        </ddapre32:StudyUnitRefrence>
    return $result
};

declare function local:resolveRef($ref as node()) as item()* {
    let $urn := fn:concat('urn:ddi:', string($ref/r:IdentifyingAgency), ':', string($ref/r:ID), ':', string($ref/r:Version))
    return <ddapre32:Fragment>{urn:resolveUrn($urn)}</ddapre32:Fragment>
};

declare function local:getTopLevelReference($elementName as xs:string, $urn as xs:string) as element()* {
    let $tokenizedUrn := tokenize($urn, ":")
    let $studyUnitRef := (local:getVariableStudyUnitRef($tokenizedUrn[4]),local:getQuestionItemStudyUnitRef($tokenizedUrn[4]))
    let $result := 
    <ddapre32:TopLevelReference>
       <ddapre32:TypeOfObject>{$elementName}</ddapre32:TypeOfObject>
       <r:Agency>{$tokenizedUrn[3]}</r:Agency>
       <r:ID>{$tokenizedUrn[4]}</r:ID>
       <r:Version>{$tokenizedUrn[5]}</r:Version>
       <r:URN>{$urn}</r:URN>
    </ddapre32:TopLevelReference>
    
    return ($result, $studyUnitRef)
};

local:main()
