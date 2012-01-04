xquery version "1.0";

import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/dda-urn/lib/urn.xquery";

declare function local:main() as node()? {
    session:create(),
    let $urn := session:get-attribute("urn")
    return urn:resolveUrn($urn)
};

local:main()