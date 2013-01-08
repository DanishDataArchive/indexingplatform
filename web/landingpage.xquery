xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";
import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/apps/dda-urn/lib/urn.xquery";

declare namespace i="ddi:instance:3_1";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";        

declare function local:main() as node()? {

    let $studyId := request:get-parameter("studyid", "0")
    let $version := request:get-parameter("version", "0")
    let $metadataStylesheet := doc("/db/apps/web/transform/metadata/DdiStudyUnit_To_DdaMetadata.xsl")
    let $landingpageStylesheet := doc("/db/apps/web/transform/landingpage/lp-main.xsl")
    let $httpAcceptLanguage := data(request:get-header('Accept-Language'))
    let $parameterLanguage := data(request:get-parameter("lang", "n/a"))
    let $versions := urn:getStudyVersions(request:get-parameter("studyid", ()))
    
    let $study := if($version='0')
        then ddi:getDdiStudy($studyId)
    else
        urn:resolveUrn(concat('urn:ddi:dk.dda:', $studyId, ':', $version))/ancestor::i:DDIInstance
    
    let $lang := if($parameterLanguage = 'da')
        then 'da'
    else if ($parameterLanguage = 'en')
        then 'en'
    else if (fn:contains($httpAcceptLanguage, 'da'))
        then 'da'
    else 'en'
    
    let $currentVersion := $versions//LightXmlObject[@element='main-db']/@version
    
    let $params := <parameters>
            <param name="lang" value="{$lang}"/>
            <param name="previousVersions" value ="{concat(string-join(data($versions//LightXmlObject[@element='urn-db' and @version!=$currentVersion]/@version), ','),',')}" />
        </parameters>

    let $metadataResultXml := transform:transform($study, $metadataStylesheet, $params)
    return transform:transform($metadataResultXml, $landingpageStylesheet, $params)
    
};

local:main()