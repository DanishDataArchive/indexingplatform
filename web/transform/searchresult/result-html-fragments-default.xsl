<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:template name="result-header-top">
        <xsl:param name="lang"/>
        <xsl:param name="hostname"/>
        <xsl:param name="img" select="'peak'"/>
        <xsl:choose>
            <xsl:when test="$lang = 'en'">
                <a id="forside"
                    onclick="changeLang('da')"
                    href="javascript:void(0);">Dansk</a>
            </xsl:when>
            <xsl:otherwise>
                <a id="forside-en"
                    onclick="changeLang('en')"
                    href="javascript:void(0);"
                    >English</a>
            </xsl:otherwise>
        </xsl:choose>
        <tr>
            <td class="header" valign="top">
                <p align="center">
                    <img src="/theme/ra-logo-blaa.jpg" usemap="#Map" height="129" border="0" width="961" />
                    <map name="Map">
                        <area shape="rect" coords="24, 11, 221, 121" href="https://www.sa.dk/{$lang}/forskning/for-forskere/" />
                    </map>
                </p>
            </td>
        </tr>
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
                                                    <a href="http://{$hostname}/simple-search?lang={$lang}">Simple search</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/advanced-search?lang={$lang}">Advanced search</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/search-technical-information?lang={$lang}">Technical information</a>
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
                                                    <a href="http://{$hostname}/simple-search?lang={$lang}">Simpel søgning</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/advanced-search?lang={$lang}">Avanceret søgning</a>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&#160;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <a href="http://{$hostname}/search-technical-information?lang={$lang}">Teknisk information</a>
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
            </xsl:when>
            <xsl:otherwise>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
