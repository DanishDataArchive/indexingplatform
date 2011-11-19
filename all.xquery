xquery version "1.0";

import module namespace result = "http://dda.dk/ddi/result" at "file:///C:/Users/kp/Dropbox/DDA/DDA-IPF/resultFunctions.xquery";(:"xmldb:exist:///db/dda/resultFunctions.xquery":)
(:import module namespace kwic="http://exist-db.org/xquery/kwic";:)

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

declare namespace ddi="http://dda.dk/ddi";





(:~
 : Makes a free-text search in StudyUnit elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryStudyUnit($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/@id[ft:query(., $search-string)]                   |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Creator[ft:query(., $search-string)]  |
    /i:DDIInstance/su:StudyUnit/r:Citation/r:Title[ft:query(., $search-string)]    |
    /i:DDIInstance/su:StudyUnit/su:Abstract/r:Content[ft:query(., $search-string)] |
    /i:DDIInstance/su:StudyUnit/su:Purpose/r:Content[ft:query(., $search-string)]  |
    /i:DDIInstance/su:StudyUnit/su:KindOfData[ft:query(., $search-string)]
};

(:~
 : Makes a free-text search in Concept elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryConcept($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:ConceptScheme/cc:Concept[ft:query(r:Description, $search-string)]
};

(:~
 : Makes a free-text search in Universe elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryUniverse($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(r:Label, $search-string)] |
    /i:DDIInstance/su:StudyUnit/cc:ConceptualComponent/cc:UniverseScheme/cc:Universe[ft:query(cc:HumanReadable, $search-string)]
};

(:~
 : Makes a free-text search in QuestionItem elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryQuestion($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionItemName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/dc:DataCollection/dc:QuestionScheme/dc:QuestionItem[ft:query(dc:QuestionText/dc:LiteralText/dc:Text, $search-string)]
};

(:~
 : Makes a free-text search in Variable elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryVariable($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(lp:VariableName, $search-string)] |
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:VariableScheme/lp:Variable[ft:query(r:Label, $search-string)]
};

(:~
 : Makes a free-text search in Category elements and returns the element(s) containing the match
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 :)
declare function local:queryCategory($search-string as xs:string) as element()* {
    /i:DDIInstance/su:StudyUnit/lp:LogicalProduct/lp:CategoryScheme/lp:Category[ft:query(r:Label, $search-string)]
};

(:~
 : Makes a free-text search in all indexed elements and returns  a list of LightXmlObject elements with results
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $search-string the string that needs to be matched
 : @param   $hits-perpage the number of hits to be shown per page
 : @param   $hit-start number of the first hit to be shown on the page
 :)
declare function ddi:searchAll($search-string as xs:string, $hits-perpage as xs:integer, $hit-start as xs:integer) as element() {
    let $results := 
        local:queryStudyUnit($search-string) |
        local:queryConcept($search-string)   |
        local:queryUniverse($search-string)  |
        local:queryQuestion($search-string)  |
        local:queryVariable($search-string)  |
        local:queryCategory($search-string)

    let $result-count := count($results)
    let $hit-end := if ($result-count lt $hits-perpage) then $result-count
                    else $hit-start + $hits-perpage
    let $number-of-pages :=  xs:integer(ceiling($result-count div $hits-perpage))
    let $current-page := xs:integer(($hit-start + $hits-perpage) div $hits-perpage)

    return <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:dda="http://dda.dk"
        dda:result-count="{$result-count}"
        dda:hit-start="{$hit-start}"
        dda:hit-end="{$hit-end}"
        dda:hits-perpage="{$hits-perpage}"
        dda:number-of-pages="{$number-of-pages}"
        dda:current-page="{$current-page}">
    {
        for $result in $results[position() = $hit-start to $hit-end]
        order by ft:score($result) descending
            return result:buildResultListItem($result)
        (:<result score="{ft:score($result)}">{$result}</result>:)
        (:kwic:summarize($result, <config width="40"/>):)
    }
    </dl:LightXmlObjectList>
};




ddi:searchAll('Kemal', 10, 0)(:'14069':)
(:ddi:getQuestionReferences('quei-40b54010-32c6-4b7c-9f1e-6b8f662462c1'):)