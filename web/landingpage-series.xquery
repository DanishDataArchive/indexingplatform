xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";
import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/apps/dda-urn/lib/urn.xquery";

declare namespace i="ddi:instance:3_1";
declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";  

declare function local:main() as node()? {

    let $seriesId := request:get-parameter("seriesid", "0")
    let $version := request:get-parameter("version", "0")
    let $metadataStylesheet := doc("/db/apps/web/transform/metadata/DdiGroup_To_DdaMetadata.xsl")
    let $landingpageStylesheet := doc("/db/apps/web/transform/landingpage/lp-main.xsl")
    let $httpAcceptLanguage := data(request:get-header('Accept-Language'))
    let $parameterLanguage := data(request:get-parameter("lang", "n/a"))
    let $versions := urn:getSeriesVersions(request:get-parameter("seriesid", ()))
    
    let $series := if($version='0')
        then ddi:getDdiSeries($seriesId)
    else
        urn:resolveUrn(concat('urn:ddi:dk.dda:', $seriesId, ':', $version))/ancestor::i:DDIInstance 
    
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
            <param name="cvFolder" value="xmldb:exist:///db/apps/web/transform/landingpage/cv" />
            <param name="hostname" value="@WEB-HOST_NAME@" />
            <param name="type" value="series" />
        </parameters>

    let $metadataResultXml := transform:transform($series, $metadataStylesheet, $params)
    
    return transform:transform($metadataResultXml, $landingpageStylesheet, $params)
};

local:main()