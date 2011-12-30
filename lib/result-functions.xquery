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
declare function local:getLabel($node as element()) as element()* {
    let $node-name := local-name($node)
    return if ($node-name eq 'Concept' or $node-name eq 'Universe' or $node-name eq 'Variable' or $node-name eq 'Category') then
        local:createLabel($node/r:Label)
    else if ($node-name eq 'QuestionItem' or $node-name eq 'MultipleQuestionItem') then
        local:createLabel($node/dc:QuestionText/dc:LiteralText/dc:Text)
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
 : @param   $question the QuestionItem
 :)
declare function local:createQuestionItemCustom($question as element()) as element() {
    let $dummy := ""
    return <CustomList type="QuestionItem">
        <Custom option="id">{data($question/@id)}</Custom>
        {local:createCustomLabel($question/dc:QuestionText/dc:LiteralText/dc:Text)}
    </CustomList>
};

(:~
 : Returns a Custom element containing the info about the QuestionItem
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $questionId the ID of the QuestionItem
 :)
declare function local:createQuestionItemCustomFromId($questionId as xs:string) as element() {
    let $question := collection('/db/dda')//dc:QuestionItem[ft:query(@id, $questionId)]
    return local:createQuestionItemCustom($question)
};

(:~
 : Returns a Custom element containing the info about the Variable
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $variable the Variable
 :)
declare function local:createVariableCustom($variable as element()) as element() {
    let $dummy := ""
    return <CustomList type="Variable">
        <Custom option="id">{data($variable/@id)}</Custom>
        {local:createCustomLabel($variable/r:Label)}
    </CustomList>
};

(:~
 : Returns a Custom element(s) containing the info about the Category
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $codeSchemeId the ID of the CodeScheme holding the references to the Categories
 :)
declare function local:createCategoryCustomFromCodeSchemeId($codeSchemeId as xs:string) as element()* {
    let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeId)]
    for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
        let $categoryIdString := string($categoryId)
        let $category := collection('/db/dda')//lp:Category[ft:query(@id, $categoryIdString)]
        return <CustomList type="Category">
            <Custom option="id">{$categoryIdString}</Custom>
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
declare function result:buildResultListItem($result as element()) as element() {
    let $result-name := local-name($result)
    let $result-name :=
        if ($result-name eq 'Content') then local-name($result/..)
        else $result-name
    let $label := local:getLabel($result)
    let $referenceList :=
        if ($result-name eq 'QuestionItem' or $result-name eq 'MultipleQuestionItem') then result:getQuestionReferences($result)
        else if ($result-name eq 'Variable') then result:getVariableReferences($result)
        else if ($result-name eq 'Concept') then result:getConceptReferences($result)
        else if ($result-name eq 'Universe') then result:getUniverseReferences($result)
        else if ($result-name eq 'Category') then result:getCategoryReferences($result)
        else <CustomList type="unknown references"/>
    
    return <LightXmlObject element="{$result-name}" id="{data($result/@id)}" version="{data($result/@version)}"
        parentId="{data($result/../@id)}" parentVersion="{data($result/../@version)}">
        {$label}
        {local:createStudyUnitCustom($result)}
        {$referenceList}
    </LightXmlObject>
};

(:~
 : Finds all relevant references for a given QuestionItem (Concept, CodeScheme, Variable, Universe, Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $question QuestionItem to process
 :)
declare function result:getQuestionReferences($question as element()) as element()* {
    (:Concept:)
    for $conceptId in $question/dc:ConceptReference/r:ID
        return local:createConceptCustomFromId(string($conceptId)),
    (:CodeScheme:)
    (:for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
        let $codeSchemeIdString := string($codeSchemeId)
        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
        return <CustomList type="CodeScheme">
            <Custom option="id">{$codeSchemeIdString}</Custom>
            {local:createCustomLabel($codeScheme/r:Label)}
        </CustomList>,:)
    (:Variable:)
    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
        return local:createVariableCustom($variable),
    (:Universe:)
    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
        for $universeId in $variable/r:UniverseReference/r:ID
            return local:createUniverseCustomFromId(string($universeId)),
    (:domain type:)
    let $domainType := if ($question/dc:TextDomain) then <Custom option="type">TextDomain</Custom>
                       else if ($question/dc:NumericDomain) then <Custom option="type" value="{data($question/dc:NumericDomain/@type)}">NumericDomain</Custom>
                       else if ($question/dc:CodeDomain) then <Custom option="type">CodeDomain</Custom>
                       else ""
        return <CustomList type="DomainType">
            {$domainType}
        </CustomList>,
    (:Category:)
    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
        return local:createCategoryCustomFromCodeSchemeId($codeSchemeId)
};

(:~
 : Finds all relevant references for a given Variable (Concept, Universe, Question, Code/Category)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $variable Variable to process
 :)
declare function result:getVariableReferences($variable as element()) as element()* {
    (:Concept:)
    for $conceptId in $variable/lp:ConceptReference/r:ID
        return local:createConceptCustomFromId(string($conceptId)),
    (:Universe:)
    for $universeId in $variable/r:UniverseReference/r:ID
        return local:createUniverseCustomFromId(string($universeId)),
    (:QuestionItem:)
    for $questionId in $variable/lp:QuestionReference/r:ID
        return local:createQuestionItemCustomFromId(string($questionId)),
    (:representation type:)
    let $representationType := if ($variable/lp:Representation/lp:TextRepresentation) then <Custom option="type">TextRepresentation</Custom>
                       else if ($variable/lp:Representation/lp:NumericRepresentation) then <Custom option="type" value="{data($variable/lp:Representation/lp:NumericRepresentation/@type)}">NumericRepresentation</Custom>
                       else if ($variable/lp:Representation/lp:CodeRepresentation) then <Custom option="type">CodeRepresentation</Custom>
                       else ""
        return <CustomList type="RepresentationType">
            {$representationType}
        </CustomList>,
    (:Category:)
    for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
        return local:createCategoryCustomFromCodeSchemeId($codeSchemeId)
};

(:~
 : Finds all relevant references for a given Concept (Question, Variable)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $concept Concept to process
 :)
declare function result:getConceptReferences($concept as element()) as element()* {
    (:QuestionItem:)
    for $question in collection('/db/dda')//dc:QuestionItem[ft:query(dc:ConceptReference/r:ID, $concept/@id)]
        return local:createQuestionItemCustom($question),
    (:Variable:)
    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:ConceptReference/r:ID, $concept/@id)]
        return local:createVariableCustom($variable)
};

(:~
 : Finds all relevant references for a given Universe (StudyUnit, Variable)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $universe Universe to process
 :)
declare function result:getUniverseReferences($universe as element()) as element()* {
    (:StudyUnit:)
    for $study in collection('/db/dda')//su:StudyUnit[ft:query(r:UniverseReference/r:ID, $universe/@id)]
        return <CustomList type="StudyUnit">
            <Custom option="id">{data($study/@id)}</Custom>
            {local:createCustomLabel($study/r:Citation/r:Title)}
        </CustomList>,
    (:Variable:)
    for $variable in collection('/db/dda')//lp:Variable[ft:query(r:UniverseReference/r:ID, $universe/@id)]
        return local:createVariableCustom($variable)
};

(:~
 : Finds all relevant references for a given Category (Question, Variable)
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $category Category to process
 :)
declare function result:getCategoryReferences($category as element()) as element()* {
    (:QuestionItem:)
    for $codeScheme in collection('/db/dda')//lp:CodeScheme[ft:query(lp:Code/lp:CategoryReference/r:ID, $category/@id)]
        for $question in collection('/db/dda')//dc:QuestionItem[ft:query(dc:CodeDomain/r:CodeSchemeReference/r:ID, $codeScheme/@id)]
            return local:createQuestionItemCustom($question),
    (:Variable:)
    for $codeScheme in collection('/db/dda')//lp:CodeScheme[ft:query(lp:Code/lp:CategoryReference/r:ID, $category/@id)]
        for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID, $codeScheme/@id)]
            return local:createVariableCustom($variable)
};