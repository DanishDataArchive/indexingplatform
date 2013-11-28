xquery version "1.0";

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
    
    let $stylesheet := doc("/db/apps/web/transform/searchresult/techinfo.xsl")    
    let $schemas := <collections>{local:ls('/db/apps/dda/schema')}</collections>
    let $params := <parameters>
            <param name="lang" value="{$lang}"/>
            <param name="hostname" value="@WEB-HOST_NAME@" />
        </parameters>    
    return transform:transform($schemas, $stylesheet, $params)
};

declare function local:ls($collection as xs:string) as element()* {
  if (xmldb:collection-available($collection)) then
    (         
       for $child in xmldb:get-child-resources($collection)
        let $path := concat($collection, '/', $child)
        order by $child 
        return
          <resource name="{$child}" path="{$path}" />
    ) else ()
};

local:main()
