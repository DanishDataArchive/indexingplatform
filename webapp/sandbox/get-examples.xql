xquery version "1.0";
(: $Id: get-examples.xql 10289 2009-10-29 17:55:04Z wolfgang_m $ :)

declare option exist:serialize "media-type=text/xml omit-xml-declaration=yes";

<select id="saved" name="saved">
    <option value=""></option>
    {
    for $entry in collection("/db")//example-queries/query
    return
        <option value="{$entry/code}">{$entry/description}</option>
    }
</select>