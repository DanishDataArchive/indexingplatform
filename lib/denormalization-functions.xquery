(:module namespace denormalization = "http://dda.dk/ddi/denormalization";:)

declare namespace d="http://dda.dk/ddi/denormalized-ddi";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

declare namespace  xmldb="http://exist-db.org/xquery/xmldb";

declare function local:createDenormalizationDocuments() as item()* {
    xmldb:store('/db/dda-denormalization', "VariableList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <VariableList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization', "QuestionItemList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <QuestionItemList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization', "MultipleQuestionItemList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <MultipleQuestionItemList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization', "UniverseList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <UniverseList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization', "ConceptList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ConceptList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization', "CategoryList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <CategoryList />
        </DenormalizedDdi>
    )
};

(:declare function local:saveVariableToQuestionItem($variable as element(), $questionItemId as xs:string) as item()* {
    let $questionItem := collection('/db/dda')//dc:QuestionItem[ft:query(@id, $questionItemId)]
    let $variableId := data($variable/@id)
    let $study-unit := $questionItem/ancestor-or-self::su:StudyUnit
    let $dernormalizedQuestionItem := collection('/db/dda-denormalization')//d:QuestionItem[@id=$questionItemId]
    return
    if ($dernormalizedQuestionItem) then
        let $variableAlreadySaved := $dernormalizedQuestionItem/d:VariableReferenceList/d:VariableReference[@id=$variableId]
        return
        if ($variableAlreadySaved) then
            ()
        else
            let $newVariableReference := <VariableReference id="{$variableId}" xmlns="http://dda.dk/ddi/denormalized-ddi"/>
            return update insert $newVariableReference into collection('/db/dda-denormalization')//$dernormalizedQuestionItem//d:VariableReferenceList
    else
        let $newDernormalizedQuestionItem :=
            <QuestionItem id="{$questionItemId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                    <VariableReference id="{$variableId}"/>
                </VariableReferenceList>
            </QuestionItem>
        return update insert $newDernormalizedQuestionItem into collection('/db/dda-denormalization')//d:QuestionItemList
};

declare function local:saveVariableToUniverse($variable as element(), $universeId as xs:string) as item()* {
    let $universe := collection('/db/dda')//cc:Universe[ft:query(@id, $universeId)]
    let $variableId := data($variable/@id)
    let $study-unit := $universe/ancestor-or-self::su:StudyUnit
    let $dernormalizedUniverse := collection('/db/dda-denormalization')//d:Universe[@id=$universeId]
    return
    if ($dernormalizedUniverse) then
        let $variableAlreadySaved := $dernormalizedUniverse/d:VariableReferenceList/d:VariableReference[@id=$variableId]
        return
        if ($variableAlreadySaved) then
            ()
        else
            let $newVariableReference := <VariableReference id="{$variableId}" xmlns="http://dda.dk/ddi/denormalized-ddi"/>
            return update insert $newVariableReference into collection('/db/dda-denormalization')//$dernormalizedUniverse//d:VariableReferenceList
    else
        let $newDernormalizedUniverse :=
            <Universe id="{$universeId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                    <VariableReference id="{$variableId}"/>
                </VariableReferenceList>
            </Universe>
        return update insert $newDernormalizedUniverse into collection('/db/dda-denormalization')//d:UniverseList
};

declare function local:saveVariableToConcept($variable as element(), $conceptId as xs:string) as item()* {
    let $concept := collection('/db/dda')//cc:Concept[ft:query(@id, $conceptId)]
    let $variableId := data($variable/@id)
    let $study-unit := $concept/ancestor-or-self::su:StudyUnit
    let $dernormalizedConcept := collection('/db/dda-denormalization')//d:Concept[@id=$conceptId]
    return
    if ($dernormalizedConcept) then
        let $variableAlreadySaved := $dernormalizedConcept/d:VariableReferenceList/d:VariableReference[@id=$variableId]
        return
        if ($variableAlreadySaved) then
            ()
        else
            let $newVariableReference := <VariableReference id="{$variableId}" xmlns="http://dda.dk/ddi/denormalized-ddi"/>
            return update insert $newVariableReference into collection('/db/dda-denormalization')//$dernormalizedConcept//d:VariableReferenceList
    else
        let $newDernormalizedConcept :=
            <ConceptW id="{$conceptId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                    <VariableReference id="{$variableId}"/>
                </VariableReferenceList>
            </ConceptW>
        return update insert $newDernormalizedConcept into collection('/db/dda-denormalization')//d:ConceptList
};

declare function local:saveVariableToCategory($variable as element(), $categoryId as xs:string) as item()* {
    let $category := collection('/db/dda')//lp:Category[ft:query(@id, $categoryId)]
    let $variableId := data($variable/@id)
    let $study-unit := $category/ancestor-or-self::su:StudyUnit
    let $dernormalizedCategory := collection('/db/dda-denormalization')//d:Category[@id=$categoryId]
    return
    if ($dernormalizedCategory) then
        let $variableAlreadySaved := $dernormalizedCategory/d:VariableReferenceList/d:VariableReference[@id=$variableId]
        return
        if ($variableAlreadySaved) then
            ()
        else
            let $newVariableReference := <VariableReference id="{$variableId}" xmlns="http://dda.dk/ddi/denormalized-ddi"/>
            return update insert $newVariableReference into collection('/db/dda-denormalization')//$dernormalizedCategory//d:VariableReferenceList
    else
        let $newDernormalizedCategory :=
            <Category id="{$categoryId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                    <VariableReference id="{$variableId}"/>
                </VariableReferenceList>
            </Category>
        return update insert $newDernormalizedCategory into collection('/db/dda-denormalization')//d:CategoryList
};

declare function local:saveCounterReference($referredElement as element(), $thisElementId as xs:string, $thisElementLocalName as xs:string, $thisElementStudyUnitId as xs:string) as item()* {
    let $thisElementListLocalName := concat($thisElementLocalName, "List")
    let $referredElementId := data($referredElement/@id)
    let $referredElementReferenceName := concat(local-name($referredElement), "Reference")
    let $referredElementReferenceListName := concat(local-name($referredElement), "ReferenceList")
    let $dernormalizedThisElement := collection('/db/dda-denormalization')//d:*[name()=$thisElementLocalName][@id=$thisElementId]
    return
    if ($dernormalizedThisElement) then
        let $referredElementAlreadySaved := $dernormalizedThisElement/d:*[name()=$referredElementReferenceListName]/d:*[name()=$referredElementReferenceName][@id=$referredElementId]
        return
        if ($referredElementAlreadySaved) then
            ()
        else
            let $newReferredElementReference :=
                element {QName("http://dda.dk/ddi/denormalized-ddi", $referredElementReferenceName)} {
                    attribute id {$referredElementId}
                }
            return update insert $newReferredElementReference into collection('/db/dda-denormalization')//$dernormalizedThisElement//d:*[name()=$referredElementReferenceListName]
    else
        let $newDernormalizedThisElement :=
            element {QName("http://dda.dk/ddi/denormalized-ddi", $thisElementLocalName)} {
                attribute id {$thisElementId},
                attribute studyId {$thisElementStudyUnitId},
                element {$referredElementReferenceListName} {
                    element {$referredElementReferenceName} {
                        attribute id {$referredElementId}
                    }
                }
            }
        return update insert $newDernormalizedThisElement into collection('/db/dda-denormalization')//d:*[name()=$thisElementListLocalName]
};:)

declare function local:listVariables() as node()* {
    let $dernormalizedVariables :=
        for $variable in collection('/db/dda')//lp:Variable
            let $variableId := string($variable/@id)
            let $study-unit := $variable/ancestor::su:StudyUnit
            return
            <Variable id="{$variableId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <QuestionItemReferenceList>
                {
                for $questionId in $variable/lp:QuestionReference/r:ID
                    (:let $questionItemSaved := local:saveVariableToQuestionItem($variable, $questionId):)
                    return <QuestionItemReference id="{$questionId}"/>
                }
                </QuestionItemReferenceList>
                <MultipleQuestionItemReferenceList>
                {
                for $questionId in $variable/lp:QuestionReference/r:ID
                    let $questionIdString := string($questionId)
                    for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionIdString)]
                        return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                </MultipleQuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $universeId in $variable/r:UniverseReference/r:ID
                    (:let $universeIdString := string($universeId)
                    let $universe := collection('/db/dda')//cc:Universe[ft:query(@id, $universeIdString)]
                    let $universe-suId := data($universe/ancestor::su:StudyUnit/@id)
                    let $universeSaved := local:saveCounterReference($variable, $universeIdString, "Universe", $universe-suId):)
                    return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <ConceptReferenceList>
                {
                for $conceptId in $variable/lp:ConceptReference/r:ID
                    (:let $conceptIdString := string($conceptId)
                    let $concept := collection('/db/dda')//cc:Concept[ft:query(@id, $conceptIdString)]
                    let $concept-suId := data($concept/ancestor::su:StudyUnit/@id)
                    let $conceptSaved := local:saveCounterReference($variable, $conceptIdString, "Concept", $concept-suId):)
                    return <ConceptReference id="{$conceptId}"/>
                }
                </ConceptReferenceList>
                <CategoryReferenceList>
                {
                for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                    let $codeSchemeIdString := string($codeSchemeId)
                    let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                    return
                    for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                        (:let $categorySaved := local:saveVariableToCategory($variable, $categoryId):)
                        return <CategoryReference id="{$categoryId}"/>
                }
                </CategoryReferenceList>
            </Variable>
    return update insert $dernormalizedVariables into collection('/db/dda-denormalization')//d:VariableList
};

declare function local:listQuestionItems() as node()* {
    let $dernormalizedQuestionItems :=
        for $questionItem in collection('/db/dda')//dc:QuestionItem
            let $questionItemId := string($questionItem/@id)
            let $study-unit := $questionItem/ancestor::su:StudyUnit
            return
            <QuestionItem id="{data($questionItem/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                {
                for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionItemId)]
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                </VariableReferenceList>
                <MultipleQuestionItemReferenceList>
                {
                for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionItemId)]
                    return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                </MultipleQuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionItemId)]
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <ConceptReferenceList>
                {
                for $conceptId in $questionItem/dc:ConceptReference/r:ID
                    return <ConceptReference id="{$conceptId}"/>
                }
                </ConceptReferenceList>
                <CategoryReferenceList>
                {
                for $codeSchemeId in $questionItem/dc:CodeDomain/r:CodeSchemeReference/r:ID
                    let $codeSchemeIdString := string($codeSchemeId)
                    let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                    return
                    for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                        return <CategoryReference id="{$categoryId}"/>
                }
                </CategoryReferenceList>
            </QuestionItem>
    return update insert $dernormalizedQuestionItems into collection('/db/dda-denormalization')//d:QuestionItemList
};

declare function local:listMultipleQuestionItems() as node()* {
    let $dernormalizedMultipleQuestionItems :=
        for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem
            let $multipleQuestionItemId := string($multipleQuestionItem/@id)
            let $study-unit := $multipleQuestionItem/ancestor::su:StudyUnit
            let $questions := $multipleQuestionItem/dc:SubQuestions/dc:QuestionItem
            return
            <MultipleQuestionItem id="{data($multipleQuestionItem/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                {
                for $question in $questions
                    let $questionIdString := string($question/@id)
                    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionIdString)]
                        return <VariableReference id="{$variable/@id}"/>
                }
                </VariableReferenceList>
                <QuestionItemReferenceList>
                {
                for $question in $questions
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                </QuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $question in $questions
                    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
                        for $universeId in $variable/r:UniverseReference/r:ID
                            return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <ConceptReferenceList>
                {
                for $conceptId in $multipleQuestionItem/dc:ConceptReference/r:ID
                    return <ConceptReference id="{$conceptId}"/>
                }
                </ConceptReferenceList>
                <CategoryReferenceList>
                {
                for $question in $questions
                    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
                </CategoryReferenceList>
            </MultipleQuestionItem>
    return update insert $dernormalizedMultipleQuestionItems into collection('/db/dda-denormalization')//d:MultipleQuestionItemList
};

declare function local:listUniverses() as node()* {
    let $dernormalizedUniverses :=
        for $universe in collection('/db/dda')//cc:Universe
            let $universeId := string($universe/@id)
            let $study-unit := $universe/ancestor::su:StudyUnit
            let $variables := collection('/db/dda')//lp:Variable[ft:query(r:UniverseReference/r:ID, $universeId)]
            return
            <Universe id="{data($universe/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                {
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                </VariableReferenceList>
                <QuestionItemReferenceList>
                {
                for $variable in $variables
                    for $questionId in $variable/lp:QuestionReference/r:ID
                        return <QuestionItemReference id="{$questionId}"/>
                }
                </QuestionItemReferenceList>
                <MultipleQuestionItemReferenceList>
                {
                for $variable in $variables
                    for $questionId in $variable/lp:QuestionReference/r:ID
                        let $questionIdString := string($questionId)
                        for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionIdString)]
                            return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                </MultipleQuestionItemReferenceList>
                <ConceptReferenceList>
                {
                for $variable in $variables
                    for $conceptId in $variable/lp:ConceptReference/r:ID
                        return <ConceptReference id="{$conceptId}"/>
                }
                </ConceptReferenceList>
                <CategoryReferenceList>
                {
                for $variable in $variables
                    for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
                </CategoryReferenceList>
            </Universe>
    return update insert $dernormalizedUniverses into collection('/db/dda-denormalization')//d:UniverseList
};

declare function local:listConcepts() as node()* {
    let $dernormalizedConcepts :=
        for $concept in collection('/db/dda')//cc:Concept
            let $conceptId := string($concept/@id)
            let $study-unit := $concept/ancestor::su:StudyUnit
            let $variables := collection('/db/dda')//lp:Variable[ft:query(lp:ConceptReference/r:ID, $conceptId)]
            return
            <Concept id="{data($concept/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                {
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                </VariableReferenceList>
                <QuestionItemReferenceList>
                {
                for $question in collection('/db/dda')//dc:QuestionItem[ft:query(dc:ConceptReference/r:ID, $conceptId)]
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                </QuestionItemReferenceList>
                <MultipleQuestionItemReferenceList>
                {
                for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:ConceptReference/r:ID, $conceptId)]
                    return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                </MultipleQuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $variable in $variables
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <CategoryReferenceList>
                {
                for $variable in $variables
                    for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
                </CategoryReferenceList>
            </Concept>
    return update insert $dernormalizedConcepts into collection('/db/dda-denormalization')//d:ConceptList
};

declare function local:listCategories() as node()* {
    let $dernormalizedCategorys :=
        for $category in collection('/db/dda')//lp:Category
            let $categoryId := string($category/@id)
            let $study-unit := $category/ancestor::su:StudyUnit
            let $variables := 
                for $codeScheme in collection('/db/dda')//lp:CodeScheme[ft:query(lp:Code/lp:CategoryReference/r:ID, $categoryId)]
                    return collection('/db/dda')//lp:Variable[ft:query(lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID, $codeScheme/@id)]
            let $questions := 
                for $codeScheme in collection('/db/dda')//lp:CodeScheme[ft:query(lp:Code/lp:CategoryReference/r:ID, $categoryId)]
                    return collection('/db/dda')//dc:QuestionItem[ft:query(dc:CodeDomain/r:CodeSchemeReference/r:ID, $codeScheme/@id)]
            return
            <Category id="{data($category/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                {
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                </VariableReferenceList>
                <QuestionItemReferenceList>
                {
                for $question in $questions
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                </QuestionItemReferenceList>
                <MultipleQuestionItemReferenceList>
                {
                for $question in $questions
                    for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $question/@id)]
                        return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                </MultipleQuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $variable in $variables
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <ConceptReferenceList>
                {
                for $variable in $variables
                    for $conceptId in $variable/lp:ConceptReference/r:ID
                        return <ConceptReference id="{$conceptId}"/>
                }
                </ConceptReferenceList>
            </Category>
    return update insert $dernormalizedCategorys into collection('/db/dda-denormalization')//d:CategoryList
};

local:createDenormalizationDocuments(),
local:listVariables(),
local:listQuestionItems(),
local:listMultipleQuestionItems(),
local:listUniverses(),
local:listConcepts(),
local:listCategories()