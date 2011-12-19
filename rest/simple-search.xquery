xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/dda/lib/search.xquery";

declare namespace ssp="http://dda.dk/ddi/simple-search-parameters";

declare function local:main() as node()? {
    let $simple-search-parameters-wrapped := <ssp:wrapper>{request:get-data()}</ssp:wrapper>      (: this is done because XQuery for some reason does not recognize the data returned by request:get-data() as an instance of element() even if it does contain valid XML :)
    let $simple-search-parameters := $simple-search-parameters-wrapped/ssp:SimpleSearchParameters (: so we create an element() by using an element constructor (i.e. by adding some XML tags) and extract the element afterwards again :)

    return ddi:simpleSearch($simple-search-parameters)
};

local:main()