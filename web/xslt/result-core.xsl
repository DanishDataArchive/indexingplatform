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
            <h3>
                <xsl:variable name="url" select="concat('http://dda.dk/landingpage/', CustomList[@type='StudyUnit']/Custom[@option='id'])"/>
                <a href="{$url}"><xsl:value-of select="CustomList[@type='StudyUnit']/Custom[@option='label']"/></a>
            </h3>
            
            <p>
                Fra
                <xsl:call-template name="formatDate">
                    <xsl:with-param name="dateTime" select="CustomList[@type='StudyUnit']/Custom[@option='start']" />
                </xsl:call-template>
                til
                <xsl:call-template name="formatDate">
                    <xsl:with-param name="dateTime" select="CustomList[@type='StudyUnit']/Custom[@option='end']" />
                </xsl:call-template>
            </p>
            
            <p>
                Fundet i <b><xsl:value-of select="@element"/></b>: 
                <i><xsl:value-of select="Label"/></i>
            </p>
            <p>
                <xsl:apply-templates select="Context"/>
            </p>
            <br/>
        </xsl:for-each>			

    </xsl:template>
    
    <xsl:template match="Context">
            <xsl:copy-of select="*" />
    </xsl:template>
    
    <xsl:template name="formatDate">
        <xsl:param name="dateTime" />
        <xsl:variable name="date" select="substring-before($dateTime, 'T')" />
        <xsl:variable name="year" select="substring-before($date, '-')" />
        <xsl:variable name="month" select="substring-before(substring-after($date, '-'), '-')" />
        <xsl:variable name="day" select="substring-after(substring-after($date, '-'), '-')" />
        <xsl:value-of select="concat($day, '.', $month, '.', $year)" />
    </xsl:template>
</xsl:stylesheet>