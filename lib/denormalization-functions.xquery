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

declare function local:saveVariableToQuestionItem($variable as element(), $questionItemId as xs:string) as item()* {
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
            <Concept id="{$conceptId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <VariableReferenceList>
                    <VariableReference id="{$variableId}"/>
                </VariableReferenceList>
            </Concept>
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

declare function local:listVariables() as node()* {
    let $variableList := collection('/db/dda')//lp:Variable
    let $dernormalizedVariables :=
        for $variable in $variableList
            let $study-unit := $variable/ancestor-or-self::su:StudyUnit
            return <Variable id="{data($variable/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                <QuestionItemReferenceList>
                {
                for $questionId in $variable/lp:QuestionReference/r:ID
                    let $questionItemSaved := local:saveVariableToQuestionItem($variable, $questionId)
                    return <QuestionItemReference id="{$questionId}"/>
                }
                </QuestionItemReferenceList>
                <UniverseReferenceList>
                {
                for $universeId in $variable/r:UniverseReference/r:ID
                    let $universeSaved := local:saveVariableToUniverse($variable, $universeId)
                    return <UniverseReference id="{$universeId}"/>
                }
                </UniverseReferenceList>
                <ConceptReferenceList>
                {
                for $conceptId in $variable/lp:ConceptReference/r:ID
                    let $conceptSaved := local:saveVariableToConcept($variable, $conceptId)
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

(:declare function local:denormalize() as element() {
    let $variableList := local:listVariables()
    return <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        {$variableList}
    </DenormalizedDdi>
};:)

local:createDenormalizationDocuments(),
local:listVariables()