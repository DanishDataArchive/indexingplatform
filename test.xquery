import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/lib/search.xquery";
import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/dda-urn/lib/urn.xquery";

declare namespace cc="ddi:conceptualcomponent:3_1";
declare namespace r="ddi:reusable:3_1";

let $simple-search-parameters := <ssp:SimpleSearchParameters xmlns:smd="http://dda.dk/ddi/search-metadata"
 xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
 xmlns:s="http://dda.dk/ddi/scope"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ssp:search-string>indmeldelse and begrundelse</ssp:search-string>
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
    
let $ap := <asp:AdvancedSearchParameters xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
xmlns="http://dda.dk/ddi/advanced-search-parameters"
xmlns:sear="http://dda.dk/ddi/search-metadata"
xmlns:scop="http://dda.dk/ddi/scope">
 <asp:abstract-purpose>spørgsskemaundersøgelse</asp:abstract-purpose>
 <sear:SearchMetaData hits-perpage="10" hit-start="0"/>
 <scop:Scope>
   <scop:StudyUnit/>
   <scop:Variable/>
   <scop:QuestionItem/>
   <scop:MultipleQuestionItem/>
   <scop:Universe/>
   <scop:Concept/>
   <scop:Category/>
 </scop:Scope>
</asp:AdvancedSearchParameters>

let $urn := "urn:ddi:dk.dda:quei-c5539352-4c17-42e7-b6b4-ea775ccc82fb:1.0.0"

return ddi:simpleSearch($simple-search-parameters)
(:return ddi:advancedSearch($ap):)
(:return urn:resolveUrn($urn):)

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