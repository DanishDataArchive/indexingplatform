xquery version "1.0";
(: $Id: view-source.xql 6434 2007-08-28 18:59:23Z ellefj $ :)

declare namespace request="http://exist-db.org/xquery/request";

let $source := request:get-parameter("source", ())
return
    transform:transform(doc($source), "xml2html.xslt", ())
