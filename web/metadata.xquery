xquery version "3.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

(: declare option exist:serialize "method=xml media-type=text/xml indent=yes"; :)

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "xml";
declare option output:omit-xml-declaration "no";
declare option output:media-type "text/xml";
declare option output:indent "yes";
declare option output:version "1.0";
        
declare function local:main() as node()? {

    let $study := ddi:getDdiStudy(request:get-parameter("studyid", "0"))
    let $stylesheet := doc("/db/apps/web/transform/metadata/DdiStudyUnit_To_DdaMetadata.xsl")
    let $params := <parameters></parameters>
    return transform:transform($study, $stylesheet, $params)
};

local:main()