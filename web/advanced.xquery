xquery version "1.0";

import module namespace ddi = "http://dda.dk/ddi" at "xmldb:exist:///db/apps/dda/lib/search.xquery";

declare function local:main() as node()? {
    let $search-parameters := request:get-data()/*
    
    let $searchResultsStylesheet := doc("/db/apps/web/transform/searchresult/result-main.xsl")
    
    let $searchResults := ddi:advancedSearch($search-parameters)
    let $params := <parameters>
            <param name="lang" value="da"/>            
        </parameters>
    
    (:return transform:transform($searchResults, $searchResultsStylesheet, $params):)
  
let $parameters :=  request:get-parameter-names()
return
<results>
   <parameters>{$parameters}</parameters>
   {for $parameter in $parameters
   return
   <parameter>
      <name>{$parameter}</name>
      <value>{request:get-parameter($parameter, '')}</value>
   </parameter>
   }
</results>
};

local:main()