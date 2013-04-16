<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:template name="result-header-top">
        <xsl:param name="lang"/>
        <xsl:param name="hostname"/>
        <xsl:choose>
            <xsl:when test="$lang = 'en'">
                <tr>
                <td valign="top" class="topmenu">
                    <div align="center">
                        <table border="0" width="961" id="table3" cellspacing="0" cellpadding="0" class="greylabel" height="30">
                            <tr>
                                <td>
                                    <div align="right">
                                        <table border="0" id="table1" cellspacing="0" cellpadding="0" height="100%">
                                            <tr>
                                                <td align="center">
                                                    <a class="navi" id="home" href="default-en.asp">Home</a></td>
                                                <td align="center" width="35">&#160;</td>
                                                <td align="center">
                                                    <a class="navi" id="omdda" href="om-dda-en.asp">About DDA</a></td>
                                                <td align="center" width="35">&#160;</td>
                                                <td align="center">
                                                    <a class="navi" id="links" href="links-en.asp">Links</a></td>
                                                <td align="center" width="35">&#160;</td>
                                                <td align="center">
                                                    <a class="navi" id="kontakt" href="kontakt-en.asp">Contact</a></td>
                                                <td width="35"><p align="right">&#160;</p></td>
                                                <td align="center">
                                                    <a class="navi" id="forside" href="data-forside.asp">Dansk</a></td>
                                                <td align="center" width="35">&#160;</td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                </tr>
                <tr>
                    <td valign="top" class="header">
                            <img border="0" src="theme/dda-header-box-961.jpg" width="961" height="129"/></td>
                </tr>
                <tr>
                    <td valign="center" class="greylabel" height="30">
                        <div align="center">
                            <!--<table border="1" id="table1" cellspacing="0" cellpadding="0" height="24" style="border-collapse: collapse; border-width: 0px" class="greylabel" height="30">-->
                            <table border="0" width="" id="table1" cellspacing="0" cellpadding="0" height="24">
                                <tr>
                                    <td align="center">
                                        <a class="navi" id="findedata" href="http://{$hostname}/simple-search">Finding data</a></td>
                                    <td align="center" width="35">&#160;</td>
                                    <td align="center">
                                        <a class="navi" id="bestilledata" href="data-bestille-en.asp">Ordering data</a></td>
                                    <td align="center" width="35">&#160;</td>
                                    <td align="center"><a href="data-aflevere-en.asp" class="navi" id="afleveredata">Submitting data</a></td>
                                    <td align="center" width="35">&#160;</td>
                                    <td align="center"><a href="internationalt-samarbejde-en.asp" class="navi" id="internationalt">International co-operation</a></td>
                                    <td align="center" width="35">&#160;</td>
                                    <td align="center"><a href="forskning-en.asp" class="navi" id="forskning">Research</a></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
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
                                                            <td align="center">
                                                                <a class="navi" target="_blank" href="http://www.sa.dk/">Om Statens Arkiver</a>
                                                            </td>
                                                            <td align="center" width="35">&#160;</td>
                                                            <td align="center">
                                                                <a class="navi" href="http://samfund.dda.dk/dda/om-dda.asp">Om os</a>
                                                            </td>
                                                            <td align="center" width="35">&#160; </td>
                                                            <td align="center">
                                                                <a class="navi" id="kontakt" href="http://samfund.dda.dk/dda/kontakt.asp">Kontakt</a>
                                                            </td>
                                                            <td width="35">&#160;</td>
                                                            <td align="center">&#160;</td>
                                                            <td align="center" width="35">&#160;</td>
                                                            <td align="center">
                                                                <a class="navi" id="forside-en" href="http://samfund.dda.dk/dda/default-en.asp">English</a>
                                                            </td>
                                                            <td align="center" width="20">
                                                                <p align="center">
                                                                    &#160;
                                                                </p>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="header" valign="top">
                        <p align="center">
                            <img src="theme/dda-header-peak-961.jpg" usemap="#Map" height="129" border="0" width="961"/>
                            <map name="Map">
                                <area shape="rect" coords="24, 11, 221, 121" href="http://samfund.dda.dk/dda/data-forside.asp"/>
                            </map>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td class="greylabel" height="30" valign="center">
                        <div align="center">
                            <!--table border="0" id="table1" cellspacing="0" cellpadding="0" height="24" style="border-collapse: collapse; border-width: 0px" class="greylabel" height="30"-->
                            <table id="table1" height="100%" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                    <tr>
                                        <td align="center">
                                            <a class="navi" href="http://{$hostname}/simple-search">Søg og bestil data</a>
                                        </td>
                                        <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                        <td style="border-style: none; border-width: medium" align="center">
                                            <a class="navi" id="afleveredata" href="http://samfund.dda.dk/dda/data-aflevere.asp"> Aflever data</a>
                                        </td>
                                        <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                        <td style="border-style: none; border-width: medium" align="center">
                                            <a class="navi" href="http://samfund.dda.dk/dda/ddasamfund/om-ddasamfund.asp">DDA Samfund</a>
                                        </td>
                                        <td style="border-style: none; border-width: medium" align="center" width="35">
                                            <p align="center">
                                                &#160;
                                            </p>
                                        </td>
                                        <td style="border-style: none; border-width: medium" align="center">
                                            <a class="navi" href="http://samfund.dda.dk/dda/ddasundhed/omddasundhed.asp"> DDA Sundhed</a>
                                        </td>
                                        <td style="border-style: none; border-width: medium" align="center" width="35">&#160;</td>
                                        <td style="border-style: none; border-width: medium" align="center">
                                            <a class="navi" href="http://samfund.dda.dk/dda/internationalt-samarbejde.asp"> Internationalt</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="result-header-leftmenu">
        <xsl:param name="lang"/>
        <xsl:param name="hostname"/>
        <xsl:choose>
            <xsl:when test="$lang = 'en'">
                <td class="mainleftborder" valign="top" width="200">
                    <table id="table5" class="mainleft" width="100%" style="text-align: left">
                        <tbody>
                            <tr>
                                <td valign="top" width="15">&#160;</td>
                                <td valign="top">
                                    <table id="table1" class="subnav" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/simple-search">Simple search</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/advanced-search">Advanced search</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Search help</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Result help</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Technical information</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </xsl:when>
            <xsl:otherwise>
                <td class="mainleftborder" valign="top" width="200">
                    <table id="table5" class="mainleft" width="100%">
                        <tbody>
                            <tr>
                                <td valign="top" width="15">&#160;</td>
                                <td valign="top">
                                    <table id="table1" class="subnav" border="0" cellpadding="0" cellspacing="0" width="100%" style="text-align: left">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/simple-search">Simpel søgning</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/advanced-search">Avanceret søgning</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Hjælp til søgning</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Hjælp til søgeresultat</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="#">Teknisk information</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="result-footer-content">
        <xsl:param name="lang"/>
        <xsl:choose>
            <xsl:when test="$lang = 'en'">
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
                                                <font color="#FFFFFF">Danish Data Archive&#160;
                                                    -&#160; Islandsgade 10&#160; -&#160; 5000 Odense C&#160; -&#160; Denmark&#160;
                                                    -&#160; Phone: +45/66113010&#160; -&#160; Fax: +45/66113060&#160;
                                                    -&#160; mailbox@dda.dk</font>
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </xsl:when>
            <xsl:otherwise>
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
                                            </p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>