<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns1="dda.dk/metadata/1.0.0"
    version="1.0">
    <xsl:import href="lp-core.xsl"/>
    <xsl:output method="html" 
        doctype-system="http://www.w3.org/TR/html4/loose.dtd" 
        doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" 
        indent="yes"/>
    <xsl:param name="lang"/>
    
    <xsl:template match="*">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="theme/style.css" />
                <link rel="alternate" type="application/rss+xml" title="Dansk Data Arkiv Nyheder" href="http://samfund.dda.dk/dda/nyheder.xml" />
                <link rel="shortcut icon" href="theme/favicon.ico"/>
                <meta name="description" content="{ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='Abstract']/ns1:Content[@xml:lang=$lang]/text()}"/>
                <title>
                    <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>
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
                                        <img src="theme/dda-header-graph-961.jpg" usemap="#Map" height="129" border="0" width="961" />
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
                                                                                <td><a href="#primaryinvestigator">Primærundersøger</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#documentation">Dokumentation</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#description">Beskrivelse</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#universe">Universe</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#dataset">Datasæt</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#method">Metode</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#citation">Citation</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#status">Adgang</a></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td>&#160;</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td><a href="#metadata">Metadata</a></td>
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
                                                                        <table id="idandorder" border="0" cellpadding="0" cellspacing="0" width="700">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td>																	
                                                                                        <strong class="lp">
                                                                                            <xsl:value-of select="concat('DDA-', substring-after(ns1:StudyIdentifier/ns1:Identifier, 'dda'))"/>
                                                                                        </strong>
                                                                                    </td>
                                                                                    <td></td>
                                                                                    <td align="right"><form action="#"><input type="submit" class="lporderButton lporderText" value="Bestil Data" style="width:90px;" /></form></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>                                                                        
                                                                        <xsl:call-template name="lp-core-content">
                                                                            <xsl:with-param name="lang" select="$lang" />
                                                                        </xsl:call-template>                                                                    
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
