xquery version "1.0";
declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

(:declare namespace dl = "ddieditor-lightobject";:)

let $search-string := '"er du dansk"'(:'14069':)
for $result in
    /i:DDIInstance/su:StudyUnit/@id[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Creator[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Title[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Abstract/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Purpose/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:KindOfData[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Description, $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:UniverseReference/r:ID[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(cc:HumanReadable, $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionItemName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionText/dc:LiteralText/dc:Text, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:VariableName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CategoryScheme/lp:Category[ft:query(r:Label, $search-string)]
    
    let $study-unit := $result/ancestor-or-self::su:StudyUnit
order by ft:score($result) descending

(:return $result:)

(:name($result ):)
(:<result score="{ft:score($result)}">{$result}</result>:)


return
    <LightXmlObject element="{local-name($result)}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        <Label lang="da">Baggrundsvariabler</Label>
        <CustomList type="study">
            <Custom option="id">{data($study-unit/@id)}</Custom>
            <Custom option="version">{data($study-unit/@version)}</Custom>
            <Custom option="label" value="da">{data($study-unit/r:Citation/r:Title)}</Custom>
            <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
            <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
        </CustomList>
    </LightXmlObject>