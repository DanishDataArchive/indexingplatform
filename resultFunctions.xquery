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
        return <Custom option="label" value="{data($node/@xml:lang)}">{data($node)}</Custom>
};

(:~
 : Returns a single LightXmlObject element containing a single result 
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $result one element in the result list obtained by the query
 :)
declare function result:buildResultListItem($result as element()) as element() {
    let $study-unit := $result/ancestor-or-self::su:StudyUnit
    let $title := $study-unit/r:Citation/r:Title
    let $result-name := local-name($result)
    let $result-name := if ($result-name eq 'Content') then
                                            local-name($result/..)
                                        else $result-name
    let $label := result:getLabel($result)
    
      return <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        {$label}
        <CustomList type="StudyUnit">
            <Custom option="id">{data($study-unit/@id)}</Custom>
            <Custom option="version">{data($study-unit/@version)}</Custom>
            {result:createCustomLabel($title)}
            <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
            <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
        </CustomList>
    </LightXmlObject>
};

(:~
 : Finds all relevant references for a given question (Concept, CodeScheme, Variable, Universe, Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $question-id ID of the question to look-up
 :)
declare function result:getQuestionReferences($question-id as xs:string) as element() {
    let $question := /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(@id, $question-id)]
    let $conceptReferenceIDs := $question/dc:ConceptReference/r:ID
    return <LightXmlObject element="{local-name($question)}" id="{data($question/@id)}" version="{data($question/@version)}"
        parentId="{data($question/../@id)}" parentVersion="{data($question/../@version)}">
        {result:getLabel($question)}
        (:<CustomList type="study">
            <Custom option="id">{data($study-unit/@id)}</Custom>
            <Custom option="version">{data($study-unit/@version)}</Custom>
            {result:createCustomLabel($title)}
            <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
            <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
        </CustomList>:)
    </LightXmlObject>
};
