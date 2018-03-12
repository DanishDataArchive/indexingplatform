xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=no process-xsl-pi=no
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
            <param name="render-as-document" value="true" />
            <param name="print-anchor" value="true" />
            
            <!-- language -->
            <param name="lang" value="{$lang}" />
            <param name="fallback-lang" value="en" />
            <param name="translations" value="i18n/messages_{$lang}.properties.xml" />
            <param name="languageSwitch" value="da,en" />
            
            <!-- css and js path -->            
            <param name="theme-path" value="theme/" />
            <param name="path-prefix" value=""/>
            
            <!-- java script enable -->
            <param name="include-js" value="true" />
            <param name="show-category-statistics" value="false"/>            
            <param name="show-navigration-bar" value="true" />
            
            <!-- display options -->
            <param name="show-study-title" value="true" />
            <param name="show-study-information" value="true" />
            <param name="show-guidance" value="true" />
            <param name="show-kind-of-data" value="false" />
            <param name="show-citation" value="false" />
            <param name="show-abstract" value="false" />
            <param name="show-coverage" value="false" />
            <param name="show-questionnaires" value="false" />
            <param name="show-variable-list" value="false" />
            <param name="show-numeric-var-frequence" value="false" />
            <param name="show-universe" value="true" />
            <param name="show-otherdocuments" value="false" />
            
            <!-- information links -->            
            <param name="guidancelink" value="http://samfund.dda.dk/dda/vejledning_kodebog_1.0.asp"/>
            <param name="currationprocesslink" value="http://samfund.dda.dk/dda/oparbejdningsproces.asp"/>
        </parameters>

    return transform:transform($study, $stylesheet, $params)
};

local:main()

