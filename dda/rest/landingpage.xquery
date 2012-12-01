xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {

    let $study := ddi:getDdiStudy(request:get-parameter("studyid", "0"))
    let $metadataStylesheet := doc("/db/apps/dda/transform/metadata/DdiStudyUnit_To_DdaMetadata.xsl")
    let $landingpageStylesheet := doc("/db/apps/dda/transform/landingpage/lp-main.xsl")    
    let $httpAcceptLanguage := data(request:get-header('Accept-Language'))
    let $parameterLanguage := data(request:get-parameter("lang", "n/a"))
        
    let $lang := if($parameterLanguage = 'da')
        then 'da'
    else if ($parameterLanguage = 'en')
        then 'en'
    else if (fn:contains($httpAcceptLanguage, 'da'))
        then 'da'
    else 'en'
    
    let $params := <parameters>
            <param name="lang" value="{$lang}"/>            
        </parameters>

    let $metadataResultXml := transform:transform($study, $metadataStylesheet, $params)
    return transform:transform($metadataResultXml, $landingpageStylesheet, $params)
};

local:main()