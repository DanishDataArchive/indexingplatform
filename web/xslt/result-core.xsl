<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:rmd="http://dda.dk/ddi/result-metadata" exclude-result-prefixes="rmd">
    
    <xsl:template name="result-core-content">
     <xsl:param name="lang" />
        <p>
            Viser resultater
            <xsl:value-of select="rmd:ResultMetaData/@hit-start"/>
            til
            <xsl:value-of select="rmd:ResultMetaData/@hit-end"/>
            af
            <xsl:value-of select="rmd:ResultMetaData/@result-count"/>
            i alt.
        </p>
        
        <xsl:for-each select="LightXmlObject">
            <p>
                <xsl:apply-templates select="Context"/>
            </p>
        </xsl:for-each>			

    </xsl:template>
    
    <xsl:template match="Context">
            <xsl:copy-of select="*" />
    </xsl:template>
</xsl:stylesheet>
