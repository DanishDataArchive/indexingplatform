<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns1="dda.dk/metadata/1.0.0" version="1.0">
    <xsl:import href="lp-core.xsl"/>
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" indent="yes"/>
    <xsl:param name="lang" select="'da'"/>
    <xsl:param name="previousVersions"/>
    <xsl:param name="cvFolder" select="'cv'"/>
    <xsl:param name="hostname" select="'http://localhost'"/>
    
    <xsl:template match="*">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="style.css"/>                
                <title>
                    <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>
                </title>
            </head>
            <body>                
                <xsl:call-template name="lp-core-content">
                    <xsl:with-param name="lang" select="$lang"/>
                    <xsl:with-param name="previousVersions" select="$previousVersions"/>
                    <xsl:with-param name="cvFolder" select="$cvFolder"/>
                    <xsl:with-param name="hostname" select="$hostname"/>
                </xsl:call-template>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>