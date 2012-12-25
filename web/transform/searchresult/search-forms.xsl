<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:smd="http://dda.dk/ddi/search-metadata" 
    xmlns:ssp="http://dda.dk/ddi/simple-search-parameters" 
    xmlns:s="http://dda.dk/ddi/scope">
    <xsl:template match="ssp:SimpleSearchParameters">
        <div align="center">
            <form method="post" action="simple-search.xquery">
                <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                    <tbody>
                        <tr>
                            <td valign="top">
                                <h1 class="search">Søg efter data</h1>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <strong class="search">Søgeresultat: </strong>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">StudyUnit</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:StudyUnit) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <span>Studiebeskrivelse</span>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">QuestionItem</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                Spørgsmål
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Variable</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:Variable) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                Variabler
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Category</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:Category) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                Kategorier
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Concept</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:Concept) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                Koncepter
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Universe</xsl:attribute>
                                    <xsl:if test="(s:Scope/s:Universe) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                Universer
                            </td>
                        </tr>
                        <tr>
                            <td> &#160; </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <xsl:variable name="search-string">
                                    <xsl:value-of select="ssp:search-string/text()"/>
                                </xsl:variable>
                                <input class="searchsimpleinput" type="text" name="search-string" size="80" value="{$search-string}" />
                            </td>
                        </tr>
                        <tr>
                            <td> &#160; </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <input type="submit" value="Søg i data"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </xsl:template>
</xsl:stylesheet>