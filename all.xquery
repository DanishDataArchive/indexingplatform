xquery version "1.0";

import module namespace kwic="http://exist-db.org/xquery/kwic";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

(:declare namespace dl = "ddieditor-lightobject";:)

(:declare function local:getLabel($parent as element()) as xs:string? {
    typeswitch ($parent)
    case element(*,lp:Category) return xs:string($parent/r:Label)
        case element(*,dc:QuestionItem) return xs:string($parent/dc:QuestionText/dc:LiteralText/dc:Text)
        default return xs:string($parent/r:Label)
};:)
declare function local:getLabel($node as element()) as element()* {
    let $node-name := local-name($node)
    return if ($node-name eq 'Concept' or $node-name eq 'Universe' or $node-name eq 'Variable' or $node-name eq 'Category') then
        local:createLabel($node/r:Label)
    else if ($node-name eq 'QuestionItem') then
        local:createLabel($node/dc:QuestionText/dc:LiteralText/dc:Text)
    else
        local:createLabel($node)
};

declare function local:createLabel($nodes as element()*) as element()* {
    for $node in $nodes
        return <Label lang="{data($node/@xml:lang)}">{data($node)}</Label>
};

declare function local:createCustomLabel($nodes as element()*) as element()* {
    for $node in $nodes
        return <Custom option="label" value="{data($node/@xml:lang)}">{data($node)}</Custom>
};

(:declare function local:createElementWithLang($nodes as element()*, $elementName as xs:string) as element()* {
    for $node in $nodes
        return element {$elementName} {
            attribute lang {data($node/@xml:lang)},
            data($node)
        }
};:)

let $search-string := 'Nationali'(:'14069':)

(:return
<dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd">:)
    
for $result in
    /i:DDIInstance/su:StudyUnit/@id[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Creator[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Title[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Abstract/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Purpose/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:KindOfData[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Description, $search-string)] |
    (:/i:DDIInstance/su:StudyUnit/r:UniverseReference/r:ID[ft:query(., $search-string)] |:)
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(cc:HumanReadable, $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionItemName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionText/dc:LiteralText/dc:Text, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:VariableName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CategoryScheme/lp:Category[ft:query(r:Label, $search-string)]
    
    let $study-unit := $result/ancestor-or-self::su:StudyUnit
    let $title := $study-unit/r:Citation/r:Title
    let $result-name := local-name($result)
    let $result-name := if ($result-name eq 'Content') then
                                            local-name($result/..)
                                        else $result-name
    let $label := local:getLabel($result)

order by ft:score($result) descending

(:return $result:)

(:name($result ):)
(:<result score="{ft:score($result)}">{$result}</result>:)
(:kwic:summarize($result, <config width="40"/>):)

return
(:<dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd">:)
    <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        {$label}
        <CustomList type="study">
            <Custom option="id">{data($study-unit/@id)}</Custom>
            <Custom option="version">{data($study-unit/@version)}</Custom>
            {local:createCustomLabel($title)}
            <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
            <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
        </CustomList>
    </LightXmlObject>
(:</dl:LightXmlObjectList>:)