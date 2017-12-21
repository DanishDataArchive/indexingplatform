<xsl:stylesheet xmlns:dl="ddieditor-lightobject" xmlns:rmd="http://dda.dk/ddi/result-metadata" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ssp="http://dda.dk/ddi/simple-search-parameters" xmlns:asp="http://dda.dk/ddi/advanced-search-parameters" version="2.0">
    <xsl:import href="search-forms.xsl"/>
    <xsl:import href="@UI-BRANDING-RESULT@"/>
    <xsl:import href="result-core.xsl"/>
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" indent="yes"/>
    <xsl:param name="type"/>
    <xsl:param name="grouped"/>
    <xsl:param name="lang"/>
    <xsl:param name="hostname"/>
    <xsl:param name="catalogueType"/>
    <xsl:variable name="labels" select="document('result-labels.xml')/SearchResultLabels/Label"/>
    <xsl:variable name="cataloguePath">
        <xsl:choose>
            <xsl:when test="$catalogueType = 'series'">/catalogue-series/</xsl:when>
            <xsl:otherwise>/catalogue/</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="dl:LightXmlObjectList">
        <html>
            <head>
                <meta http-equiv="Content-type" content="text/html;charset=UTF-8"/>
                <link rel="stylesheet" type="text/css" href="/theme/style.css"/>
                <link rel="stylesheet" type="text/css" href="/theme/result.css"/>
                <link rel="shortcut icon" href="/theme/favicon.ico"/>
                <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"/>
                <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"/>
                <script type="text/javascript">
                    var lang = '<xsl:value-of select="$lang"/>'; 
                    function changeLang(newLang) {
                    path = window.location.pathname.replace( new RegExp("catalogue/", "g"), "catalogue");
                    current = 'http://' + window.location.hostname + path;
                    window.location.replace(current + '?lang=' +newLang);
                    }
                </script>
                <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css"/>
                <script src="/js/search-result.js" type="text/javascript"/>
                <script src="/js/input-validation.js" type="text/javascript"/>
                <script type="text/javascript">
                    @WEB-SITE-TRACKING@
                </script>
                <title>
                    <xsl:choose>
                        <xsl:when test="$catalogueType = 'series'">
                            <xsl:value-of select="$labels[@id='catalogue-series-title']/LabelText[@xml:lang=$lang]/text()"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$labels[@id='catalogue-title']/LabelText[@xml:lang=$lang]/text()"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
            </head>
            <body>
                <div align="center">
                    <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                        <tbody>
                            <xsl:call-template name="result-header-top">
                                <xsl:with-param name="lang" select="$lang"/>
                                <xsl:with-param name="hostname" select="$hostname"/>
                                <xsl:with-param name="img" select="'digits'"/>
                            </xsl:call-template>
                            <tr>
                                <td mainframe="" valign="top">
                                    <table id="table2" class="main" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <xsl:call-template name="result-header-leftmenu">
                                                    <xsl:with-param name="lang" select="$lang"/>
                                                    <xsl:with-param name="hostname" select="$hostname"/>
                                                </xsl:call-template>
                                                <td valign="top" width="580">
                                                    <div align="center">
                                                        <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                                                            <!--org width 530 -->
                                                            <tbody>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <form method="post" name="order" action="order.html" target="_blank">
                                                                            <table id="idandorder" border="0" cellpadding="0" cellspacing="0" width="700">
                                                                                <tbody>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <h1 class="lp">
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="$catalogueType = 'series'">
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-series-title']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-title']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:otherwise>
                                                                                                </xsl:choose>
                                                                                            </h1>
                                                                                            <strong class="lp">
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="$catalogueType = 'series'">
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-series-count']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-study-count']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:otherwise>
                                                                                                </xsl:choose>
                                                                                                <xsl:value-of select="count(//LightXmlObject)"/>
                                                                                            </strong>
                                                                                        </td>
                                                                                        <td/>
                                                                                        <td style="text-align:right">
                                                                                            <xsl:variable name="orderButtonLabel">
                                                                                                <xsl:choose>
                                                                                                    <xsl:when test="$catalogueType = 'series'">
                                                                                                        <xsl:value-of select="$labels[@id='html-order-series']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:when>
                                                                                                    <xsl:otherwise>
                                                                                                        <xsl:value-of select="$labels[@id='html-order-data']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </xsl:otherwise>
                                                                                                </xsl:choose>
                                                                                            </xsl:variable>
                                                                                            <input name="submit_order" type="button" class="lporderButton lporderText" value="{$orderButtonLabel}" style="width:90px;" disabled="disabled" onclick="createOrderStepUp()"/>
                                                                                        </td>
                                                                                    </tr>
                                                                                </tbody>
                                                                            </table>
                                                                            <div id="resultList">
                                                                                <xsl:call-template name="catalogue-core-content">
                                                                                    <xsl:with-param name="type" select="$type"/>
                                                                                    <xsl:with-param name="lang" select="$lang"/>
                                                                                    <xsl:with-param name="hostname" select="$hostname"/>
                                                                                    <xsl:with-param name="cataloguePath" select="$cataloguePath"/>
                                                                                </xsl:call-template>
                                                                            </div>
                                                                            <div align="right">
                                                                                <a href="#">
                                                                                    <xsl:value-of select="$labels[@id='html-to-top']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                </a>
                                                                            </div>
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
</xsl:stylesheet>