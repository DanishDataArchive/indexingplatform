xquery version "1.0";

import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/dda-urn/lib/urn.xquery";

declare function local:main() as node()? {    
    if (request:exists()) then
        let $urn := request:get-parameter("urn", "")
        return urn:resolveUrn($urn)
    else
        return
};

local:main()
