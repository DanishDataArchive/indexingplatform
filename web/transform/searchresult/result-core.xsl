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
            <xsl:variable name="studyId" select="CustomList[@type='StudyUnit']/Custom[@option='id']" />
            <!--p>
                Fra
                <xsl:call-template name="formatDate">
                    <xsl:with-param name="dateTime" select="CustomList[@type='StudyUnit']/Custom[@option='start']" />
                </xsl:call-template>
                til
                <xsl:call-template name="formatDate">
                    <xsl:with-param name="dateTime" select="CustomList[@type='StudyUnit']/Custom[@option='end']" />
                </xsl:call-template>
            </p-->
            <br/>
            <p class="contextlink">               
                
            <strong>
                <xsl:if test="@element = 'StudyUnit'">
                    Studie:
                </xsl:if>
                <xsl:if test="@element = 'QuestionItem' or @element = 'MultipleQuestionItem'">
                    Spørgsmål:
                </xsl:if>
                <xsl:if test="@element = 'Variable'">
                    Variabel:
                </xsl:if>
                <xsl:if test="@element = 'Category'">
                    Kategorie:
                </xsl:if>
                <xsl:if test="@element = 'Concept'">
                    Koncept:
                </xsl:if>
                <xsl:if test="@element = 'Universe'">
                    Univers:
                </xsl:if>
            </strong> 
                <xsl:if test="@element!='StudyUnit'">
                    <xsl:variable name="url" select="concat('codebook.xquery?studyid=', $studyId, '#', @id, '.', @version)"/>
                    <a class="contextlink" href="{$url}"><xsl:value-of select="Label"/></a>
                </xsl:if>
                <xsl:if test="@element='StudyUnit'">
                    <xsl:variable name="url" select="concat('landingpage.xquery?studyid=', $studyId)"/>
                    <a class="contextlink" href="{$url}"><xsl:value-of select="Label"/></a>        
                </xsl:if>
                <em><xsl:apply-templates select="Context"/></em>
            </p>
            <p class="study">
                <xsl:variable name="url2" select="concat('landingpage.xquery?studyid=', $studyId)"/>
                <a class="study" href="{$url2}"><xsl:value-of select="CustomList[@type='StudyUnit']/Custom[@option='label']"/></a>
            </p>
            <br/>
            
            <xsl:variable name="questionItems" select="CustomList[@type='QuestionItem' or @type='MultipleQuestionItem']"/>
            <xsl:if test="count($questionItems) &gt; 0">
                <xsl:call-template name="referencedElements">
                    <xsl:with-param name="title" select="'Spørgsmål'" />
                    <xsl:with-param name="elements" select="$questionItems" />
                    <xsl:with-param name="studyId" select="$studyId" />
                </xsl:call-template>
            </xsl:if>
            <xsl:variable name="variables" select="CustomList[@type='Variable']"/>
            <xsl:if test="count($variables) &gt; 0">
                <xsl:call-template name="referencedElements">
                    <xsl:with-param name="title" select="'Variabler'" />
                    <xsl:with-param name="elements" select="$variables" />
                    <xsl:with-param name="studyId" select="$studyId" />
                </xsl:call-template>
            </xsl:if>
            <xsl:variable name="categories" select="CustomList[@type='Category']"/>
            <xsl:if test="count($categories) &gt; 0">
                <xsl:call-template name="referencedElements">
                    <xsl:with-param name="title" select="'Kategorier'" />
                    <xsl:with-param name="elements" select="$categories" />
                    <xsl:with-param name="studyId" select="$studyId" />
                </xsl:call-template>
            </xsl:if>
            <xsl:variable name="concepts" select="CustomList[@type='Concept']"/>
            <xsl:if test="count($concepts) &gt; 0">
                <xsl:call-template name="referencedElements">
                    <xsl:with-param name="title" select="'Koncepter'" />
                    <xsl:with-param name="elements" select="$concepts" />
                    <xsl:with-param name="studyId" select="$studyId" />
                </xsl:call-template>
            </xsl:if>
            <xsl:variable name="universes" select="CustomList[@type='Universe']"/>
            <xsl:if test="count($universes) &gt; 0">
                <xsl:call-template name="referencedElements">
                    <xsl:with-param name="title" select="'Universer'" />
                    <xsl:with-param name="elements" select="$universes" />
                    <xsl:with-param name="studyId" select="$studyId" />
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>			

    </xsl:template>
    
    <xsl:template match="Context">
            <xsl:copy-of select="*" />
    </xsl:template>
    
    <xsl:template name="referencedElements">
        <xsl:param name="title" />
        <xsl:param name="elements" />
        <xsl:param name="studyId" />
        <a href="#" class="referencedElementsTitle"><xsl:value-of select="$title"/></a>
        <div class="referencedElementsList">
            <ul>
                <xsl:for-each select="$elements">
                    <xsl:variable name="url" select="concat('codebook.xquery?studyid=', $studyId, '#', Custom[@option='id'], '.', Custom[@option='version'])"/>
                    <li><a class="contextlink" href="{$url}"><xsl:value-of select="Custom[@option='label']"/></a></li>
                </xsl:for-each>
            </ul>
        </div>
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