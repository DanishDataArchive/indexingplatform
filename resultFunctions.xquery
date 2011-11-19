module namespace result = "http://dda.dk/ddi/result";

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
declare function result:getLabel($node as element()) as element()* {
    let $node-name := local-name($node)
    return if ($node-name eq 'Concept' or $node-name eq 'Universe' or $node-name eq 'Variable' or $node-name eq 'Category') then
        result:createLabel($node/r:Label)
    else if ($node-name eq 'QuestionItem') then
        result:createLabel($node/dc:QuestionText/dc:LiteralText/dc:Text)
    else
        result:createLabel($node)
};

(:~
 : Returns a Label element(s)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $nodes the element(s) containing the value for the Label
 :)
declare function result:createLabel($nodes as element()*) as element()* {
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
declare function result:createCustomLabel($nodes as element()*) as element()* {
    for $node in $nodes
        return if (data($node/@xml:lang)) then <Custom option="label" value="{data($node/@xml:lang)}">{data($node)}</Custom>
                                          else <Custom option="label">{data($node)}</Custom>
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
    let $label := result:getLabel($result)
    let $referenceList := if ($result-name eq 'QuestionItem') then
            result:getQuestionReferences($result)
        else "NOT QuestionItem"
    
    return <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        {$label}
        {result:getStudyUnit($result)}
        {$referenceList}
    </LightXmlObject>
};

(:~
 : Returns a Custom element containing the info about the StudyUnit 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $result one element in the result list obtained by the query
 :)
declare function result:getStudyUnit($result as element()) as element() {
    let $study-unit := $result/ancestor-or-self::su:StudyUnit    
    return <CustomList type="StudyUnit">
        <Custom option="id">{data($study-unit/@id)}</Custom>
        <Custom option="version">{data($study-unit/@version)}</Custom>
        {result:createCustomLabel($study-unit/r:Citation/r:Title)}
        <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
        <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
    </CustomList>
};

(:~
 : Finds all relevant references for a given question (Concept, CodeScheme, Variable, Universe, Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $question question to process
 :)
declare function result:getQuestionReferences($question as element()) as element()* {
    (:Concept:)
    for $conceptId in $question/dc:ConceptReference/r:ID
        let $conceptIdString := string($conceptId)
        let $concept := /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(@id, $conceptIdString)]
        return <CustomList type="Concept">
            <Custom option="id">{$conceptIdString}</Custom>
            {result:createCustomLabel($concept/r:Label)}
        </CustomList>,
    (:CodeScheme:)
    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
        let $codeSchemeIdString := string($codeSchemeId)
        let $codeScheme := /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
        return <CustomList type="CodeScheme">
            <Custom option="id">{$codeSchemeIdString}</Custom>
            {result:createCustomLabel($codeScheme/r:Label)}
        </CustomList>,
    (:Variable:)
    for $variable in /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
        return <CustomList type="Variable">
            <Custom option="id">{data($variable/@id)}</Custom>
            {result:createCustomLabel($variable/r:Label)}
        </CustomList>
};
