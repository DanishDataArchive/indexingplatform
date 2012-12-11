xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {

    let $study := ddi:getDdiStudy(request:get-parameter("studyid", "0"))
    let $stylesheet := doc("/db/apps/web/transform/codebook/ddaddi3_1.xsl")    
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
            <param name="lang" value="{$lang}" />
			<param name="fallback-lang" value="en" />
			<param name="translations" value="i18n/messages_{$lang}.properties.xml" />
			<param name="render-as-document" value="true" />            
    		<param name="guidancelink" value="http://samfund.dda.dk/dda/vejledning_kodebog_1.0.asp"/>
			<param name="currationprocesslink" value="http://samfund.dda.dk/dda/oparbejdningsproces.asp"/>
            
			<!--param name="include-js" value="{xs:string(1)}" />
			<param name="print-anchor" value="1" />
			<param name="show-study-title" value="1" />
			<param name="show-study-information" value="1" />
			<param name="show-guidance" value="1" />
			<param name="show-kind-of-data" value="0" />
			<param name="show-citation" value="0" />
			<param name="show-abstract" value="0" />
			<param name="show-coverage" value="0" />
			<param name="show-questionnaires" value="0" />
			<param name="show-navigration-bar" value="1" />
			<param name="show-variable-list" value="0" />
			<param name="theme-path" value="theme/default" />
			<param name="path-prefix" value="." />
			<param name="show-numeric-var-frequence" value="0" />
			<param name="show-universe" value="1" /-->
        </parameters>

    return transform:transform($study, $stylesheet, $params)
};

local:main()

