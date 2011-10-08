<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: minimal-fix-conf.xsl 5616 2007-04-07 13:19:18Z dizzzz $ -->
<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml"/>

<xsl:template match="cluster/@journalDir">
<xsl:attribute name="journalDir"><xsl:value-of select="substring-after(.,'webapp/WEB-INF/')"/></xsl:attribute>
</xsl:template>

<xsl:template match="db-connection/@files">
<xsl:attribute name="files"><xsl:value-of select="substring-after(.,'webapp/WEB-INF/')"/></xsl:attribute>
</xsl:template>

<xsl:template match="recovery/@journal-dir">
<xsl:attribute name="journal-dir"><xsl:value-of select="substring-after(.,'webapp/WEB-INF/')"/></xsl:attribute>
</xsl:template>

<xsl:template match="catalog/@file">
<xsl:attribute name="file"><xsl:value-of select="substring-after(.,'webapp/WEB-INF/')"/></xsl:attribute>
</xsl:template>

<xsl:template match="*|@*">
  <xsl:copy>
  <xsl:apply-templates select="@*|node()|comment()"/>
  </xsl:copy>
</xsl:template>

</xsl:transform>
