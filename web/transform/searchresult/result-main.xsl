<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:dl="ddieditor-lightobject">
    <xsl:import href="result-core.xsl"/>
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:param name="lang"/>
    
    <xsl:template match="dl:LightXmlObjectList">
    <!--!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN""http://www.w3.org/TR/html4/loose.dtd"-->
    <html>
        <head>
            <meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
            <link rel="stylesheet" type="text/css" href="theme/style.css" />
            <link rel="stylesheet" type="text/css" href="theme/result.css" />
            <link rel="alternate" type="application/rss+xml" title="Dansk Data Arkiv Nyheder" href="http://samfund.dda.dk/dda/nyheder.xml" />
            <link rel="shortcut icon" href="theme/favicon.ico"/>
            
            <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
            
            <script type="text/javascript">//<![CDATA[
                $(document).ready(function(){
                    $('.result:even').addClass('alternate');
                });
                
                $(function(){
                    // Hide all the elements in the DOM that have a class of "referencedElementsList"
                    $('.referencedElementsList').hide();
                    
                    // Make sure all the elements with a class of "referencedElementsTitle" are visible and bound
                    // with a click event to toggle the "referencedElementsList" state
                    $('.referencedElementsTitle').each(function() {
                        $(this).show(0).on('click', function(e) {
                            // This is only needed if your using an anchor to target the "referencedElementsList" elements
                            //e.preventDefault();
                            
                            // Find the next "referencedElementsList" element in the DOM
                            $(this).next('.referencedElementsList').slideToggle('fast');
                        });
                    });
                });//]]>
            </script>
            
            <!-- todo: abstract -->
            <!--<meta name="description" content="{ns1:Descriptions/ns1:Description[ns1:Type='purpose']/ns1:Content[@xml:lang=$lang]/text()}"/>-->
            <title>
                <!--<xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>-->
                DDI søgning
            </title>
        </head>
        <body>
            <div align="center">
                <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                    <tbody>
                        <tr>
                            <td class="topmenu" valign="top">
                                <div align="center">
                                    <table id="table3" class="greylabel" height="30" border="0" cellpadding="0" cellspacing="0" width="961">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div align="right">
                                                        <table id="table1" height="100%" border="0" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td align="center"> &#160;</td>
                                                                    <td align="center" width="35">&#160;</td>
                                                                    <td align="center">&#160;</td>
                                                                    <td align="center">&#160;</td>
                                                                    <td align="center" width="35">&#160;</td>
                                                                    <td align="center"><a class="navi" target="_blank" href="http://www.sa.dk/">Om Statens Arkiver</a></td>
                                                                    <td align="center" width="35">&#160;</td>
                                                                    <td align="center"><a class="navi" href="http://samfund.dda.dk/dda/om-dda.asp">Om os</a></td>
                                                                    <td align="center" width="35">&#160; </td>
                                                                    <td align="center"><a class="navi" id="kontakt" href="http://samfund.dda.dk/dda/kontakt.asp">Kontakt</a></td>
                                                                    <td width="35">&#160;</td>
                                                                    <td align="center">&#160;</td>
                                                                    <td align="center" width="35">&#160;</td>
                                                                    <td align="center"><a class="navi" id="forside-en" href="http://samfund.dda.dk/dda/default-en.asp">English</a></td>
                                                                    <td align="center" width="20">
                                                                        <p align="center">
                                                                            &#160;
                                                                        </p></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div></td>
                        </tr>
                        <tr>
                            <td class="header" valign="top">
                                <p align="center">
                                    <img src="theme/dda-header-peak-961.jpg" usemap="#Map" height="129" border="0" width="961" />
                                        <map name="Map">
                                            <area shape="rect" coords="24, 11, 221, 121" href="http://samfund.dda.dk/dda/data-forside.asp"/>
                                        </map>
                                </p></td>
                        </tr>
                        <tr>
                            <td class="greylabel" height="30" valign="center">
                                <div align="center">
                                    <!--table border="0" id="table1" cellspacing="0" cellpadding="0" height="24" style="border-collapse: collapse; border-width: 0px" class="greylabel" height="30"-->
                                    <table id="table1" height="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tbody>
                                            <tr>
                                                <td align="center"><a class="navi" href="http://localhost:8080/exist/rest/apps/web/simple.xml">Søg og bestil data</a></td>
                                                <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                                <td style="border-style: none; border-width: medium" align="center"><a class="navi" id="afleveredata" href="http://samfund.dda.dk/dda/data-aflevere.asp"> Aflever data</a></td>
                                                <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                                <td style="border-style: none; border-width: medium" align="center"><a class="navi" href="http://samfund.dda.dk/dda/ddasamfund/om-ddasamfund.asp">DDA Samfund</a></td>
                                                <td style="border-style: none; border-width: medium" align="center" width="35">
                                                    <p align="center">
                                                        &#160;
                                                    </p></td>
                                                <td style="border-style: none; border-width: medium" align="center"><a class="navi" href="http://samfund.dda.dk/dda/ddasundhed/omddasundhed.asp"> DDA Sundhed</a></td>
                                                <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                                <td style="border-style: none; border-width: medium" align="center"><a class="navi" href="http://samfund.dda.dk/dda/internationalt-samarbejde.asp"> Internationalt</a></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div></td>
                        </tr>
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
                                                                            <td><a href="http://localhost:8080/exist/rest/apps/web/simple.xml">Simple søgning</a></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&#160;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#">Hjælp til søgning</a></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&#160;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#">Hjælp til søgeresultat</a></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>&#160;</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><a href="#">Teknisk information</a></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table></td>
                                                        </tr>
                                                    </tbody>
                                                </table></td>
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
                                                                                        <strong class="lp">Søgeresultater</strong>
                                                                                    </td>
                                                                                    <td></td>
                                                                                    <td align="right">
                                                                                        <input type="submit" class="lporderButton lporderText" value="Bestil Data" style="width:90px;" />
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    
                                                                    <div id="resultList">
                                                                        <xsl:call-template name="result-core-content">
                                                                            <xsl:with-param name="lang" select="$lang" />
                                                                        </xsl:call-template>
                                                                    </div>
                                                                    </form>
                                                                    
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div></td>
                                            <!--td class="mainrightborder" valign="top" width="200">
									<table id="table6" class="mainright" width="100%">
									<tbody>
									<tr>
									<td valign="top" width="15">&#160;</td>
									</tr>
									</tbody>
									</table></td-->
                                        </tr>
                                    </tbody>
                                </table></td>
                        </tr>
                        <tr>
                            <td class="bottomspacer" valign="top">&#160;</td>
                        </tr>
                        <tr>
                            <td class="footerframe" valign="top">
                                <div align="center">
                                    <table id="table1" class="greylabel" border="0" cellpadding="0" cellspacing="0" width="961">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <p align="center">
                                                        <font color="#FFFFFF">Dansk Data Arkiv&#160;
                                                            -&#160; Islandsgade 10&#160; -&#160; 5000 Odense C&#160;
                                                            -&#160; Tlf: 66113010&#160; -&#160; Fax: 66113060&#160;
                                                            -&#160; mailbox@dda.dk</font>
                                                    </p></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
