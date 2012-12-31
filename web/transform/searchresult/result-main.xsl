<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dl="ddieditor-lightobject"
    xmlns:ssp="http://dda.dk/ddi/simple-search-parameters"
    xmlns:asp="http://dda.dk/ddi/advanced-search-parameters"
    xmlns:rmd="http://dda.dk/ddi/result-metadata"
    version="1.0">
    <xsl:import href="search-forms.xsl"/>
    <xsl:import href="result-html-fragments.xsl"/>
    <xsl:import href="result-core.xsl"/>
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" indent="yes"/>
    <xsl:param name="type"/>
    <xsl:param name="grouped"/>
    <xsl:param name="lang"/>
    <xsl:variable name="labels" select="document('result-labels.xml')/SearchResultLabels/Label"/>
    
    <xsl:template match="dl:LightXmlObjectList">
        <html>
            <head>
                <meta http-equiv="Content-type" content="text/html;charset=UTF-8"/>
                <link rel="stylesheet" type="text/css" href="theme/style.css"/>
                <link rel="stylesheet" type="text/css" href="theme/result.css"/>
                <link rel="alternate" type="application/rss+xml" title="Dansk Data Arkiv Nyheder" href="http://samfund.dda.dk/dda/nyheder.xml"/>
                <link rel="shortcut icon" href="theme/favicon.ico"/>
                
                <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
                <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
                <script type="text/javascript">
                    var lang = '<xsl:value-of select="$lang"/>';
                </script>
                <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
                <script src="js/search-result.js" type="text/javascript"></script>
                <title>
                    <xsl:value-of select="$labels[@id='html-title']/LabelText[@xml:lang=$lang]/text()"/>
                </title>
            </head>
            <body>
                <div align="center">
                    <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                        <tbody>
                            <xsl:call-template name="result-header-top">
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <tr>
                                <td mainframe="" valign="top">
                                    <table id="table2" class="main" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <xsl:call-template name="result-header-leftmenu">
                                                    <xsl:with-param name="lang" select="$lang"/>
                                                </xsl:call-template>
                                                <td valign="top" width="580">
                                                    <xsl:choose>
                                                        <xsl:when test="$type='advanced'">
                                                            <xsl:apply-templates select="asp:AdvancedSearchParameters">
                                                                <xsl:with-param name="grouped" select="$grouped"/>
                                                            </xsl:apply-templates>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:apply-templates select="ssp:SimpleSearchParameters">
                                                                <xsl:with-param name="grouped" select="$grouped"/>
                                                            </xsl:apply-templates>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    
                                                    <div align="center">
                                                        <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                                                        <!--org width 530 -->
                                                            <tbody>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <form method="post" name="order" action="order.html" target="_blank">
                                                                            <xsl:if test="rmd:ResultMetaData/@result-count &gt; 0">
                                                                            <table id="idandorder" border="0" cellpadding="0" cellspacing="0" width="700">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <strong class="lp">
                                                                                                <xsl:value-of select="$labels[@id='html-search-results']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                            </strong>
                                                                                        </td>
                                                                                        <td/>
                                                                                        <td align="right">
                                                                                            <input name="submit_order" type="button" class="lporderButton lporderText" value="{$labels[@id='html-order-data']/LabelText[@xml:lang=$lang]/text()}" style="width:90px;" disabled="disabled" onclick="createOrder()"/>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                                <p>
                                                                                    <xsl:value-of select="$labels[@id='html-showing-results']/LabelText[@xml:lang=$lang]/text()"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="rmd:ResultMetaData/@hit-start"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="$labels[@id='html-to']/LabelText[@xml:lang=$lang]/text()"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="rmd:ResultMetaData/@hit-end"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="$labels[@id='html-of']/LabelText[@xml:lang=$lang]/text()"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="rmd:ResultMetaData/@result-count"/><xsl:text> </xsl:text>
                                                                                    <xsl:value-of select="$labels[@id='html-total']/LabelText[@xml:lang=$lang]/text()"/>.
                                                                                </p>
                                                                            <div id="resultList">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$grouped">
                                                                                        <xsl:call-template name="result-core-content-grouped">
                                                                                            <xsl:with-param name="lang" select="$lang"/>
                                                                                        </xsl:call-template>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:call-template name="result-core-content">
                                                                                            <xsl:with-param name="lang" select="$lang"/>
                                                                                        </xsl:call-template>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </div>
                                                                            <p align="center">
                                                                                <xsl:variable name="prevHitStart" select="rmd:ResultMetaData/@hit-start - rmd:ResultMetaData/@hits-perpage"/>
                                                                                <xsl:if test="rmd:ResultMetaData/@current-page &gt; 1">
                                                                                    <a href="#" onclick="changeHitStart({$prevHitStart})">
                                                                                        <xsl:value-of select="$labels[@id='html-prev']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </xsl:if>
                                                                                &#160;
                                                                                
                                                                                <xsl:variable name="nextHitStart" select="rmd:ResultMetaData/@hit-start + rmd:ResultMetaData/@hits-perpage"/>
                                                                                <xsl:if test="rmd:ResultMetaData/@current-page &lt; rmd:ResultMetaData/@number-of-pages">
                                                                                    <a href="#" onclick="changeHitStart({$nextHitStart})">
                                                                                        <xsl:value-of select="$labels[@id='html-next']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </xsl:if>
                                                                            </p>
                                                                            </xsl:if>
                                                                        </form>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            <!--td class="mainrightborder" valign="top" width="200">
									<table id="table6" class="mainright" width="100%">
									<tbody>
									<tr>
									<td valign="top" width="15"> </td>
									</tr>
									</tbody>
									</table></td-->
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            
                            <xsl:call-template name="result-footer-content">
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="for.loop">
        <xsl:param name="i"/>
        <xsl:param name="count"/>
        
        <!--begin_: Line_by_Line_Output -->
        <xsl:if test="$i &lt;= $count">
            <b><xsl:value-of select="$i" />.</b>Hello world!
        </xsl:if>
        
        <!--begin_: RepeatTheLoopUntilFinished-->
        <xsl:if test="$i &lt;= $count">
            <xsl:call-template name="for.loop">
                <xsl:with-param name="i">
                    <xsl:value-of select="$i + 1"/>
                </xsl:with-param>
                <xsl:with-param name="count">
                    <xsl:value-of select="$count"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        
    </xsl:template>
</xsl:stylesheet>