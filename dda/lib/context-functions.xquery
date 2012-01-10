import module namespace functx = "http://www.functx.com";

declare function local:substring-between($text as xs:string, $match1 as xs:string, $match2 as xs:string) as xs:string {
    let $startIndex := functx:index-of-string-first($text, $match1) + string-length($match1)
    let $length := functx:index-of-string-first($text, $match2) - $startIndex
    return substring($text, $startIndex, $length)
};

declare function local:truncate-previous($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $startIndex := string-length($text) - $max + 1
        let $stringBefore := substring($text, $startIndex, $max)
        return concat("... ", substring-after($stringBefore, " "))
    else
        $text
};

declare function local:truncate-between($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $stringFirstHalf := substring($text, 0, $max idiv 2)
        let $startIndexSecondHalf := string-length($text) - $max idiv 2 + 1
        let $stringSecondHalf := substring($text, $startIndexSecondHalf, $max)
        return concat(functx:substring-before-last($stringFirstHalf, " "), " ... ", substring-after($stringSecondHalf, " "))
    else
        $text
};

declare function local:truncate-following($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $stringAfter := substring($text, 0, $max)
        return concat(functx:substring-before-last($stringAfter, " "), " ...")
    else
        $text
};

declare function local:get-context($node as element(), $max as xs:int) as element() {
    let $nodeString := normalize-space(string($node))
    let $matches := $node/exist:match
    let $nrOfMatches := count($matches)
    
    return
    <p>
    {
    for $match at $pos in $matches
        return
        (
            (: If we are at the first match we just return the text before it, if there is any :)
            if ($pos = 1) then
                let $substringBefore := substring-before($nodeString, string($match))
                return
                if ($substringBefore) then
                    <span class="previous">{local:truncate-previous($substringBefore, $max)}</span>
                else ()
            (: Otherwise, it means that there are more then one match and that we are on at least the second :)
            (: In that case we will return the text between this match and the previous one, if there is any :)
            else
                let $substringBetween := local:substring-between($nodeString, string($matches[($pos - 1)]), string($match))
                return
                if ($substringBetween) then
                    <span class="between">{local:truncate-between($substringBetween, $max)}</span>
                else (),
            
            (: For every match, regardless of any surrounding text, we will return the text from the match :)
            <span class="hi">{string($match)}</span>,
            
            (: Finally, if we are at the last match we will return the text after it, if there is any :)
            if($pos = $nrOfMatches) then
                let $substringAfter := substring-after($nodeString, string($match))
                return
                if ($substringAfter) then
                    <span class="following">{local:truncate-following($substringAfter, $max)}</span>
                else ()
            else ()
        )
    }
    </p>
};
            
let $node := <Creator xmlns="ddi:reusable:3_1" translated="false" translatable="true" xml:lang="da">text1 <exist:match xmlns:exist="http://exist.sourceforge.net/NS/exist">match1</exist:match> text2 <exist:match xmlns:exist="http://exist.sourceforge.net/NS/exist">match2</exist:match> text3 <exist:match xmlns:exist="http://exist.sourceforge.net/NS/exist">match3</exist:match> text4
            </Creator>
let $node1 := <Creator xmlns="ddi:reusable:3_1" translated="false" translatable="true" xml:lang="da">text1 <exist:match xmlns:exist="http://exist.sourceforge.net/NS/exist">match1</exist:match> text2</Creator>

return local:get-context($node, 50)
(:return local:truncate-following("There are various keywords in the order by clause that give you finer", 50):)