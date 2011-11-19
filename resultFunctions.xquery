module namespace result = "http://dda.dk/ddi/result";

declare namespace resultHelper = "http://dda.dk/ddi/resultHelper";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

(:~
 : Finds the element containing the human readable text and returns its value in a Label element(s)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $node the nodes which contains the human readable text in its descendants
 :)
declare function resultHelper:getLabel($node as element()) as element()* {
    let $node-name := local-name($node)
    return if ($node-name eq 'Concept' or $node-name eq 'Universe' or $node-name eq 'Variable' or $node-name eq 'Category') then
        resultHelper:createLabel($node/r:Label)
    else if ($node-name eq 'QuestionItem') then
        resultHelper:createLabel($node/dc:QuestionText/dc:LiteralText/dc:Text)
    else
        resultHelper:createLabel($node)
};

(:~
 : Returns a Label element(s)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $nodes the element(s) containing the value for the Label
 :)
declare function resultHelper:createLabel($nodes as element()*) as element()* {
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
declare function resultHelper:createCustomLabel($nodes as element()*) as element()* {
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
declare function resultHelper:getStudyUnit($result as element()) as element() {
    let $study-unit := $result/ancestor-or-self::su:StudyUnit    
    return <CustomList type="StudyUnit">
        <Custom option="id">{data($study-unit/@id)}</Custom>
        <Custom option="version">{data($study-unit/@version)}</Custom>
        {resultHelper:createCustomLabel($study-unit/r:Citation/r:Title)}
        <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
        <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the Concept
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $conceptId the ID of the Concept
 :)
declare function resultHelper:getCreateConcept($conceptId as xs:string) as element() {
    let $concept := /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(@id, $conceptId)]
    return <CustomList type="Concept">
        <Custom option="id">{$conceptId}</Custom>
        {resultHelper:createCustomLabel($concept/r:Label)}
    </CustomList>
};

(:~
 : Returns a single LightXmlObject element containing a single result 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $result one element in the result list obtained by the query
 :)
declare function result:buildResultListItem($result as element()) as element() {
    let $result-name := local-name($result)
    let $result-name := if ($result-name eq 'Content') then
                                            local-name($result/..)
                                        else $result-name
    let $label := resultHelper:getLabel($result)
    let $referenceList :=
        if ($result-name eq 'QuestionItem') then
            result:getQuestionReferences($result)
        else if ($result-name eq 'Variable') then
            result:getVariableReferences($result)
        else "NOT IMPLEMENTED"
    
    return <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        {$label}
        {resultHelper:getStudyUnit($result)}
        {$referenceList}
    </LightXmlObject>
};

(:~
 : Finds all relevant references for a given QuestionItem (Concept, CodeScheme, Variable, Universe, Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $question question to process
 :)
declare function result:getQuestionReferences($question as element()) as element()* {
    (:Concept:)
    for $conceptId in $question/dc:ConceptReference/r:ID
        return resultHelper:getCreateConcept(string($conceptId)),
    (:CodeScheme:)
    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
        let $codeSchemeIdString := string($codeSchemeId)
        let $codeScheme := /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
        return <CustomList type="CodeScheme">
            <Custom option="id">{$codeSchemeIdString}</Custom>
            {resultHelper:createCustomLabel($codeScheme/r:Label)}
        </CustomList>,
    (:Variable:)
    for $variable in /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
        return <CustomList type="Variable">
            <Custom option="id">{data($variable/@id)}</Custom>
            {resultHelper:createCustomLabel($variable/r:Label)}
        </CustomList>,
    (:Universe:)
    for $variable in /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
        for $universeId in $variable/r:UniverseReference/r:ID
            let $universeIdString := string($universeId)
            let $universe := /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(@id, $universeIdString)]
            return <CustomList type="Universe">
                <Custom option="id">{$universeIdString}</Custom>
                {resultHelper:createCustomLabel($universe/r:Label)}
            </CustomList>,
    (:Category:)
    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
        let $codeSchemeIdString := string($codeSchemeId)
        let $codeScheme := /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
            let $categoryIdString := string($categoryId)
            let $category := /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CategoryScheme/lp:Category[ft:query(@id, $categoryIdString)]
            return <CustomList type="Category">
                <Custom option="id">{$categoryIdString}</Custom>
                {resultHelper:createCustomLabel($category/r:Label)}
            </CustomList>
};

(:~
 : Finds all relevant references for a given Variable (Concept, Universe, Question, Code/Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $variable variable to process
 :)
declare function result:getVariableReferences($variable as element()) as element()* {
    (:Concept:)
    for $conceptId in $variable/lp:ConceptReference/r:ID
        return resultHelper:getCreateConcept(string($conceptId))
};
