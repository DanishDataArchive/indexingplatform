xquery version "1.0";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=no process-xsl-pi=no
        doctype-public=-//W3C//DTD&#160;HTML&#160;4.01&#160;Transitional//EN
        doctype-system=http://www.w3.org/TR/loose.dtd";

declare function local:main() as node()? {
    let $cvUri := request:get-parameter("cv", "accessconditions.dda.dk-1.0.0.cv")    
    let $cv := doc(concat("/db/apps/web/transform/landingpage/cv/", $cvUri))
    let $stylesheet := doc("/db/apps/web/transform/landingpage/cv/gc_ddi-cv2html.xslt")    

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
    </parameters>
    return transform:transform($cv, $stylesheet, $params)
};

local:main()

