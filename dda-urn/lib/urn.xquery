xquery version "1.0";

(:~
 : This module contains the functions used to find DDI elements by URN.
 : The entry function for this module is <b> urn:resolveUrn</b>.<br /> 
 : The rest of the functions are local and cannot be used externally.
 :)
module namespace urn = "http://dda.dk/ddi/urn";

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