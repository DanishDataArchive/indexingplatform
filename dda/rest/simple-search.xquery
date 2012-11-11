xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare function local:main() as node()? {
    let $search-parameters := request:get-data()/*
    return ddi:simpleSearch($search-parameters)
};

local:main()