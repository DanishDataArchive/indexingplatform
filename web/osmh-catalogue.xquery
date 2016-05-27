xquery version "3.1";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:media-type "text/xml";
declare option output:method "xml";

    (: let $studies :=  ddi:oshmListDdiStudies()
    return $studies :)

let $lang := "en"
let $studies :=  ddi:listDdiStudies($lang)    
(:let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/catalogue.xsl")    
let $params := <parameters>
        			<param name="lang" value="{$lang}"/>
        			<param name="hostname" value="hop" />
    			</parameters>    
return transform:transform($studies, $searchResultsStylesheet, $params):)
return $studies
