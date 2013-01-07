<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:ns1="ddi:studyunit:3_1" xmlns:ns2="ddi:reusable:3_1" 
    xmlns:ns3="ddi:archive:3_1" xmlns:ns4="ddi:physicalinstance:3_1" 
    xmlns:ns5="ddi:conceptualcomponent:3_1" xmlns:ns6="ddi:physicalinstance:3_1"
    xmlns:ns7="ddi:logicalproduct:3_1" xmlns:ns8="ddi:datacollection:3_1"
    xmlns:n9 ="http://www.w3.org/1999/xhtml"
    xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/" 
    xmlns:ddi-cv="urn:ddi-cv"
    exclude-result-prefixes="ns1 ns2 ns3 ns4 ns5 ns6 ns7 ns8 gc ddi-cv"
    xmlns="dda.dk/metadata/1.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <xsl:output indent="yes" method="xml" encoding="UTF-8" />
    
    <!-- todo: ActionToMinimizeLosses -->
    
    <xsl:template match="*">
        <xsl:apply-templates select="ns1:StudyUnit" />
    </xsl:template>

    <xsl:template match="ns1:StudyUnit">
        <Study>

            <State codeListAgencyName="dda.dk" 
                codeListID="urn:studystate.dda.dk" codeListName="DDAStudyState" 
                codeListSchemeURN="urn:studystate.dda.dk-1.0.0" 
                codeListURN="urn:studystate.dda.dk-1.0.0" codeListVersionID="1.0.0">
                <xsl:value-of select="ns3:Archive/ns3:ArchiveSpecific/ns3:Collection/ns3:StudyClass/ns3:ClassType"/>                                      
            </State>
            
            <StudyIdentifier>
                <Identifier><xsl:value-of select="concat('dda', @id)"/></Identifier>
                <CurrentVersion>
                    <xsl:value-of select="@version"/>
                </CurrentVersion>
            </StudyIdentifier>
            
            <PIDs>
                <PID>
                    <ID> 
                        <!-- todo: probably use value from DDI document at ns2:Citation/ns2:InternationalIdentifier[type='DOI'] />-->
                        <xsl:value-of select="concat('http://dx.doi.org/10.5279/DK-DDA-', @id)"/>
                    </ID>
                    <PIDType>DOI</PIDType>
                </PID>
            </PIDs>
            
            <Titles>
                <xsl:apply-templates select="ns2:Citation/ns2:Title"/>
            </Titles>
            
            <PrincipalInvestigators>
                <xsl:apply-templates select="ns3:Archive/ns3:OrganizationScheme/ns3:Individual" />
                <!-- Those are not investigators..todo: find another element for publishers/organisations
                    <xsl:apply-templates select="ns3:Archive/ns3:OrganizationScheme/ns3:Organization" />-->
            </PrincipalInvestigators>
            
            <DataURLs>
                <DataURL><xsl:value-of select="'todo_bestil_knap_url'"/></DataURL>
            </DataURLs>
            
            <PublicationDate>
                <xsl:value-of select="substring-before(ns2:Citation/ns2:PublicationDate/ns2:SimpleDate, 'T')"/>
            </PublicationDate>            
            
            <xsl:call-template name="Access" />            
            
            <StudyLanguage>da</StudyLanguage>            
            
            <xsl:call-template name="TopicalCoverage" />  
            
            <xsl:call-template name="StudyDescriptions" />            
            
            <xsl:apply-templates select="ns2:Coverage/ns2:SpatialCoverage"></xsl:apply-templates>
            
            <xsl:variable name="studyLevelUniverseID">
                <xsl:value-of select="ns2:UniverseReference/ns2:ID"/>
            </xsl:variable>            
            <Universes>
                <xsl:apply-templates select="//ns5:Universe[@id=$studyLevelUniverseID]" />
            </Universes>
            
            <TemporalCoverages>
                <xsl:apply-templates select="ns2:Coverage/ns2:TemporalCoverage" />
            </TemporalCoverages>
            
            <xsl:call-template name="DataSets" />
            
            <xsl:call-template name="Methodology" />
            
            <xsl:call-template name="DataCollection" />
            
            <xsl:call-template name="Documentation" />
            
            <xsl:variable name="archiveOrganizationRef" select="ns3:Archive/ns3:ArchiveSpecific/ns3:ArchiveOrganizationReference/ns2:ID" />
            <Archive>
                <xsl:value-of select="ns3:Archive/ns3:OrganizationScheme/ns3:Organization[@id=$archiveOrganizationRef]/ns3:OrganizationName"/>
            </Archive>
            
            <!--
            <Notes>
                <xsl:apply-templates select="ns2:Note"></xsl:apply-templates>
            </Notes>-->
            
            <!--
            <relations>
                <relation>
                    <identifier>2 35 560</identifier>
                    <identifierType>ISBN</identifierType>
                    <relationType>2</relationType>
                </relation>
            </relations>-->
        </Study>
    </xsl:template>
    
    
    <!-- todo: Hvis både TopLevelReference/LevelReference/ID og LowestLevelReference/LevelReference/ID peger på samme værdi, så map kun den ene til meta data -->
    <xsl:template match="ns2:Coverage/ns2:SpatialCoverage">
        <GeographicCoverages>
            <GeographicCoverage level="topLevel">
                <Label><xsl:value-of select="ns2:TopLevelReference/ns2:LevelName"/></Label>
                <Description xml:lang="da">
                    <xsl:value-of select="ns2:Description[@xml:lang='da']"/>
                </Description>
                <Description xml:lang="en">
                    <xsl:value-of select="ns2:Description[@xml:lang='en']"/>
                </Description>
            </GeographicCoverage>                
        </GeographicCoverages>
    </xsl:template>
    
    <xsl:template match="ns3:Archive/ns3:OrganizationScheme/ns3:Individual">
        <PrincipalInvestigator>
            <Person>
                <FirstName>
                    <xsl:value-of select="ns3:IndividualName/ns3:First/text()" />
                </FirstName>
                <xsl:if test="ns3:IndividualName/ns3:Last">
                    <LastName>
                        <xsl:value-of select="ns3:IndividualName/ns3:Last"/>
                    </LastName>
                </xsl:if>
                <!--<personIDs>
                    <personID>
                        <identifier>
                            <xsl:value-of select="@id"/>
                        </identifier>
                        <identifierSchema>dda.dk</identifierSchema>
                        <schemaURI>todo</schemaURI>
                    </personID>
                </personIDs>-->
                <!-- navnet findes ikke i alle eksempler -->
                <Affiliation>                    
                    <AffiliationName xml:lang="{parent::ns3:OrganizationScheme/ns3:Organization/ns3:OrganizationName/@xml:lang}">
                        <xsl:value-of select="parent::ns3:OrganizationScheme/ns3:Organization/ns3:OrganizationName/text()"/>                        
                    </AffiliationName>
                </Affiliation>
            </Person>
        </PrincipalInvestigator>
    </xsl:template>
    
    <xsl:template match="ns3:Archive/ns3:OrganizationScheme/ns3:Organization">
        <PrincipalInvestigator>
            <Institution>                
                <InstitutionName xml:lang="{ns3:OrganizationName/@xml:lang}">                  
                    <xsl:value-of select="ns3:OrganizationName/text()"/>                 
                </InstitutionName>
                <!--<institutionIDs>
                    <institutionID>
                        <identifier>
                            <xsl:value-of select="@id"/>
                        </identifier>
                        <identifierSchema>dda.dk</identifierSchema>
                        <schemaURI>todo</schemaURI>
                    </institutionID>
                </institutionIDs>-->
            </Institution>
        </PrincipalInvestigator>
    </xsl:template>

    <xsl:template match="ns2:Citation/ns2:Title">
        <Title xml:lang="{@xml:lang}">           
                <xsl:value-of select="text()"/>
        </Title>
    </xsl:template>
    
    <xsl:template name="StudyDescriptions">
        <StudyDescriptions>
            <xsl:if test="ns1:Purpose">
                <StudyDescription>
                    <Type>Purpose</Type>
                    <xsl:for-each select="ns1:Purpose">
                        <Content xml:lang="{ns2:Content/@xml:lang}">
                            <xsl:copy-of select="ns2:Content/*"/>
                        </Content>  
                    </xsl:for-each>        
                </StudyDescription>
            </xsl:if>
            <xsl:if test="ns1:Abstract">
                <StudyDescription>
                    <Type>Abstract</Type>
                    <xsl:for-each select="ns1:Abstract">
                        <Content xml:lang="{ns2:Content/@xml:lang}">
                            <xsl:copy-of select="ns2:Content/*"/>
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
  
    <xsl:template match="ns5:Universe">  
        <Universe>
            <xsl:if test="ns2:Label[@xml:lang='en']">
                <Label xml:lang="en">
                    <xsl:value-of select="ns2:Label[@xml:lang='en']/text()"/>
                </Label>
            </xsl:if>
            <xsl:if test="ns2:Label[@xml:lang='da']">
                <Label xml:lang="da">
                    <xsl:value-of select="ns2:Label[@xml:lang='da']/text()"/>
                </Label>
            </xsl:if>     
            <xsl:if test="ns5:HumanReadable[@xml:lang='en']">
                <Description xml:lang="en">            
                    <xsl:value-of select="ns5:HumanReadable[@xml:lang='en']/text()" />                  
                </Description>
            </xsl:if>
            <xsl:if test="ns5:HumanReadable[@xml:lang='da']">
                <Description xml:lang="da">            
                    <xsl:value-of select="ns5:HumanReadable[@xml:lang='da']/text()" />                  
                </Description>
            </xsl:if>       
        </Universe>
    </xsl:template>
    
    <xsl:template name="TopicalCoverage">
        <TopicalCoverage>
            <Subjects>
                <xsl:apply-templates select="ns2:Coverage/ns2:TopicalCoverage/ns2:Subject"></xsl:apply-templates>
            </Subjects>            
            <Keywords>
                <xsl:apply-templates select="ns2:Coverage/ns2:TopicalCoverage/ns2:Keyword"></xsl:apply-templates>
            </Keywords>
        </TopicalCoverage>
    </xsl:template>
    
    <xsl:template match="ns2:Coverage/ns2:TemporalCoverage">
        <TemporalCoverage>
            <StartDate>
                <xsl:value-of select="substring-before(ns2:ReferenceDate/ns2:StartDate/text(),'T')" />
            </StartDate>
            <EndDate>
                <xsl:value-of select="substring-before(ns2:ReferenceDate/ns2:EndDate/text(),'T')" />
            </EndDate>
            <!-- todo: er dette en acceptabel løsning? Der er kun en overordnet note og ikke en note for både start og end date. -->
            <xsl:variable name="temporalCoverageId" select="@id" />
            <xsl:if test="//ns2:Note/ns2:Relationship/ns2:RelatedToReference/ns2:ID=$temporalCoverageId">
                <xsl:for-each select="//ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$temporalCoverageId]">
                    <Description xml:lang="{ns2:Content/@xml:lang}">
                        <xsl:value-of select="ns2:Content"/>
                    </Description>
                </xsl:for-each>
            </xsl:if>
        </TemporalCoverage>
    </xsl:template>
           
    <xsl:template name="Access">
        <Access>               
            <Restriction codeListAgencyName="dda.dk" 
                codeListID="urn:accessrestrictions.dda.dk" codeListName="DDADataAccessRestrictions" 
                codeListSchemeURN="urn:accessrestrictions.dda.dk-1.0.0" 
                codeListURN="urn:accessrestrictions.dda.dk-1.0.0" codeListVersionID="1.0.0">           
                <xsl:value-of select="ns3:Archive/ns3:ArchiveSpecific/ns3:DefaultAccess/ns2:UserID[@type='dk.dda.study.archive.access.restriction.cvcode']" />
            </Restriction>
            <!-- todo: afventer yderligere afklaring og test data fra Jannik -->
            <RestrictionDate>
                <StartDate>
                    <xsl:value-of select="substring-before(ns2:Coverage/ns2:TemporalCoverage/ns2:ReferenceDate/ns2:StartDate/text(),'T')"/>
                 </StartDate>
                <EndDate>
                    <xsl:value-of select="substring-before(ns2:Coverage/ns2:TemporalCoverage/ns2:ReferenceDate/ns2:EndDate/text(),'T')"/>
                </EndDate>
            </RestrictionDate>
            <Condition codeListAgencyName="dda.dk" 
                codeListID="urn:accessconditions.dda.dk" codeListName="DDAAccessConditions" 
                codeListSchemeURN="urn:accessconditions.dda.dk-1.0.0" 
                codeListURN="urn:accessconditions.dda.dk-1.0.0" codeListVersionID="1.0.0">
                <xsl:value-of select="ns3:Archive/ns3:ArchiveSpecific/ns3:DefaultAccess/ns2:UserID[@type='dk.dda.study.archive.access.condition.cvcode']" />
            </Condition>
        </Access>
    </xsl:template>
    
    <xsl:template name="DataSets">
        <DataSets>
            <DataSet>                    
                <UnitType>todo</UnitType>
                <NumberUnits>
                    <xsl:value-of select="ns6:PhysicalInstance/ns6:GrossFileStructure/ns6:CaseQuantity/text()"/>
                </NumberUnits>
                <SampleNumberOfUnits>todo</SampleNumberOfUnits>
                <NumberVariables>
                    <xsl:value-of select="count(//ns7:Variable)"/>
                </NumberVariables>                
                <!--<files>
                        <file>
                            <name>Survey</name>
                            <format>SPSS</format>
                            <size>25MB</size>
                            <fingerprint>fingerprintXXXXX</fingerprint>
                            <fingerprintMethod>MD5</fingerprintMethod>
                        </file>
                    </files>-->
            </DataSet>
        </DataSets>
    </xsl:template>
    
    <xsl:template name="Methodology">   
        <Methodology>
            <TestType>   
                <TestTypeIdentifier codeListAgencyName="dda.dk" 
                    codeListID="urn:datacollectionmethodology.dda.dk" codeListName="DDADataCollectionMethodology" 
                    codeListSchemeURN="urn:datacollectionmethodology.dda.dk-1.0.0" 
                    codeListURN="urn:datacollectionmethodology.dda.dk-1.0.0" codeListVersionID="1.0.0">
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:DataCollectionMethodology[1]/ns2:UserID"/>
                </TestTypeIdentifier>     
                <xsl:variable name="testTypeDaId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:DataCollectionMethodology[ns2:Content/@xml:lang='da']/@id"/>
                </xsl:variable>
                <xsl:variable name="testTypeEnId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:DataCollectionMethodology[ns2:Content/@xml:lang='en']/@id"/>
                </xsl:variable>
                <Description xml:lang='da'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$testTypeDaId]/ns2:Content"/>
                </Description>
                <Description xml:lang='en'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$testTypeEnId]/ns2:Content"/>
                </Description>    
            </TestType>            
            <TimeMethod>
                <TimeMethodIdentifier codeListAgencyName="dda.dk" 
                    codeListID="urn:timemethod.dda.dk" codeListName="DDATimeMethod" 
                    codeListSchemeURN="urn:timemethod.dda.dk-1.0.0" 
                    codeListURN="urn:timemethod.dda.dk-1.0.0" codeListVersionID="1.0.0">
                        <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:TimeMethod[1]/ns2:UserID" />
                </TimeMethodIdentifier>                
                <xsl:variable name="timeMethodDaId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:TimeMethod[ns2:Content/@xml:lang='da']/@id"/>
                </xsl:variable>
                <xsl:variable name="timeMethodEnId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:TimeMethod[ns2:Content/@xml:lang='en']/@id"/>
                </xsl:variable>                
                <Description xml:lang='da'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$timeMethodDaId]/ns2:Content/text() "/>
                 </Description>
                <Description xml:lang='en'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$timeMethodEnId]/ns2:Content/text() "/>
                </Description>                
            </TimeMethod>  
            <SamplingProcedure>
                <SamplingProcedureIdentifier codeListAgencyName="dda.dk" 
                    codeListID="urn:samplingprocedure.dda.dk" codeListName="DDASamplingProcedure" 
                    codeListSchemeURN="urn:samplingprocedure.dda.dk-1.0.0" 
                    codeListURN="urn:samplingprocedure.dda.dk-1.0.0" codeListVersionID="1.0.0">
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:SamplingProcedure[1]/ns2:UserID"/>
                </SamplingProcedureIdentifier>                
                <xsl:variable name="samplingProcDaId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:SamplingProcedure[ns2:Content/@xml:lang='da']/@id"/>
                </xsl:variable>
                <xsl:variable name="samplingProcEnId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:Methodology/ns8:SamplingProcedure[ns2:Content/@xml:lang='en']/@id"/>
                </xsl:variable>
                <Description xml:lang='da'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$samplingProcDaId]/ns2:Content"/>
                </Description>
                <Description xml:lang='en'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$samplingProcEnId]/ns2:Content"/>
                </Description>    
            </SamplingProcedure>
            <DataType>
                <!-- todo: kind of data har ingen relateret note / ingen mulighed for relateret note -->
                <DataTypeIdentifier codeListAgencyName="dda.dk" 
                    codeListID="urn:kindofdata.dda.dk" codeListName="DDAKindOfData" 
                    codeListSchemeURN="urn:kindofdata.dda.dk-1.0.0" 
                    codeListURN="urn:kindofdata.dda.dk-1.0.0" codeListVersionID="1.0.0">
                        <xsl:value-of select="ns1:KindOfData/text()"/>
                </DataTypeIdentifier>
            </DataType>
            <NumberOfQuestions>
                <xsl:value-of select="count(ns8:DataCollection/ns8:QuestionScheme/ns8:QuestionItem)"/>
            </NumberOfQuestions>
        </Methodology>
    </xsl:template>
    
    <xsl:template name="DataCollection">
        <DataCollection>  
            <ModeOfCollection>
                <ModeOfCollectionIdentifier codeListAgencyName="dda.dk" 
                    codeListID="urn:datacollectionmode.dda.dk" codeListName="DDAModeOfCollection" 
                    codeListSchemeURN="urn:datacollectionmode.dda.dk-1.0.0" 
                    codeListURN="urn:datacollectionmode.dda.dk-1.0.0" codeListVersionID="1.0.0">
                    <xsl:value-of select="ns8:DataCollection/ns8:CollectionEvent/ns8:ModeOfCollection[1]/ns2:UserID" />
                </ModeOfCollectionIdentifier>                
                <xsl:variable name="modeOfCollectionDaId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:CollectionEvent/ns8:ModeOfCollection[ns2:Content/@xml:lang='da']/@id"/>
                </xsl:variable>
                <xsl:variable name="modeOfCollectionEnId">                
                    <xsl:value-of select="ns8:DataCollection/ns8:CollectionEvent/ns8:ModeOfCollection[ns2:Content/@xml:lang='en']/@id"/>
                </xsl:variable>
                <Description xml:lang='da'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$modeOfCollectionDaId]/ns2:Content/text() "/>
                </Description>
                <Description xml:lang='en'>
                    <xsl:value-of select="ns8:DataCollection/ns2:Note[ns2:Relationship/ns2:RelatedToReference/ns2:ID=$modeOfCollectionEnId]/ns2:Content/text() "/>
                </Description>    
            </ModeOfCollection>
            <xsl:variable name="dataCollectorOrgRef" select="ns8:DataCollection/ns8:CollectionEvent/ns8:DataCollectorOrganizationReference/ns2:ID" />
            <DataCollectorOrganizationReference>
                <xsl:value-of select="ns3:Archive/ns3:OrganizationScheme/ns3:Organization[@id=$dataCollectorOrgRef]/ns3:OrganizationName"/>
            </DataCollectorOrganizationReference>
        </DataCollection>
    </xsl:template>
    
    <xsl:template name="Documentation">
        <Documentation>
            <File MimeType="todo/contenttype">
                <Label>todo</Label>
                <URI>todo.uri</URI>
                <Type>Questionaire</Type>
            </File>
        </Documentation>
    </xsl:template>

    <!--
    <xsl:template match="ns2:Note">
        <Note xml:lang="">
            <text>Zum Datensatz liegt eine englischsprachige Dokumentation vor.</text>
        </Note>
    </xsl:template>-->
    
</xsl:stylesheet>