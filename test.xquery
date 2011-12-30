import module namespace ddi = "http://dda.dk/ddi" at "file:///C:/Users/kp/Dropbox/DDA/DDA-IPF/lib/search.xquery";(:"xmldb:exist:///db/dda/lib/search.xquery":)

let $simple-search-parameters := <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
 xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
 xmlns:s="http://dda.dk/ddi/scope"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ssp:search-string>national</ssp:search-string>
    <smd:SearchMetaData hits-perpage="10" hit-start="0"/>
    <s:Scope>
        <s:StudyUnit/>
        <s:Variable/>
        <s:QuestionItem/>
        <s:MultipleQuestionItem/>
        <s:Universe/>
        <s:Concept/>
        <s:Category/>
    </s:Scope>
</ssp:SimpleSearchParameters>

return ddi:simpleSearch($simple-search-parameters)

(:let $searchParameters :=
    <SearchParameters xmlns="http://dda.dk/ddi/search-parameters" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <studyId>studyId0</studyId>
        <title>title0</title>
        <abstract-purpose>abstract-purpose0</abstract-purpose>
        <creator>creator0</creator>
        <kindOfData>kindOfData0</kindOfData>
        <coverageFrom>2006-05-04</coverageFrom>
        <coverageTo>2006-05-04</coverageTo>
        <concept>concept0</concept>
        <universe>universe0</universe>
        <question>question0</question>
        <variable>variable0</variable>
        <category>category0</category>
    </SearchParameters>
return ddi:advancedSearch($searchParameters, 10, 0):)
(:ddi:lookupQuestion('quei-40b54010-32c6-4b7c-9f1e-6b8f662462c1'):)
(:ddi:lookupVariable('vari-1-9db0a9d8-2fd3-425f-aaf2-67ddd0b677ef'):)
(:ddi:lookupConcept('conc-695fdb22-4bf1-4359-9647-4a1c421593d1'):)
(:ddi:lookupUniverse('eafc0dde-0b5e-4449-b3dd-09071f6a2707'):)
(:ddi:lookupCategory('cat-d4ebcb36-9409-4b41-bdaa-ece686b5f772'):)