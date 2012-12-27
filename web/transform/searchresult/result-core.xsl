<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:variable name="labels" select="document('result-labels.xml')"/>

    <xsl:template name="result-core-content">
        <xsl:param name="lang"/>
        <xsl:for-each select="LightXmlObject">
            <div class="result">
                <xsl:variable name="studyId"
                    select="CustomList[@type='StudyUnit']/Custom[@option='id']"/>
                
                <p class="contextlink">
                    <strong>
                        <xsl:variable name="elementType" select="@element"/>
                        <xsl:value-of
                            select="$labels/SearchResultLabels/Singular/Label[@id=$elementType]/LabelText[@xml:lang=$lang]/text()"
                        />: </strong>
                    <xsl:if test="@element!='StudyUnit'">
                        <xsl:variable name="url"
                            select="concat('codebook.xquery?studyid=', $studyId, '#', @id, '.', @version)"/>
                        <a class="contextlink" href="{$url}">
                            <xsl:value-of select="Label"/>
                        </a>
                    </xsl:if>
                    <xsl:if test="@element='StudyUnit'">
                        <xsl:variable name="url"
                            select="concat('landingpage.xquery?studyid=', $studyId)"/>
                        <a class="contextlink" href="{$url}">
                            <xsl:value-of select="Label"/>
                        </a>
                    </xsl:if>
                    <em>
                        <xsl:apply-templates select="Context"/>
                    </em>
                </p>

                <xsl:if test="@element!='StudyUnit'">
                    <a href="#" class="referencedElementsTitle">Detaljer</a>
                        <div class="referencedElementsList">
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'QuestionItem'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'MultipleQuestionItem'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'Variable'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'Category'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'Concept'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            <xsl:call-template name="referencedElements">
                                <xsl:with-param name="referencedType" select="'Universe'"/>
                                <xsl:with-param name="studyId" select="$studyId"/>
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                        </div>
                </xsl:if>

                <p class="study">
                    <input type="checkbox" name="studyChosen[]" onchange="toggleSubmitButton()" />
                    <input type="hidden" name="studyId[]" value="{$studyId}" />
                    <xsl:variable name="title"
                        select="CustomList[@type='StudyUnit']/Custom[@option='label']"/>
                    <input type="hidden" name="studyTitle[]" value="{$title}" />
                    <xsl:variable name="url2"
                        select="concat('landingpage.xquery?studyid=', $studyId)"/>
                    <a class="study" href="{$url2}">
                        <xsl:value-of select="$title"/>
                    </a>
                </p>
            </div>
        </xsl:for-each>

    </xsl:template>

    <xsl:template match="Context">
        <xsl:copy-of select="*"/>
    </xsl:template>

    <xsl:template name="referencedElements">
        <xsl:param name="referencedType"/>
        <xsl:param name="studyId"/>
        <xsl:param name="lang"/>
        <xsl:variable name="referencedElements" select="CustomList[@type=$referencedType]"/>
        <xsl:if test="count($referencedElements) &gt; 0">
            <strong>
                <xsl:value-of
                    select="$labels/SearchResultLabels/Plural/Label[@id=$referencedType]/LabelText[@xml:lang=$lang]/text()"
                />
            </strong>
            <ul type="square">
                <xsl:for-each select="$referencedElements">
                    <xsl:variable name="url"
                        select="concat('codebook.xquery?studyid=', $studyId, '#', Custom[@option='id'], '.', Custom[@option='version'])"/>
                    <li>
                        <a class="contextlink" href="{$url}">
                            <xsl:value-of select="Custom[@option='label']"/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>