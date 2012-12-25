<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:smd="http://dda.dk/ddi/search-metadata"
    xmlns:ssp="http://dda.dk/ddi/simple-search-parameters" xmlns:s="http://dda.dk/ddi/scope"
    xmlns:asp="http://dda.dk/ddi/advanced-search-parameters">
    <xsl:template match="ssp:SimpleSearchParameters">
        <div style="margin-left:25px; margin-bottom:20px;">
            <form method="post" action="simple.xquery">
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
                                    <xsl:if
                                        test="(s:Scope/s:StudyUnit) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <span>Studiebeskrivelse</span>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">QuestionItem</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Spørgsmål <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Variable</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:Variable) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Variabler <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Category</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:Category) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Kategorier <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Concept</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:Concept) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Koncepter <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Universe</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:Universe) or (not(ssp:SimpleSearchParameters))">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Universer </td>
                        </tr>
                        <tr>
                            <td> &#160; </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <xsl:variable name="search-string">
                                    <xsl:value-of select="ssp:search-string/text()"/>
                                </xsl:variable>
                                <input class="searchsimpleinput" type="text" name="search-string"
                                    size="80" value="{$search-string}"/>
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

    <xsl:template match="asp:AdvancedSearchParameters">
        <div style="margin-left:25px; margin-bottom:20px;">
            <form method="post" action="advanced.xquery">
                <table id="searchform">
                    <tr>
                        <td colspan="2">
                            <h1 class="search">Avanceret søgning</h1>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">Studieinformation</h2>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Title</td>
                        <td>
                            <input type="text" name="title" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Abstract/Purpose</td>
                        <td>
                            <input type="text" name="abstract-purpose" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Creator</td>
                        <td>
                            <input type="text" name="creator" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Topical Coverage</td>
                        <td>
                            <input type="text" name="topicalCoverage" size="40"/>
                            <!--<input type="checkbox" name="subject" checked="checked" />Subject
            <input type="checkbox" name="subject" checked="keyword" />Keyword-->
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Spatial Coverage</td>
                        <td>
                            <input type="text" name="spatialCoverage" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">KindOfData</td>
                        <td>
                            <input type="text" name="kindOfData" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Temporal Coverage</td>
                        <td>
                            <input type="text" name="coverageFrom" size="17"/>
                            <input type="text" name="coverageTo" size="16"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">Studieinformation på variable niveau</h2>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Question</td>
                        <td>
                            <input type="text" name="QuestionItem" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Variable</td>
                        <td>
                            <input type="text" name="Variable" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Category</td>
                        <td>
                            <input type="text" name="Category" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Concept</td>
                        <td>
                            <input type="text" name="Concept" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Universe</td>
                        <td>
                            <input type="text" name="Universe" size="40"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">Søgeresultat</h2>
                            <input class="searchoption" type="checkbox" name="StudyUnitChecked" checked="checked"/>
                            <span>Studiebeskrivelse</span>
                            <input class="searchoption" type="checkbox" name="QuestionItemChecked" checked="checked"/>
                            Spørgsmål
                            <input class="searchoption" type="checkbox" name="VariableChecked" checked="checked"/>
                            Variabler
                            <input class="searchoption" type="checkbox" name="CategoryChecked" checked="checked"/>
                            Kategorier
                            <input class="searchoption" type="checkbox" name="ConceptChecked" checked="checked"/>
                            Koncepter
                            <input class="searchoption" type="checkbox" name="UniverseChecked" checked="checked"/>
                            Universer
                        </td>
                    </tr>
                    <tr>
                        <td>&#160;</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit"/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>
</xsl:stylesheet>