xquery version "1.0";

(:~
 : This module contains the functions used to return the context of a match in an element. It is used by the result-functions module.
 : The entry function for this module is <b>context:get-context</b>.
 :)
module namespace context = "http://dda.dk/ddi/context";

import module namespace functx = "http://www.functx.com";

(:~
 : Returns the string which lies between two substrings of a string.
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $text the source string
 : @param   $match1 the first substring
 : @param   $match2 the second
 :)
declare function local:substring-between($text as xs:string, $match1 as xs:string, $match2 as xs:string) as xs:string {
    let $startIndexMatch1 := functx:index-of-string-first($text, $match1)
    let $startIndexMatch2All := functx:index-of-string($text, $match2)
    let $startIndexMatch2 :=
        if ($startIndexMatch1 = $startIndexMatch2All[1]) then
            $startIndexMatch2All[2]
        else
            $startIndexMatch2All[1]
    let $startIndex := $startIndexMatch1 + string-length($match1)
    let $length := $startIndexMatch2 - $startIndex
    return substring($text, $startIndex, $length)(:concat(string($startIndex), ", ", string($length), ", ",  substring($text, $startIndex, $length)):)
};

(:~
 : Truncates a text on the right side so that it fits within a given maximum number of characters and appends "... " before the truncated text
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $text the text which needs to be truncated
 : @param   $max the maximum number of characters returned
 :)
declare function local:truncate-previous($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $startIndex := string-length($text) - $max + 1
        let $stringBefore := substring($text, $startIndex, $max)
        return concat("... ", substring-after($stringBefore, " "))
    else
        $text
};

(:~
 : Truncates a text in the middle so that it fits within a given maximum number of characters and appends " ... " between the two truncated halfs
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $text the text which needs to be truncated
 : @param   $max the maximum number of characters returned
 :)
declare function local:truncate-between($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $stringFirstHalf := substring($text, 0, $max idiv 2)
        let $startIndexSecondHalf := string-length($text) - $max idiv 2 + 1
        let $stringSecondHalf := substring($text, $startIndexSecondHalf, $max)
        return concat(functx:substring-before-last($stringFirstHalf, " "), " ... ", substring-after($stringSecondHalf, " "))
    else
        $text
};

(:~
 : Truncates a text on the left side so that it fits within a given maximum number of characters and appends " ..." after the truncated text
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $text the text which needs to be truncated
 : @param   $max the maximum number of characters returned
 :)
declare function local:truncate-following($text as xs:string, $max as xs:int) as xs:string {
    if (string-length($text) gt $max) then
        let $stringAfter := substring($text, 0, $max)
        return concat(functx:substring-before-last($stringAfter, " "), " ...")
    else
        $text
};

(:~
 : Returns the context of the matches found in the element, and highlights the matches
 :
 : @author  Kemal Pajevic
 : @version 1.0
 : @param   $node the nodes which contains the matches
 : @param   $max the maximum number of characters returned before, between og after matches
 :)
declare function context:get-context($node as element(), $max as xs:int) as element() {
    let $nodeString := normalize-space(string($node))
    let $matches := $node/exist:match
    let $nrOfMatches := count($matches)
    
    return
    <p class="context">
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
                let $substringAfter := functx:substring-after-last($nodeString, string($match))
                return
                if ($substringAfter) then
                    <span class="following">{local:truncate-following($substringAfter, $max)}</span>
                else ()
            else ()
        )
    }
    </p>
};