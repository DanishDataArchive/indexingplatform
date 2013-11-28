<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddi-cv="urn:ddi-cv"
    xmlns:h="http://www.w3.org/1999/xhtml" exclude-result-prefixes="gc h ddi-cv xsi" version="2.0">

    <xsl:output indent="yes" method="html" encoding="UTF-8"/>

    <xsl:param name="prefix" select="''"/>
    <xsl:param name="middlefix" select="'.dda.dk-'"/>
    <xsl:param name="postfix" select="''"/>
    <xsl:param name="extension" select="'cv'"/>
    <xsl:param name="lang" select="'da'"/>
    <xsl:param name="hostname" select="''"/>

    <xsl:variable name="cvlabels" select="document('xmldb:exist:///db/apps/web/transform/landingpage/cv/cv-labels.xml')/*/Label"/>

    <xsl:template match="*">
        <xsl:call-template name="cvToHtml">
            <xsl:with-param name="cvList" select="*"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="cvToHtml">
        <xsl:param name="cvList"/>
        <xsl:for-each select="$cvList/Cv">
            <xsl:variable name="cvName" select="@name"/>
            <xsl:for-each select="Version">
                <xsl:variable name="cvUri"
                    select="concat($prefix, $cvName, $middlefix, $postfix, ., '.', $extension)"/>
                <xsl:variable name="cvDoc" select="document(concat('xmldb:exist:///db/apps/web/transform/landingpage/cv/', $cvUri))"/>
                <p>
                    <strong  class="lp">
                        <xsl:value-of select="$cvDoc/gc:CodeList/Identification/LongName"/>
                    </strong>
                </p>
                <a href="http://{$hostname}/search-technical-information/cv/{$cvUri}">
                    <xsl:value-of
                        select="normalize-space($cvDoc/gc:CodeList/Identification/ShortName)"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="$cvDoc/gc:CodeList/Identification/Version"/>
                </a>
                <p class="lp">
                    <xsl:value-of
                        select="normalize-space($cvDoc/gc:CodeList/Annotation/Description)"/>
                    <br/>
                    <a href="http://{$hostname}/search-technical-information/cv/doc/{$cvUri}">
                        <xsl:value-of select="$cvlabels[@id='doc']/LabelText[@xml:lang=$lang]/text()"/>
                    </a>
                </p>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
