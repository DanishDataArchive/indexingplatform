<?xml version="1.0" encoding="UTF-8"?>
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
    <xsl:param name="hostname"/>
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
                <script src="js/input-validation.js" type="text/javascript"></script>
                <title>
                    <xsl:value-of select="$labels[@id='catalogue-title']/LabelText[@xml:lang=$lang]/text()"/>
                </title>
            </head>
            <body>
                <div align="center">
                    <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                        <tbody>
                            <xsl:call-template name="result-header-top">
                                <xsl:with-param name="lang" select="$lang"/>
                                <xsl:with-param name="hostname" select="$hostname"/>
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
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-title']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                    </h1>
                                                                                                    <strong class="lp">
                                                                                                        <xsl:value-of select="$labels[@id='catalogue-study-count']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                        <xsl:value-of select="count(//LightXmlObject)"/>
                                                                                                    </strong>
                                                                                                </td>
                                                                                                <td/>
                                                                                                <td align="right">
                                                                                                    <input name="submit_order" type="button" class="lporderButton lporderText" value="{$labels[@id='html-order-data']/LabelText[@xml:lang=$lang]/text()}" style="width:90px;" disabled="disabled" onclick="createOrderStepUp()"/>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </tbody>
                                                                                    </table>
                                                                                    
                                                                                    <div id="resultList">                                                                                        
                                                                                        <xsl:call-template name="catalogue-core-content">
                                                                                            <xsl:with-param name="type" select="$type"/>
                                                                                            <xsl:with-param name="lang" select="$lang"/>
                                                                                            <xsl:with-param name="hostname" select="$hostname"/>
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