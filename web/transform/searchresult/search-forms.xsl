<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:smd="http://dda.dk/ddi/search-metadata"
    xmlns:ssp="http://dda.dk/ddi/simple-search-parameters" xmlns:s="http://dda.dk/ddi/scope"
    xmlns:asp="http://dda.dk/ddi/advanced-search-parameters">
    
    <xsl:variable name="labels" select="document('result-labels.xml')/SearchResultLabels/Label"/>
    
    <xsl:template match="ssp:SimpleSearchParameters">
        <xsl:param name="grouped"/>
        <div style="margin-left:25px; margin-bottom:20px;">
            <form id="searchform" method="post" action="simple.xquery">
                <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                    <tbody>
                        <tr>
                            <td valign="top">
                                <h1 class="search">
                                    <xsl:value-of select="$labels[@id='html-search-data']/LabelText[@xml:lang=$lang]/text()"/>
                                </h1>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <strong class="search">
                                    <xsl:value-of select="$labels[@id='html-search-result']/LabelText[@xml:lang=$lang]/text()"/>: </strong>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">StudyUnit</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:StudyUnit">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='study-info']/LabelText[@xml:lang=$lang]/text()"/><xsl:text> </xsl:text>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">QuestionItem</xsl:attribute>
                                    <xsl:if
                                        test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem)">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='QuestionItem']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Variable</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Variable">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='Variable']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Category</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Category">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='Category']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Concept</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Concept">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='Concept']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                                <xsl:element name="input">
                                    <xsl:attribute name="type">checkbox</xsl:attribute>
                                    <xsl:attribute name="class">searchoption</xsl:attribute>
                                    <xsl:attribute name="name">Universe</xsl:attribute>
                                    <xsl:if
                                        test="s:Scope/s:Universe">
                                        <xsl:attribute name="checked">checked</xsl:attribute>
                                    </xsl:if>
                                </xsl:element>
                                <xsl:value-of select="$labels[@id='Universe']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                            </td>
                        </tr>
                        <tr>
                            <td> &#160; </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <input class="searchsimpleinput" type="text" name="search-string"
                                    size="80" value="{ssp:search-string}"/>
                            </td>
                        </tr>
                        <tr>
                            <td> &#160; </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <input type="submit" value="{$labels[@id='html-search']/LabelText[@xml:lang=$lang]/text()}" class="lporderButton lporderText"/>&#160;
                                <input type="button" value="{$labels[@id='html-reset']/LabelText[@xml:lang=$lang]/text()}" class="lporderButton lporderText" onclick="resetForm()"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <xsl:call-template name="construct-hits-perpage">
                                    <xsl:with-param name="hits-perpage" select="smd:SearchMetaData/@hits-perpage"/>
                                    <xsl:with-param name="hit-start" select="smd:SearchMetaData/@hit-start"/>
                                </xsl:call-template>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <xsl:call-template name="construct-grouped">
                                    <xsl:with-param name="grouped" select="$grouped"/>
                                </xsl:call-template>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
    </xsl:template>

    <xsl:template match="asp:AdvancedSearchParameters">
        <xsl:param name="grouped"/>
        <div style="margin-left:25px; margin-bottom:20px;">
            <form id="searchform" method="post" action="advanced.xquery" onsubmit="return validateFields()">
                <table id="searchform">
                    <tr>
                        <td colspan="2">
                            <h1 class="search">
                                <xsl:value-of select="$labels[@id='html-advanced-search']/LabelText[@xml:lang=$lang]/text()"/>:
                            </h1>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">
                                <xsl:value-of select="$labels[@id='study-info']/LabelText[@xml:lang=$lang]/text()"/>
                            </h2>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-study-id']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="studyId" size="40" value="{asp:studyId}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-title']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="title" size="40" value="{asp:title}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-abstract-purpose']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="abstract-purpose" size="40" value="{asp:abstract-purpose}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-creator']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="creator" size="40" value="{asp:creator}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-topical']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="topicalCoverage" size="40" value="{asp:topicalCoverage}"/>
                            <!--<input type="checkbox" name="subject" checked="checked" />Subject
            <input type="checkbox" name="subject" checked="keyword" />Keyword-->
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-spatial']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="spatialCoverage" size="40" value="{asp:spatialCoverage}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-kindofdata']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <input type="text" name="kindOfData" size="40" value="{asp:kindOfData}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='form-temporal']/LabelText[@xml:lang=$lang]/text()"/>
                        </td>
                        <td>
                            <xsl:value-of select="$labels[@id='form-from']/LabelText[@xml:lang=$lang]/text()"/>:
                            <input type="text" name="coverageFrom" size="12" value="{asp:coverageFrom}"/>
                            <xsl:value-of select="$labels[@id='form-to']/LabelText[@xml:lang=$lang]/text()"/>:
                            <input type="text" name="coverageTo" size="12" value="{asp:coverageTo}"/>
                            (<xsl:value-of select="$labels[@id='form-date-format']/LabelText[@xml:lang=$lang]/text()"/>)
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">
                                <xsl:value-of select="$labels[@id='form-variable-level']/LabelText[@xml:lang=$lang]/text()"/>
                            </h2>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='QuestionItem']/LabelText[@xml:lang=$lang]/Singular/text()"/>
                        </td>
                        <td>
                            <input type="text" name="QuestionItem" size="40" value="{asp:QuestionItem}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='Variable']/LabelText[@xml:lang=$lang]/Singular/text()"/>
                        </td>
                        <td>
                            <input type="text" name="Variable" size="40" value="{asp:Variable}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='Category']/LabelText[@xml:lang=$lang]/Singular/text()"/>
                        </td>
                        <td>
                            <input type="text" name="Category" size="40" value="{asp:Category}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='Concept']/LabelText[@xml:lang=$lang]/Singular/text()"/>
                        </td>
                        <td>
                            <input type="text" name="Concept" size="40" value="{asp:Concept}"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="searchadvanced">
                            <xsl:value-of select="$labels[@id='Universe']/LabelText[@xml:lang=$lang]/Singular/text()"/>
                        </td>
                        <td>
                            <input type="text" name="Universe" size="40" value="{asp:Universe}"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <h2 class="search">
                                <xsl:value-of select="$labels[@id='form-include-references']/LabelText[@xml:lang=$lang]/text()"/>
                            </h2>
                            
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">StudyUnitChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:StudyUnit">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='study-info']/LabelText[@xml:lang=$lang]/text()"/><xsl:text> </xsl:text>
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">QuestionItemChecked</xsl:attribute>
                                <xsl:if
                                    test="(s:Scope/s:QuestionItem) or (s:Scope/s:MultipleQuestionItem)">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='QuestionItem']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">VariableChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Variable">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='Variable']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">CategoryChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Category">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='Category']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">ConceptChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Concept">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='Concept']/LabelText[@xml:lang=$lang]/Plural/text()"/><xsl:text> </xsl:text>
                            <xsl:element name="input">
                                <xsl:attribute name="type">checkbox</xsl:attribute>
                                <xsl:attribute name="class">searchoption</xsl:attribute>
                                <xsl:attribute name="name">UniverseChecked</xsl:attribute>
                                <xsl:if
                                    test="s:Scope/s:Universe">
                                    <xsl:attribute name="checked">checked</xsl:attribute>
                                </xsl:if>
                            </xsl:element>
                            <xsl:value-of select="$labels[@id='Universe']/LabelText[@xml:lang=$lang]/Plural/text()"/>
                        </td>
                    </tr>
                    <tr>
                        <td>&#160;</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input type="submit" value="{$labels[@id='html-search']/LabelText[@xml:lang=$lang]/text()}" class="lporderButton lporderText"/>&#160;
                            <input type="button" value="{$labels[@id='html-reset']/LabelText[@xml:lang=$lang]/text()}" class="lporderButton lporderText" onclick="resetForm()"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <xsl:call-template name="construct-hits-perpage">
                                <xsl:with-param name="hits-perpage" select="smd:SearchMetaData/@hits-perpage"/>
                                <xsl:with-param name="hit-start" select="smd:SearchMetaData/@hit-start"/>
                            </xsl:call-template>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" colspan="2">
                            <xsl:call-template name="construct-grouped">
                                <xsl:with-param name="grouped" select="$grouped"/>
                            </xsl:call-template>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </xsl:template>
    
    <xsl:template name="construct-hits-perpage">
        <xsl:param name="hits-perpage"/>
        <xsl:param name="hit-start"/>
        <xsl:value-of select="$labels[@id='html-results-perpage']/LabelText[@xml:lang=$lang]/text()"/>:
        <select name="hits-perpage" onchange="this.form.submit()">
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
            <xsl:element name="option">
                <xsl:attribute name="value">300</xsl:attribute>
                <xsl:if test="$hits-perpage = 300">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                300
            </xsl:element>
            <xsl:element name="option">
                <xsl:attribute name="value">500</xsl:attribute>
                <xsl:if test="$hits-perpage = 500">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                500
            </xsl:element>
        </select>
        <xsl:element name="input">
            <xsl:attribute name="type">hidden</xsl:attribute>
            <xsl:attribute name="name">hit-start</xsl:attribute>
            <xsl:attribute name="value">
                <xsl:value-of select="$hit-start"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="construct-grouped">
        <xsl:param name="grouped"/>
        <xsl:element name="input">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="class">searchoption</xsl:attribute>
            <xsl:attribute name="name">grouped</xsl:attribute>
            <xsl:attribute name="onchange">this.form.submit()</xsl:attribute>
            <xsl:if test="$grouped">
                <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
        </xsl:element>
        <xsl:value-of select="$labels[@id='html-grouping']/LabelText[@xml:lang=$lang]/text()"/>
    </xsl:template>
    
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:variable name="year" select="substring-before($date, '-')"/>
        <xsl:variable name="month" select="substring-before(substring-after($date, '-'), '-')"/>
        <xsl:variable name="day" select="substring-after(substring-after($date, '-'), '-')"/>
        <xsl:value-of select="concat($day, '-', $month, '-', $year)"/>
    </xsl:template>
</xsl:stylesheet>