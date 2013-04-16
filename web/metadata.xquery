xquery version "3.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare option exist:serialize "method=xml media-type=text/xml indent=yes";
        
declare function local:main() as node()? {

    let $study := ddi:getDdiStudy(request:get-parameter("studyid", "0"))
    let $stylesheet := doc("/db/apps/web/transform/metadata/DdiStudyUnit_To_DdaMetadata.xsl")
    let $params := <parameters></parameters>
    return transform:transform($study, $stylesheet, $params)
};

local:main()