xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";  

declare function local:main() as node()? {

    let $httpAcceptLanguage := data(request:get-header('Accept-Language'))
    let $parameterLanguage := data(request:get-parameter("lang", "da"))
    let $lang := if($parameterLanguage = 'da')
        then 'da'
    else if ($parameterLanguage = 'en')
        then 'en'
    else if (fn:contains($httpAcceptLanguage, 'da'))
        then 'da'
    else 'en'
      
    let $seriesList :=  ddi:listDdiSeries($lang)          
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/catalogue.xsl")    
    let $params := <parameters>
            <param name="lang" value="{$lang}"/>
            <param name="hostname" value="@WEB-HOST_NAME@" />
            <param name="catalogueType" value="series" />
        </parameters>    
    return transform:transform($seriesList, $searchResultsStylesheet, $params)
};

local:main()
