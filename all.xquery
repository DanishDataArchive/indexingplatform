xquery version "1.0";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

let $search-string := 'Mand'(:'14069':)
for $result in
    //su:StudyUnit//@id[ft:query(., $search-string)] |
    //r:Citation/r:Creator[ft:query(., $search-string)] |
    //r:Citation/r:Title[ft:query(., $search-string)] |
    //su:Abstract/r:Content[ft:query(., $search-string)] |
    //su:Purpose/r:Content[ft:query(., $search-string)] |
    //su:StudyUnit/su:KindOfData[ft:query(., $search-string)] |
    //cc:Concept/r:Label[ft:query(., $search-string)] |
    //cc:Concept/r:Description[ft:query(., $search-string)] |
    //r:UniverseReference/r:ID[ft:query(., $search-string)] |
    //cc:Universe/r:Label[ft:query(., $search-string)] |
    //cc:Universe/cc:HumanReadable[ft:query(., $search-string)] |
    //dc:QuestionItemName[ft:query(., $search-string)] |
    //dc:QuestionText/dc:LiteralText/dc:Text[ft:query(., $search-string)] |
    //lp:VariableName[ft:query(., $search-string)] |
    //lp:Variable/r:Label[ft:query(., $search-string)] |
    //lp:Category/r:Label[ft:query(., $search-string)]
order by ft:score($result) descending

return (:name($result ):)
<result score="{ft:score($result)}">{$result}</result>
(:return $result/ancestor-or-self::su:StudyUnit:)