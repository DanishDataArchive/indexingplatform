xquery version "1.0";

(:~
 : This module contains the functions used to find DDI elements by URN.
 : The entry function for this module is <b> urn:resolveUrn</b>.<br /> 
 : The rest of the functions are local and cannot be used externally.
 :)
module namespace urn = "http://dda.dk/ddi/urn";

declare namespace su="ddi:studyunit:3_1";

(:~
 : Returns the DDI element specified by an ID and version
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $urn the URN address in the format urn:ddi:[agency].[sub_agency]:[id]:[version], for instance urn:ddi:dk.dda:quei-c5539352-4c17-42e7-b6b4-ea775ccc82fb:1.0.0
 :)
declare function urn:resolveUrn($urn as xs:string) as element()? {
    (: First split the URN address in tokens seperated by ':' :)
    let $tokenizedUrn := tokenize($urn, ":")
    (: We look up an identifiable element by the ID (token 4) and for each element it finds for that ID we compare its nearest version with the version specified in the URN (token 5) :)
    let $allMatches :=
        for $identifiableFromId in collection('/db/apps/dda-urn')//*[ft:query(@id, $tokenizedUrn[4])]
            return
            if (local:findVersion($identifiableFromId) = $tokenizedUrn[5]) then
                $identifiableFromId
            else ()
    (: If there were duplicates in the database (same id and version) just return the first :)
    return $allMatches[1]
};

(:~
 : Returns a list of LightXmlObject element containing the existing versions of a study.
 : It looks both in the main database and the URN database and returns all found versions for the given study.
 : The result 'id' attribute of the LightXmlObject object contains the study ID, the 'version' attribute contains the version
 : and the 'element' attribute contains main-db|urn-db spedifying in which database the result was found.
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $studyId the ID of the study
 :)
declare function urn:getStudyVersions($studyId as xs:string) as element()? {
    <dl:LightXmlObjectList xmlns:dl="ddieditor-lightobject"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="ddieditor-lightobject ddieditor-lightxmlobject.xsd"
        xmlns:rmd="http://dda.dk/ddi/result-metadata">
        {
        let $study := collection('/db/apps/dda')//su:StudyUnit[ft:query(@id, $studyId)]
        return <LightXmlObject element="main-db" id="{data($study/@id)}" version="{data($study/@version)}" />,
        for $study in collection('/db/apps/dda-urn')//su:StudyUnit[ft:query(@id, $studyId)]
            return <LightXmlObject element="urn-db" id="{data($study/@id)}" version="{data($study/@version)}" />
        }
    </dl:LightXmlObjectList>
};


(:~
 : Returns the nearest version for the given element.
 : It checks if the element itself has an 'version' attribute and if so it returns that attribute.
 : If the element does not have that attribute the function calls itself recursively until a version attribute is found or until we have reached the root element.
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $element the element for which we want to find the version
 :)
declare function local:findVersion($element as element()) as xs:string? {
    if ($element/@version) then
        $element/@version
    else
        let $parent := $element/..
        return if ($parent) then
            local:findVersion($parent)
        else ()
};