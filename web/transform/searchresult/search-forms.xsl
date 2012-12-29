<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:smd="http://dda.dk/ddi/search-metadata"
    xmlns:ssp="http://dda.dk/ddi/simple-search-parameters" xmlns:s="http://dda.dk/ddi/scope"
    xmlns:asp="http://dda.dk/ddi/advanced-search-parameters">
    <xsl:template match="ssp:SimpleSearchParameters">
        <div style="margin-left:25px; margin-bottom:20px;">
            <form id="searchform" method="post" action="simple.xquery">
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
                                        test="s:Scope/s:StudyUnit">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <span>Studiebeskrivelse</span>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">QuestionItem</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem)">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Spørgsmål <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Variable</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Variable">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Variabler <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Category</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Category">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Kategorier <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Concept</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Concept">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element> Koncepter <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Universe</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Universe">
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
                                <input type="submit" value="Søg i data" class="lporderButton lporderText"/>&#160;
                                <input type="button" value="Nulstil" class="lporderButton lporderText" onclick="resetForm()"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Pr. side:
                                <xsl:variable name="hits-perpage" select="smd:SearchMetaData/@hits-perpage"></xsl:variable>
                                <select name="hits-perpage" onchange="this.form.submit()">
                                    <xsl:element name="option">
                                        <xsl:attribute name="value">10</xsl:attribute>
                                        <xsl:if test="$hits-perpage = 10">
                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        10
                                    </xsl:element>
                                    <xsl:element name="option">
                                        <xsl:attribute name="value">25</xsl:attribute>
                                        <xsl:if test="$hits-perpage = 25">
                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        25
                                    </xsl:element>
                                    <xsl:element name="option">
                                        <xsl:attribute name="value">50</xsl:attribute>
                                        <xsl:if test="$hits-perpage = 50">
                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        50
                                    </xsl:element>
                                    <xsl:element name="option">
                                        <xsl:attribute name="value">100</xsl:attribute>
                                        <xsl:if test="$hits-perpage = 100">
                                            <xsl:attribute name="selected">selected</xsl:attribute>
                                        </xsl:if>
                                        100
                                    </xsl:element>
                                </select>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">hidden</xsl:attribute>
                                    <xsl:attribute name="name">hit-start</xsl:attribute>
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="smd:SearchMetaData/@hit-start"/>
                                    </xsl:attribute>
                                </xsl:element>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </xsl:template>

    <xsl:template match="asp:AdvancedSearchParameters">
        <div style="margin-left:25px; margin-bottom:20px;">
            <form id="searchform" method="post" action="advanced.xquery" onsubmit="return validateFields()">
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
                            <xsl:variable name="title">
                                <xsl:value-of select="asp:title/text()"/>
                            </xsl:variable>
                            <input type="text" name="title" size="40" value="{$title}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Abstract/Purpose</td>
                        <td>
                            <xsl:variable name="abstract-purpose">
                                <xsl:value-of select="asp:abstract-purpose/text()"/>
                            </xsl:variable>
                            <input type="text" name="abstract-purpose" size="40" value="{$abstract-purpose}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Creator</td>
                        <td>
                            <xsl:variable name="creator">
                                <xsl:value-of select="asp:creator/text()"/>
                            </xsl:variable>
                            <input type="text" name="creator" size="40" value="{$creator}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Topical Coverage</td>
                        <td>
                            <xsl:variable name="topicalCoverage">
                                <xsl:value-of select="asp:topicalCoverage/text()"/>
                            </xsl:variable>
                            <input type="text" name="topicalCoverage" size="40" value="{$topicalCoverage}"/>
                            <!--<input type="checkbox" name="subject" checked="checked" />Subject
            <input type="checkbox" name="subject" checked="keyword" />Keyword-->
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Spatial Coverage</td>
                        <td>
                            <xsl:variable name="spatialCoverage">
                                <xsl:value-of select="asp:spatialCoverage/text()"/>
                            </xsl:variable>
                            <input type="text" name="spatialCoverage" size="40" value="{$spatialCoverage}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">KindOfData</td>
                        <td>
                            <xsl:variable name="kindOfData">
                                <xsl:value-of select="asp:kindOfData/text()"/>
                            </xsl:variable>
                            <input type="text" name="kindOfData" size="40" value="{$kindOfData}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Temporal Coverage</td>
                        <td>
                            <xsl:variable name="coverageFrom" select="asp:coverageFrom/text()"/>
                            <input type="text" name="coverageFrom" size="17" value="{$coverageFrom}"/>
                            <xsl:variable name="coverageTo" select="asp:coverageTo/text()"/>
                            <input type="text" name="coverageTo" size="17" value="{$coverageTo}"/>
                            (yyyy-mm-dd)
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
                            <xsl:variable name="QuestionItem">
                                <xsl:value-of select="asp:QuestionItem/text()"/>
                            </xsl:variable>
                            <input type="text" name="QuestionItem" size="40" value="{$QuestionItem}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Variable</td>
                        <td>
                            <xsl:variable name="Variable">
                                <xsl:value-of select="asp:Variable/text()"/>
                            </xsl:variable>
                            <input type="text" name="Variable" size="40" value="{$Variable}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Category</td>
                        <td>
                            <xsl:variable name="Category">
                                <xsl:value-of select="asp:Category/text()"/>
                            </xsl:variable>
                            <input type="text" name="Category" size="40" value="{$Category}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Concept</td>
                        <td>
                            <xsl:variable name="Concept">
                                <xsl:value-of select="asp:Concept/text()"/>
                            </xsl:variable>
                            <input type="text" name="Concept" size="40" value="{$Concept}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">Universe</td>
                        <td>
                            <xsl:variable name="Universe">
                                <xsl:value-of select="asp:Universe/text()"/>
                            </xsl:variable>
                            <input type="text" name="Universe" size="40" value="{$Universe}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">Søgeresultat</h2>
                            
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">StudyUnitChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:StudyUnit">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Studiebeskrivelse
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">QuestionItemChecked</xsl:attribute>
                                <xsl:if
                                    test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem)">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Spørgsmål
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">VariableChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Variable">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Variabler
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">CategoryChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Category">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Kategorier
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">ConceptChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Concept">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Koncepter
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">UniverseChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Universe">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            Universer
                        </td>
                    </tr>
                    <tr>
                        <td>&#160;</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="Søg i data" class="lporderButton lporderText"/>&#160;
                            <input type="button" value="Nulstil" class="lporderButton lporderText" onclick="resetForm()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            Pr. side:
                            <xsl:variable name="hits-perpage" select="smd:SearchMetaData/@hits-perpage"></xsl:variable>
                            <select name="hits-perpage" onchange="this.form.submit()">
                                <xsl:element name="option">
                                    <xsl:attribute name="value">10</xsl:attribute>
                                    <xsl:if test="$hits-perpage = 10">
                                        <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:if>
                                    10
                                </xsl:element>
                                <xsl:element name="option">
                                    <xsl:attribute name="value">25</xsl:attribute>
                                    <xsl:if test="$hits-perpage = 25">
                                        <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:if>
                                    25
                                </xsl:element>
                                <xsl:element name="option">
                                    <xsl:attribute name="value">50</xsl:attribute>
                                    <xsl:if test="$hits-perpage = 50">
                                        <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:if>
                                    50
                                </xsl:element>
                                <xsl:element name="option">
                                    <xsl:attribute name="value">100</xsl:attribute>
                                    <xsl:if test="$hits-perpage = 100">
                                        <xsl:attribute name="selected">selected</xsl:attribute>
                                    </xsl:if>
                                    100
                                </xsl:element>
                            </select>
                            <xsl:element name="input">
                                <xsl:attribute name="type">hidden</xsl:attribute>
                                <xsl:attribute name="name">hit-start</xsl:attribute>
                                <xsl:attribute name="value">
                                    <xsl:value-of select="smd:SearchMetaData/@hit-start"/>
                                </xsl:attribute>
                            </xsl:element>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>
    
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:variable name="year" select="substring-before($date, '-')"/>
        <xsl:variable name="month" select="substring-before(substring-after($date, '-'), '-')"/>
        <xsl:variable name="day" select="substring-after(substring-after($date, '-'), '-')"/>
        <xsl:value-of select="concat($day, '-', $month, '-', $year)"/>
    </xsl:template>
</xsl:stylesheet>