<xsl:stylesheet xmlns="dda.dk/metadata/1.0.0" xmlns:ddi-cv="urn:ddi-cv" xmlns:dl="ddieditor-lightobject" xmlns:ns0="ddi:group:3_1" xmlns:ns2="ddi:reusable:3_1" xmlns:ns1="ddi:studyunit:3_1" xmlns:ns4="ddi:physicalinstance:3_1" xmlns:ns3="ddi:archive:3_1" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns6="ddi:physicalinstance:3_1" xmlns:ns5="ddi:conceptualcomponent:3_1" xmlns:ns8="ddi:datacollection:3_1" xmlns:ns7="ddi:logicalproduct:3_1" xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" version="2.0" exclude-result-prefixes="ns0 ns1 ns2 ns3 ns4 ns5 ns6 ns7 ns8 gc ddi-cv xhtml">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" omit-xml-declaration="no"/>
    <xsl:param name="hostname" select="'http://dda.dk/catalogue'"/>
    <xsl:template match="@*|comment()|processing-instruction()|text()">
        <xsl:copy/>
    </xsl:template>
    <xsl:template match="*">
        <xsl:apply-templates select="ns0:Group"/>
    </xsl:template>
    <xsl:template match="ns0:Group">
        <Series>
            <xsl:attribute name="xsi:schemaLocation">
                <xsl:text>dda.dk/metadata/1.0.0  file:///home/ddajvj/Documents/DDA/indekseringsplatform-1.1/svn/ddaipf/trunk/web/schemas/MetaDataSchema.xsd</xsl:text>
            </xsl:attribute>
            <StudyIdentifier>
                <Identifier>
                    <xsl:value-of select="concat('DDA-', @id)"/>
                </Identifier>
                <CurrentVersion>
                    <xsl:value-of select="@version"/>
                </CurrentVersion>
            </StudyIdentifier>
            <Titles>
                <xsl:apply-templates select="ns2:Citation/ns2:Title"/>
            </Titles>
            <PrincipalInvestigators>
                <xsl:apply-templates select="ns2:Citation/ns2:Creator"/>
            </PrincipalInvestigators>
            <DataURLs>
                <DataURL>
                    <xsl:value-of select="concat($hostname, '/', @id)"/>
                </DataURL>
            </DataURLs>
            <StudyPublicationDate>
                <xsl:value-of select="substring-before(ns2:Citation/ns2:PublicationDate/ns2:SimpleDate, 'T')"/>
            </StudyPublicationDate>
            <xsl:call-template name="TopicalCoverage"/>
            <xsl:call-template name="StudyDescriptions"/>
            <TemporalCoverages>
                <xsl:apply-templates select="ns2:Coverage/ns2:TemporalCoverage"/>
            </TemporalCoverages>
            <xsl:call-template name="Publications"/>
            <xsl:variable name="archiveOrganizationRef" select="ns3:Archive/ns3:ArchiveSpecific/ns3:ArchiveOrganizationReference/ns2:ID"/>
            <Archive>
                <xsl:value-of select="ns3:Archive/ns3:OrganizationScheme/ns3:Organization[@id=$archiveOrganizationRef]/ns3:OrganizationName"/>
            </Archive>
            <xsl:apply-templates select="ns0:StudyUnit">
                <xsl:with-param name="notes" select="ns2:Note" tunnel="yes"/>
            </xsl:apply-templates>
        </Series>
    </xsl:template>
    <xsl:template match="ns2:Citation/ns2:Creator">
        <PrincipalInvestigator>
            <Person>
                <FirstName>
                    <xsl:value-of select="text()"/>
                </FirstName>
                <xsl:if test="@affiliation">
                    <Affiliation>
                        <AffiliationName>
                            <xsl:value-of select="@affiliation"/>
                        </AffiliationName>
                    </Affiliation>
                </xsl:if>
            </Person>
        </PrincipalInvestigator>
    </xsl:template>
    <xsl:template match="ns2:Citation/ns2:Title">
        <Title>
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="text()"/>
        </Title>
    </xsl:template>
    <xsl:template name="StudyDescriptions">
        <StudyDescriptions>
            <xsl:if test="ns0:Purpose">
                <StudyDescription>
                    <Type>Purpose</Type>
                    <xsl:for-each select="ns0:Purpose">
                        <Content xml:lang="{ns2:Content/@xml:lang}">
                            <xsl:variable name="content">
                                <xsl:value-of select="ns2:Content/xhtml:p"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="$content!=''">
                                    <xsl:copy-of select="ns2:Content//*"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="ns2:Content"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </Content>
                    </xsl:for-each>
                </StudyDescription>
            </xsl:if>
            <xsl:if test="ns0:Abstract">
                <StudyDescription>
                    <Type>Abstract</Type>
                    <xsl:for-each select="ns0:Abstract">
                        <Content xml:lang="{ns2:Content/@xml:lang}">
                            <xsl:variable name="content">
                                <xsl:value-of select="ns2:Content/xhtml:p"/>
                            </xsl:variable>
                            <xsl:choose>
                                <xsl:when test="$content!=''">
                                    <xsl:copy-of select="ns2:Content//*"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="ns2:Content"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </Content>
                    </xsl:for-each>
                </StudyDescription>
            </xsl:if>
        </StudyDescriptions>
    </xsl:template>
    <xsl:template match="ns2:Coverage/ns2:TopicalCoverage/ns2:Subject">
        <!--
            <Subject codeListAgencyName="dda.dk" 
            codeListID="urn:subject.dda.dk" codeListName="" 
            codeListSchemeURN="urn:subject.dda.dk-1.0.0" 
            codeListURN="urn:subject.dda.dk-1.0.0" codeListVersionID="1.0.0" xml:lang="{@xml:lang}">
        -->
        <Subject xml:lang="{@xml:lang}">
            <xsl:value-of select="text()"/>
        </Subject>
    </xsl:template>
    <xsl:template match="ns2:Coverage/ns2:TopicalCoverage/ns2:Keyword">
        <!--
            <Keyword codeListAgencyName="dda.dk" 
            codeListID="urn:keyword.dda.dk" codeListName="" 
            codeListSchemeURN="urn:keyword.dda.dk-1.0.0" 
            codeListURN="urn:keyword.dda.dk-1.0.0" codeListVersionID="1.0.0" xml:lang="{@xml:lang}">
        -->
        <Keyword xml:lang="{@xml:lang}">
            <xsl:value-of select="text()"/>
        </Keyword>
    </xsl:template>
    <xsl:template name="TopicalCoverage">
        <TopicalCoverage>
            <Subjects>
                <xsl:apply-templates select="ns2:Coverage/ns2:TopicalCoverage/ns2:Subject"/>
            </Subjects>
            <Keywords>
                <xsl:apply-templates select="ns2:Coverage/ns2:TopicalCoverage/ns2:Keyword"/>
            </Keywords>
        </TopicalCoverage>
    </xsl:template>
    <xsl:template match="ns2:Coverage/ns2:TemporalCoverage">
        <TemporalCoverage>
            <StartDate>
                <xsl:value-of select="substring-before(ns2:ReferenceDate/ns2:StartDate/text(),'T')"/>
            </StartDate>
            <EndDate>
                <xsl:value-of select="substring-before(ns2:ReferenceDate/ns2:EndDate/text(),'T')"/>
            </EndDate>
            <!-- todo: er dette en acceptabel løsning? Der er kun en overordnet note og ikke en note for både start og end date. -->
            <xsl:variable name="temporalCoverageId" select="@id"/>
            <xsl:if test="//ns2:Note/ns2:Relationship/ns2:RelatedToReference/ns2:ID=$temporalCoverageId">
                <xsl:for-each select="//ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$temporalCoverageId]">
                    <Description xml:lang="{ns2:Content/@xml:lang}">
                        <xsl:value-of select="ns2:Content"/>
                    </Description>
                </xsl:for-each>
            </xsl:if>
        </TemporalCoverage>
    </xsl:template>
    <xsl:template name="Publications">
        <Publications>
            <!-- primary -->
            <xsl:for-each select="ns2:OtherMaterial">
                <xsl:if test="./@type='dk.dda.study.primarypublication'">
                    <xsl:call-template name="Publication">
                        <xsl:with-param name="type" select="'Primary'"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
            <!-- secondary -->
            <xsl:for-each select="ns2:OtherMaterial">
                <xsl:if test="./@type='dk.dda.study.secondarypublication'">
                    <xsl:call-template name="Publication">
                        <xsl:with-param name="type" select="'Secondary'"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:for-each>
        </Publications>
    </xsl:template>
    <xsl:template name="Publication">
        <xsl:param name="type"/>
        <Publication>
            <PublicationType codeListAgencyName="dda.dk" codeListID="urn:dda-cv:studypublication" codeListName="DDAStudyPublication" codeListSchemeURN="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" codeListURN="urn:dda-cv:studypublication:1.0.0" codeListVersionID="1.0.0">
                <xsl:value-of select="$type"/>
            </PublicationType>
            <Authors>
                <Person>
                    <FirstName>
                        <xsl:value-of select="ns2:Citation/ns2:Creator"/>
                    </FirstName>
                </Person>
            </Authors>
            <Titles>
                <xsl:apply-templates select="ns2:Citation/ns2:Title"/>
            </Titles>
            <xsl:if test="ns2:Citation/ns2:PublicationDate/ns2:SimpleDate">
                <Year>
                    <xsl:value-of select="ns2:Citation/ns2:PublicationDate/ns2:SimpleDate"/>
                </Year>
            </xsl:if>
            <xsl:if test="ns2:Citation/ns2:Publisher">
                <Publisher>
                    <xsl:value-of select="ns2:Citation/ns2:Publisher"/>
                </Publisher>
            </xsl:if>
            <!--Location/-->
            <xsl:if test="ns2:Citation/ns2:SubTitle">
                <PublicationReferenceAndPage>
                    <xsl:value-of select="ns2:Citation/ns2:SubTitle"/>
                </PublicationReferenceAndPage>
            </xsl:if>
            <!--PIDs/-->
        </Publication>
    </xsl:template>
    <xsl:template match="ns0:StudyUnit">
        <xsl:param name="notes" tunnel="yes"/>
        <xsl:variable name="studyId" select="ns0:Reference/ns2:ID"/> 
        <SeriesStudyReferences>
            <SeriesStudyReference>
                <Titles>
                    <xsl:apply-templates select="$notes[ns2:Relationship/ns2:RelatedToReference/ns2:ID = $studyId]/ns2:Content"/>
                </Titles>
                <StudyIdentifier>
                    <Identifier>
                        <xsl:value-of select="$studyId"/>
                    </Identifier>
                    <CurrentVersion>
                        <xsl:value-of select="ns0:Reference/ns2:Version/text()"/>
                    </CurrentVersion>
                </StudyIdentifier>
            </SeriesStudyReference>
        </SeriesStudyReferences>
    </xsl:template>
    <xsl:template match="ns2:Note/ns2:Content">
        <Title>
            <xsl:attribute name="xml:lang">
                <xsl:value-of select="@xml:lang"/>
            </xsl:attribute>
            <xsl:value-of select="text()"/>
        </Title>
    </xsl:template>
</xsl:stylesheet>