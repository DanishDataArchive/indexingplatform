xquery version "3.0";

import module namespace urn = "http://dda.dk/ddi/urn" at "xmldb:exist:///db/apps/dda-urn/lib/urn.xquery";

declare option exist:serialize "method=html media-type=text/xml omit-xml-declaration=no indent=yes";

declare function local:main() as item()? {
   if (request:get-parameter("urn", ())) then
       let $urn := request:get-parameter("urn", ())
       return urn:resolveUrn($urn)
   else
   (
       response:set-status-code(404),
       "error"
   )

};

local:main()