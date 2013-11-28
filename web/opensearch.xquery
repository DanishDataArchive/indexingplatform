xquery version "1.0";
(:ddi namespaces:)
declare namespace g = "ddi:group:3_1";
declare namespace dc="ddi:dcelements:3_1";
declare namespace d="ddi:datacollection:3_1"; 
declare namespace dc2="http://purl.org/dc/elements/1.1/"; 
declare namespace s="ddi:studyunit:3_1"; 
declare namespace c="ddi:conceptualcomponent:3_1";
declare namespace r="ddi:reusable:3_1"; 
declare namespace a="ddi:archive:3_1"; 
declare namespace ddi="ddi:instance:3_1"; 
declare namespace l="ddi:logicalproduct:3_1";

declare function local:search($search as xs:string, $collection as xs:string) as node()*
{
    (:todo: implement your search here
    output-format series of:
        <item>
            <title></title>
            <description></description>
            <updated></updated>
            <link></link>
        </item>   
    :)
    if(empty($search)) 
    then
        <empty/>
    else      
        (:find the studies depending on the q-argument:)
        let $result := collection($collection)//s:StudyUnit[.//r:Title[ft:query(., $search)] or .//r:Content[ft:query(., $search)] or .//r:Creator[ft:query(., $search)]]
        return
            for $r in $result
                return
                    <item>
                        <title>{($r/s:StudyUnit/r:Citation/r:Title[@xml:lang = 'en'])/text()}</title>
                        <description>{$r/s:Abstract/r:Content[@xml:lang = 'en']/text()}</description>
                        <updated>{data($r/@versionDate)}</updated>
                        <link>http://snd.gu.se/catalogue/study/{data($r/@id)}</link>
                    </item>
};

declare function local:limitMatches($nodes as node()*, $start as xs:integer, $records as xs:integer) as node()*
{
    let $max := count($nodes)

    let $end :=  min (($start + $records ,$max))
     
    (: restrict the full set of matches to this subsequence :)
    return subsequence($nodes,$start,($end+1))    
};

(:configuration:)
let $documentUrl    := 'http://xml.snd.gu.se/ws/opensearch.xql'
let $arguments      := 'q={searchTerms}&amp;start={startIndex?}&amp;startPage={startPage?}'

let $title          := 'Search result from SND'
let $description    := 'Open search in SND:s collections'
let $mail           := 'olof.olsson@snd.gu.se'
let $baseCollection := '/db/ddi/data/ddi3/'

(:parameters:)
let $q          := request:get-parameter("q", ())
let $start      := xs:integer(request:get-parameter("start", "0"))
let $startPage  := xs:integer(request:get-parameter("startPage", "0"))
let $records    := xs:integer(request:get-parameter("records", "10"))
let $format     := request:get-parameter("format", ())

let $url := fn:concat($documentUrl, '?', $arguments)
let $start :=
    if($startPage > 0)
    then
        $startPage * $records
    else
        $start

(:opensearch template:)
let $opensearch :=
<OpenSearchDescription xmlns="http://a9.com/-/spec/opensearch/1.1/">
   <ShortName>{$title}</ShortName>
   <Description>{$description}</Description>
   <itemsPerPage>{$records}</itemsPerPage>
   <Language>en</Language>
   <Language>sv</Language>
   <Language>*</Language>
   <Tags>example web search</Tags>
   <Contact>{$mail}</Contact>
   <Url type="application/rss+xml" template="{$url}&amp;format=rss"></Url>
   <Url type="application/atom+xml" template="{$url}&amp;format=atom"></Url>
   <Url format="text/html" template="{$url}&amp;format=html" />
</OpenSearchDescription>

(:set the correct header for the requested format:)
let $null := 
    if(empty($q)) 
    then
        util:declare-option("exist:serialize", "method=xml media-type=application/opensearchdescription+xml")
    else if($format = 'rss' or $format = 'atom')
        then
        util:declare-option("exist:serialize", "method=xml media-type=text/xml")
    else
        util:declare-option("exist:serialize", "method=html media-type=text/html")        
        
let $result := local:search($q, $baseCollection)

let $matches :=
    if(empty($q))
    then
        <empty/>
    else
        local:limitMatches($result, $start, $records)

return
    if(empty($q)) 
    then
        $opensearch
    else
        if($format = 'atom')
        then
            <feed xmlns="http://www.w3.org/2005/Atom" xmlns:os="http://a9.com/-/spec/opensearch/1.1/">
               <id>123456789</id>
               <title>{$title}</title>
               <link rel="self" type="application/atom+xml"
                     href="{$url}"/>
               <link rel="alternate" type="text/html"
                     href="http://search.xml.com/?q=atom+store+python&amp;p="/>
               <link rel="search" type="application/opensearchdescription+xml"
                     href="http://example.com/opensearchdescription.xml"/>
               <os:totalResults>{count($result)}</os:totalResults>
               <os:startIndex>{$start}</os:startIndex>
               <os:itemsPerPage>{$records}</os:itemsPerPage>
               <os:Query role="request" searchTerms="{$q}" startIndex="{$start}"/>
               <updated>{current-dateTime()}</updated>
               <author>
                 <name>example open search</name>
                 <email>{$mail}</email>
               </author>
               <rights>LGPL</rights>
               {   (:render search results :)
                   for $s in $matches
                    return 
                        <entry>
                            <title>{$s/title/text()}</title>
                            <link href="{$s/link/text()}"/>
                            <updated>{$s/updated}</updated>
                            <content type="text">
                                {$s/description/text()}
                            </content>
                        </entry>
               }
            </feed>
        else if($format = 'rss') 
            then
            <rss version="2.0" xmlns:openSearch="http://a9.com/-/spec/opensearch/1.1/">
                <channel>
                    <title>{$title}</title>
                    <link>{$url}&amp;format=rss</link>
                    <description>{$description}</description>
                    <openSearch:totalResults>{count($result)}</openSearch:totalResults>
                    <openSearch:startIndex>{$start}</openSearch:startIndex>
                    <openSearch:itemsPerPage>{$records}</openSearch:itemsPerPage>
                    <openSearch:Query role="request" searchTerms="{$q}" />
                    {(:render search results :)
                       for $s in $matches
                        return 
                            <item>
                                <title>{$s/title/text()}</title>
                                <link>{$s/link/text()}</link>
                                <updated>{$s/updated/text()}</updated>
                                <description>
                                     {$s/description/text()}
                                </description>
                            </item>
                   }
                </channel>
            </rss> 
            else
                <html>
                    <head>
                        <title>{$title}</title>                 
                    </head>
                    <body>
                        <ul>
                        {(:render search results :)
                           for $s in $matches
                            return 
                                <li>
                                    <h5>{$s/title}</h5>
                                    <em>{$s/updated}</em>
                                    <p>
                                        {$s/description}
                                    </p>
                                </li>
                        }
                        </ul>
                    </body>
                </html>
            
