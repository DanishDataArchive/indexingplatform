import module namespace ddi = "http://dda.dk/ddi" at "file:///C:/Users/kp/Dropbox/DDA/DDA-IPF/lib/search.xquery";(:"xmldb:exist:///db/dda/lib/search.xquery":)

let $simple-search-parameters := <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
 xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
 xmlns:s="http://dda.dk/ddi/scope"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ssp:search-string>V114</ssp:search-string>
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

let $advanced-search-parameters :=
    <asp:AdvancedSearchParameters xmlns:sm="http://dda.dk/ddi/search-metadata"
     xmlns:s="http://dda.dk/ddi/scope"
     xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
     xsi:schemaLocation="http://dda.dk/ddi/advanced-search-parameters file:/C:/Users/kp/Dropbox/DDA/DDA-IPF/schema/search/advanced-search-parameters.xsd">
        <asp:studyId>13794</asp:studyId>
        <asp:title>kommunale</asp:title>
        <asp:topicalCoverage>Tillidserhverv</asp:topicalCoverage>
        <asp:spatialCoverage>national</asp:spatialCoverage>
        <asp:abstract-purpose>udvalgstilknytning</asp:abstract-purpose>
        <asp:creator>Søren</asp:creator>
        <asp:kindOfData>Spørgeskemaundersøgelse</asp:kindOfData>
        <asp:coverageFrom>2000-08-01</asp:coverageFrom>
        <asp:coverageTo>2000-12-01</asp:coverageTo>
        <asp:Variable>STUDIENUMMER</asp:Variable>
        <asp:QuestionItem>studiesituation</asp:QuestionItem>
        <sm:SearchMetaData hits-perpage="10" hit-start="0"/>
        <s:Scope>
            <s:StudyUnit/>
            <s:Variable/>
            <s:QuestionItem/>
            <s:MultipleQuestionItem/>
            <s:Universe/>
            <s:Concept/>
            <s:Category/>
        </s:Scope>
    </asp:AdvancedSearchParameters>
    
return
if(false()) then
    ddi:simpleSearch($simple-search-parameters)
else
    ddi:advancedSearch($advanced-search-parameters)

(:return ddi:test():)
(:ddi:lookupQuestion('quei-40b54010-32c6-4b7c-9f1e-6b8f662462c1'):)
(:ddi:lookupVariable('vari-1-9db0a9d8-2fd3-425f-aaf2-67ddd0b677ef'):)
(:ddi:lookupConcept('conc-695fdb22-4bf1-4359-9647-4a1c421593d1'):)
(:ddi:lookupUniverse('eafc0dde-0b5e-4449-b3dd-09071f6a2707'):)
(:ddi:lookupCategory('cat-d4ebcb36-9409-4b41-bdaa-ece686b5f772'):)

(:        <asp:Variable>Variable0</asp:Variable>
        <asp:QuestionItem>QuestionItem0</asp:QuestionItem>
        <asp:MultipleQuestionItem>MultipleQuestionItem0</asp:MultipleQuestionItem>
        <asp:Universe>andet</asp:Universe>
        <asp:Concept>Concept0</asp:Concept>
        <asp:Category>Category0</asp:Category>:)