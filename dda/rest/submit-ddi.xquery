xquery version "1.0";

import module namespace store = "http://dda.dk/ddi/store" at "xmldb:exist:///db/apps/dda/lib/store.xquery";

declare function local:main() as xs:string? {
    let $ddi := request:get-data()/*
    
    let $result := store:storeDDI($ddi)
    return if ($result/@success eq 'true') then (
        response:set-status-code(201),
        response:set-header('message', $result/message)
    )
    else (
        response:set-status-code(500),
        response:set-header('message', $result/message)
    )
};

local:main()