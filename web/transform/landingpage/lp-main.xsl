<xsl:stylesheet xmlns:ns1="dda.dk/metadata/1.0.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="lp-core.xsl"/>
    <xsl:import href="lp-core-series.xsl"/>
    <xsl:import href="../searchresult/result-html-fragments-default.xsl"/>
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" indent="yes"/>
    <xsl:param name="lang"/>
    <xsl:param name="previousVersions"/>
    <xsl:param name="cvFolder"/>
    <xsl:param name="hostname"/>
    <xsl:param name="type"/>
    <xsl:variable name="labels" select="document('lp-labels.xml')"/>
    <xsl:template match="*">
        <xsl:variable name="studyId" select="ns1:StudyIdentifier/ns1:Identifier"/>
        <xsl:variable name="studyDdiId" select="substring-after(ns1:StudyIdentifier/ns1:Identifier/text(), 'DDA-')"/>
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="theme/style.css"/>
                <link rel="alternate" type="application/rss+xml" title="Dansk Data Arkiv Nyheder" href="http://samfund.dda.dk/dda/nyheder.xml"/>
                <link rel="shortcut icon" href="theme/favicon.ico"/>
                <link rel="meta" type="application/x-ddi-l+xml" href="http://{$hostname}/urn-resolution/ddi-3.1?urn=urn:ddi:dk.dda:{$studyDdiId}:{ns1:StudyIdentifier/ns1:CurrentVersion}"/>
                <link rel="meta" type="application/x-ddametadata+xml" href="/catalogue/{$studyDdiId}/doc/ddastudymetadata"/>
                <meta name="description" content="{ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='Abstract']/ns1:Content[@xml:lang=$lang]/text()}"/>
                <title>
                    <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>
                </title>
                <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"/>
                <script src="js/order-lp.js" type="text/javascript"/>
                <script src="js/cvi_busy_lib.js" type="text/javascript"/>
                <xsl:comment>[if IE]<![CDATA[>]]>&lt;script type="text/javascript" src="js/json2.js"&gt;&lt;/script&gt;<![CDATA[<![endif]]]></xsl:comment>
                <script type="text/javascript">
                    function changeLang(newLang) {
                    current = 'http://' + window.location.hostname + window.location.pathname;
                    window.location.replace(current + '?lang=' +newLang);                
                    }
                    var busy;                
                    function makebusy(element) {
                    try {busy.remove(); busy='';}catch(e) {busy=getBusyOverlay(element,{color:'#f5f5f5', opacity:0.25},{color:'#000000', size:45, type:'o'});}
                    }
                </script>
                <script type="text/javascript">
                    @WEB-SITE-TRACKING@
                </script>
            </head>
            <body>
                <div align="center">
                    <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                        <tbody>
                            <xsl:call-template name="result-header-top">
                                <xsl:with-param name="lang" select="$lang"/>
                                <xsl:with-param name="hostname" select="$hostname"/>
                                <xsl:with-param name="img" select="'graph'"/>
                            </xsl:call-template>
                            <tr>
                                <td mainframe="" valign="top">
                                    <table id="table2" class="main" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <td class="mainleftborder" valign="top" width="200">
                                                    <table id="table5" class="mainleft" width="100%">
                                                        <tbody>
                                                            <tr>
                                                                <td valign="top" width="15">&#160;</td>
                                                                <td valign="top">
                                                                    <table id="table1" class="subnav" border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tbody>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="http://{$hostname}/simple-search?lang={$lang}">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='newsearch']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#primaryinvestigator">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='principalinvestigator']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#documentation">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='documentation']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#description">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='description']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#universe">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='universe']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#dataset">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='dataset']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#method">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='method']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#citation">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='citation']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#status">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='access']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#metadata">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='metadata']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>
                                                                                    <a href="#publications">
                                                                                        <xsl:value-of select="$labels/LandingPageLabels/Label[@id='publications']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                    </a>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td valign="top" width="580">
                                                    <div align="center">
                                                        <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                                                            <!--org width 530 -->
                                                            <tbody>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <table id="idandorder" border="0" cellpadding="0" cellspacing="0" width="700">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>
                                                                                        <xsl:if test="not($type = 'series')">
                                                                                            <strong class="lp">
                                                                                                <xsl:value-of select="concat('DDA-', substring-after(ns1:StudyIdentifier/ns1:Identifier, 'DDA-'))"/>
                                                                                            </strong>
                                                                                        </xsl:if>
                                                                                    </td>
                                                                                    <td/>
                                                                                    <td style="text-align:right">
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="$type = 'series'">
                                                                                                <xsl:variable name="orderdata" select="$labels/LandingPageLabels/Label[@id='orderseries']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                <form method="post" name="order" action="order.html" target="_blank">
                                                                                                    <input name="submit_order" type="button" class="lporderButton lporderText" value="{$orderdata}" style="width:90px;" onclick="createOrder()"/>
                                                                                                    <xsl:for-each select="ns1:SeriesStudyReferences/ns1:SeriesStudyReference">
                                                                                                        <input type="hidden" name="studyId[]" value="{ns1:StudyIdentifier/ns1:Identifier}"/>
                                                                                                        <input type="hidden" name="studyTitle[]" value="{ns1:Titles/ns1:Title[@xml:lang=$lang]/text()}"/>
                                                                                                    </xsl:for-each>
                                                                                                </form>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <xsl:variable name="orderdata" select="$labels/LandingPageLabels/Label[@id='orderdata']/LabelText[@xml:lang=$lang]/text()"/>
                                                                                                <form method="post" name="order" action="order.html" target="_blank">
                                                                                                    <input name="submit_order" type="button" class="lporderButton lporderText" value="{$orderdata}" style="width:90px;" onclick="createOrder()"/>
                                                                                                    <input type="hidden" name="studyId[]" value="{ns1:StudyIdentifier/ns1:Identifier}"/>
                                                                                                    <input type="hidden" name="studyTitle[]" value="{ns1:Titles/ns1:Title[@xml:lang=$lang]/text()}"/>
                                                                                                </form>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                        <div id="lpcontent">
                                                                            <xsl:choose>
                                                                                <xsl:when test="$type = 'series'">
                                                                                    <xsl:call-template name="lp-core-content-series">
                                                                                        <xsl:with-param name="lang" select="$lang"/>
                                                                                        <xsl:with-param name="previousVersions" select="$previousVersions"/>
                                                                                        <xsl:with-param name="cvFolder" select="$cvFolder"/>
                                                                                        <xsl:with-param name="hostname" select="$hostname"/>
                                                                                    </xsl:call-template>
                                                                                </xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <xsl:call-template name="lp-core-content">
                                                                                        <xsl:with-param name="lang" select="$lang"/>
                                                                                        <xsl:with-param name="previousVersions" select="$previousVersions"/>
                                                                                        <xsl:with-param name="cvFolder" select="$cvFolder"/>
                                                                                        <xsl:with-param name="hostname" select="$hostname"/>
                                                                                    </xsl:call-template>
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
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