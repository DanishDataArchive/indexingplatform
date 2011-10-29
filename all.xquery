xquery version "1.0";
declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

(:declare namespace dl = "ddieditor-lightobject";:)

let $search-string := 'National'(:'14069':)
for $result in
    /i:DDIInstance/su:StudyUnit/@id[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Creator[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Title[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Abstract/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Purpose/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:KindOfData[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept/r:Description[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/r:UniverseReference/r:ID[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe/cc:HumanReadable[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem/dc:QuestionItemName[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem/dc:QuestionText/dc:LiteralText/dc:Text[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:VariableName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CategoryScheme/lp:Category[ft:query(r:Label, $search-string)]
    
    let $study-unit := $result/ancestor-or-self::su:StudyUnit
order by ft:score($result) descending

(:return $result:)

(:name($result ):)
(:<result score="{ft:score($result)}">{$result}</result>:)


return
    <LightXmlObject element="{node-name($result)}" id="conc-695fdb22-4bf1-4359-9647-4a1c421593d1" version="1.0.0"
        parentId="cons-e875ed1c-6773-4ca5-ae0c-9ad5d4a3ae38" parentVersion="1.0.0">
        <Label lang="da">Baggrundsvariabler</Label>
        <CustomList type="study">
            <Custom option="id">{data($study-unit/@id)}</Custom>
            <Custom option="version">{data($study-unit/@version)}</Custom>
            <Custom option="label" value="da">{data($study-unit/r:Citation/r:Title)}</Custom>
            <Custom option="start">2000-05-01T00:00:00.000+01:00</Custom>
            <Custom option="end">2001-07-01T00:00:00.000+01:00</Custom>
        </CustomList>
    </LightXmlObject>