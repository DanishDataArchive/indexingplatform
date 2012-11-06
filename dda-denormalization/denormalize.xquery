xquery version "1.0";

(:~
 : This file contains the functions for executing the denormalization of the DDI database into an additional collection (dda-denormalization).
 : Utilization of this denormalized data greatly optimizes listing of references when performing a search.<br/>
 : The denormalization process should be performed at a fixed interval in order to keep the data up to date.
 :)

declare namespace d="http://dda.dk/ddi/denormalized-ddi";

declare namespace i="ddi:instance:3_1";
declare namespace su="ddi:studyunit:3_1";
declare namespace r="ddi:reusable:3_1";
declare namespace dc="ddi:datacollection:3_1";
declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace lp="ddi:logicalproduct:3_1";

declare namespace  xmldb="http://exist-db.org/xquery/xmldb";

(:~
 : Creates a XML document in the <b>dda-denormalization</b> collection for each of the DDI elements we wish to denormalize
 : (if it already exists it will be overwritten) and populates it with reference lists for all every element.
 :
 : @author  Kemal Pajevic
 : @version 1.0
 :)
declare function local:createDenormalizationDocuments() as item()* {
    xmldb:store('/db/dda-denormalization/data', "VariableList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <VariableList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization/data', "QuestionItemList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <QuestionItemList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization/data', "MultipleQuestionItemList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <MultipleQuestionItemList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization/data', "UniverseList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <UniverseList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization/data', "ConceptList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <ConceptList />
        </DenormalizedDdi>
    ),
    xmldb:store('/db/dda-denormalization/data', "CategoryList.xml",
        <DenormalizedDdi xmlns="http://dda.dk/ddi/denormalized-ddi" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <CategoryList />
        </DenormalizedDdi>
    )
};

declare function local:listVariables() as node()* {
    let $dernormalizedVariables :=
        for $variable in collection('/db/dda')//lp:Variable
            let $variableId := string($variable/@id)
            let $study-unit := $variable/ancestor::su:StudyUnit
            return
            <Variable id="{$variableId}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                { (:QuestionItemReference:)
                for $questionId in $variable/lp:QuestionReference/r:ID
                    return <QuestionItemReference id="{$questionId}"/>
                }
                { (:MultipleQuestionItemReference:)
                for $questionId in $variable/lp:QuestionReference/r:ID
                    let $questionIdString := string($questionId)
                    for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionIdString)]
                        return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                { (:UniverseReference:)
                for $universeId in $variable/r:UniverseReference/r:ID
                    return <UniverseReference id="{$universeId}"/>
                }
                { (:ConceptReference:)
                for $conceptId in $variable/lp:ConceptReference/r:ID
                    return <ConceptReference id="{$conceptId}"/>
                }
                { (:CategoryReference:)
                for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                    let $codeSchemeIdString := string($codeSchemeId)
                    let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                    return
                    for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                        return <CategoryReference id="{$categoryId}"/>
                }
            </Variable>
    return update insert $dernormalizedVariables into collection('/db/dda-denormalization/data')//d:VariableList
};

declare function local:listQuestionItems() as node()* {
    let $dernormalizedQuestionItems :=
        for $questionItem in collection('/db/dda')//dc:QuestionItem
            let $questionItemId := string($questionItem/@id)
            let $study-unit := $questionItem/ancestor::su:StudyUnit
            return
            <QuestionItem id="{data($questionItem/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                { (:VariableReference:)
                for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionItemId)]
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                { (:MultipleQuestionItemReference:)
                for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionItemId)]
                    return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                { (:UniverseReference:)
                for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionItemId)]
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
                { (:ConceptReference:)
                for $conceptId in $questionItem/dc:ConceptReference/r:ID
                    return <ConceptReference id="{$conceptId}"/>
                }
                { (:CategoryReference:)
                for $codeSchemeId in $questionItem/dc:CodeDomain/r:CodeSchemeReference/r:ID
                    let $codeSchemeIdString := string($codeSchemeId)
                    let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                    return
                    for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                        return <CategoryReference id="{$categoryId}"/>
                }
            </QuestionItem>
    return update insert $dernormalizedQuestionItems into collection('/db/dda-denormalization/data')//d:QuestionItemList
};

declare function local:listMultipleQuestionItems() as node()* {
    let $dernormalizedMultipleQuestionItems :=
        for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem
            let $multipleQuestionItemId := string($multipleQuestionItem/@id)
            let $study-unit := $multipleQuestionItem/ancestor::su:StudyUnit
            let $questions := $multipleQuestionItem/dc:SubQuestions/dc:QuestionItem
            return
            <MultipleQuestionItem id="{data($multipleQuestionItem/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                { (:VariableReference:)
                for $question in $questions
                    let $questionIdString := string($question/@id)
                    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $questionIdString)]
                        return <VariableReference id="{$variable/@id}"/>
                }
                { (:QuestionItemReference:)
                for $question in $questions
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                { (:UniverseReference:)
                for $question in $questions
                    for $variable in collection('/db/dda')//lp:Variable[ft:query(lp:QuestionReference/r:ID, $question/@id)]
                        for $universeId in $variable/r:UniverseReference/r:ID
                            return <UniverseReference id="{$universeId}"/>
                }
                { (:ConceptReference:)
                for $conceptId in $multipleQuestionItem/dc:ConceptReference/r:ID
                    return <ConceptReference id="{$conceptId}"/>
                }
                { (:CategoryReference:)
                for $question in $questions
                    for $codeSchemeId in $question/dc:CodeDomain/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
            </MultipleQuestionItem>
    return update insert $dernormalizedMultipleQuestionItems into collection('/db/dda-denormalization/data')//d:MultipleQuestionItemList
};

declare function local:listUniverses() as node()* {
    let $dernormalizedUniverses :=
        for $universe in collection('/db/dda')//cc:Universe
            let $universeId := string($universe/@id)
            let $study-unit := $universe/ancestor::su:StudyUnit
            let $variables := collection('/db/dda')//lp:Variable[ft:query(r:UniverseReference/r:ID, $universeId)]
            return
            <Universe id="{data($universe/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                { (:VariableReference:)
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                { (:QuestionItemReference:)
                for $variable in $variables
                    for $questionId in $variable/lp:QuestionReference/r:ID
                        return <QuestionItemReference id="{$questionId}"/>
                }
                { (:MultipleQuestionItemReference:)
                for $variable in $variables
                    for $questionId in $variable/lp:QuestionReference/r:ID
                        let $questionIdString := string($questionId)
                        for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $questionIdString)]
                            return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                { (:ConceptReference:)
                for $variable in $variables
                    for $conceptId in $variable/lp:ConceptReference/r:ID
                        return <ConceptReference id="{$conceptId}"/>
                }
                { (:CategoryReference:)
                for $variable in $variables
                    for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
            </Universe>
    return update insert $dernormalizedUniverses into collection('/db/dda-denormalization/data')//d:UniverseList
};

declare function local:listConcepts() as node()* {
    let $dernormalizedConcepts :=
        for $concept in collection('/db/dda')//cc:Concept
            let $conceptId := string($concept/@id)
            let $study-unit := $concept/ancestor::su:StudyUnit
            let $variables := collection('/db/dda')//lp:Variable[ft:query(lp:ConceptReference/r:ID, $conceptId)]
            return
            <Concept id="{data($concept/@id)}" studyId="{data($study-unit/@id)}" xmlns="http://dda.dk/ddi/denormalized-ddi">
                { (:VariableReference:)
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                { (:QuestionItemReference:)
                for $question in collection('/db/dda')//dc:QuestionItem[ft:query(dc:ConceptReference/r:ID, $conceptId)]
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                { (:MultipleQuestionItemReference:)
                for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:ConceptReference/r:ID, $conceptId)]
                    return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                { (:UniverseReference:)
                for $variable in $variables
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
               { (:CategoryReference:)
                for $variable in $variables
                    for $codeSchemeId in $variable/lp:Representation/lp:CodeRepresentation/r:CodeSchemeReference/r:ID
                        let $codeSchemeIdString := string($codeSchemeId)
                        let $codeScheme := collection('/db/dda')//lp:CodeScheme[ft:query(@id, $codeSchemeIdString)]
                        return
                        for $categoryId in $codeScheme/lp:Code/lp:CategoryReference/r:ID
                            return <CategoryReference id="{$categoryId}"/>
                }
            </Concept>
    return update insert $dernormalizedConcepts into collection('/db/dda-denormalization/data')//d:ConceptList
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
                { (:VariableReference:)
                for $variable in $variables
                    return <VariableReference id="{data($variable/@id)}"/>
                }
                { (:QuestionItemReference:)
                for $question in $questions
                    return <QuestionItemReference id="{$question/@id}"/>
                }
                { (:MultipleQuestionItemReference:)
                for $question in $questions
                    for $multipleQuestionItem in collection('/db/dda')//dc:MultipleQuestionItem[ft:query(dc:SubQuestions/dc:QuestionItem/@id, $question/@id)]
                        return <MultipleQuestionItemReference id="{$multipleQuestionItem/@id}"/>
                }
                { (:UniverseReference:)
                for $variable in $variables
                    for $universeId in $variable/r:UniverseReference/r:ID
                        return <UniverseReference id="{$universeId}"/>
                }
                { (:ConceptReference:)
                for $variable in $variables
                    for $conceptId in $variable/lp:ConceptReference/r:ID
                        return <ConceptReference id="{$conceptId}"/>
                }
            </Category>
    return update insert $dernormalizedCategorys into collection('/db/dda-denormalization/data')//d:CategoryList
};

local:createDenormalizationDocuments(),
local:listVariables(),
local:listQuestionItems(),
local:listMultipleQuestionItems(),
local:listUniverses(),
local:listConcepts(),
local:listCategories()