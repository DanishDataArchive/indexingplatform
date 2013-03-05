<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gc="http://docs.oasis-open.org/codelist/ns/genericode/1.0/"
    xmlns:ns1="dda.dk/metadata/1.0.0" xmlns:ddi-cv="urn:ddi-cv" version="1.0"
    exclude-result-prefixes="ns1 gc ddi-cv">

    <!-- Kun relevant i forbindelse med test af lp-core direkte uden om lp-main -->
    <xsl:output method="html" indent="yes"/>
    <xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyzæøå'"/>
    <xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZÆØÅ'"/>

    <!-- Denne template benyttes kun ved test af lp-core uden main (derfor hardcode) -->
    <xsl:template match="*">
        <xsl:call-template name="lp-core-content">
            <xsl:with-param name="lang" select="'da'"/>
            <!--xsl:with-param name="previousVersions" select="'1.0.0,1.2.0'"/-->
            <xsl:with-param name="cvFolder" select="'cv'"/>
            <xsl:with-param name="hostname" select="'http://localhost'"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Landing page core template -->
    <xsl:template name="lp-core-content">
        <xsl:param name="lang"/>
        <xsl:param name="previousVersions"/>
        <xsl:param name="cvFolder"/>
        <xsl:param name="hostname"/>

        <!-- 
            Forklaring til parametre:
              lang er det valgte sprog (da, en)
              previousVersions er med som kommasepareret tekststreng uden mellemrum med eventuelt tidligere versioner (feks: "1.0.0,1.0.1,1.0.2")
              cvFolder er mappen, hvor CV's ligger
              hostname er med som parameter for at understøtte test/lokale miljøer
        -->

        <!-- cv mappe sendes med som parameter, så xslt kan kaldes både i exist og i tests uden for exist -->
        <xsl:variable name="studyId"
            select="substring-after(ns1:StudyIdentifier/ns1:Identifier, 'dda')"/>
        <xsl:variable name="accessConditionsCV"
            select="document(concat($cvFolder, '/accessconditions.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="accessRestrictionsCV"
            select="document(concat($cvFolder, '/accessrestrictions.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="dataCollectionMethodCV"
            select="document(concat($cvFolder, '/datacollectionmethodology.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="dataCollectionModeCV"
            select="document(concat($cvFolder, '/datacollectionmode.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="kindOfDataCV"
            select="document(concat($cvFolder, '/kindofdata.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="samplingprocedureCV"
            select="document(concat($cvFolder, '/samplingprocedure.dda.dk-1.0.0.cv'))"/>

        <xsl:variable name="studyStateCV"
            select="document(concat($cvFolder, '/studystate.dda.dk-1.0.0.cv'))"/>

        <xsl:variable name="timeMethodCV"
            select="document(concat($cvFolder, '/timemethod.dda.dk-1.0.0.cv'))"/>
        <xsl:variable name="labels" select="document('lp-labels.xml')"/>
        <form id="searchform" method="post" action="http://{$hostname}/simple-search">
            <div xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:dcat="http://www.w3.org/ns/dcat#" itemscope="itemscope"
                itemtype="http://schema.org/Dataset" about="dcat:Dataset" typeof="dcat:Dataset">
                <h1 class="lp">
                    <span itemprop="name" property="dcterms:title">
                        <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>
                    </span>
                    <span property="dcterms:language" content="da"/>
                </h1>
                <a name="primaryinvestigator"/>
                <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='principalinvestigator']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <xsl:for-each select="ns1:PrincipalInvestigators/ns1:PrincipalInvestigator">
                    <div itemscope="itemscope" itemtype="http://schema.org/Person">
                        <xsl:variable name="pInvestigator">
                            <xsl:value-of select="ns1:Person/ns1:FirstName/text()"/>
                            <xsl:if test="ns1:Person/ns1:LastName">
                                <xsl:value-of select="concat(' ', ns1:Person/ns1:LastName)"/>
                            </xsl:if>
                        </xsl:variable>
                        <span itemprop="name" class="lplink">
                            <a href="javascript:;" onclick="studySearch('{$pInvestigator}')">
                                <xsl:value-of select="$pInvestigator"/>
                            </a>
                        </span>, <xsl:value-of
                            select="ns1:Person/ns1:Affiliation/ns1:AffiliationName"/>
                    </div>
                </xsl:for-each>
                <a name="documentation"/>
                <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='documentation']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <p class="lp">
                    <a href="http://{$hostname}/catalogue/{$studyId}/doc/codebook">
                        <xsl:value-of
                            select="$labels/LandingPageLabels/Label[@id='codebook']/LabelText[@xml:lang=$lang]/text()"
                        />
                    </a>
                </p>
                <!--p class="lp">
                <a href="{ concat($studyId, '/documentation/questionaire/q-',  $studyId, '.pdf')}">Spørgeskema PDF</a>
            </p-->
                <a name="description"/>
                <span class="lph2">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='description']/LabelText[@xml:lang=$lang]/text()"
                    />
                </span>  <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='purpose']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <xsl:copy-of
                    select="ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='Purpose']/ns1:Content[@xml:lang=$lang]"/>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='abstract']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <span itemprop="description" property="dcterms:description">
                    <!--xsl:value-of select="ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='Abstract']/ns1:Content[@xml:lang=$lang]/text()"/-->
                    <xsl:copy-of
                        select="ns1:StudyDescriptions/ns1:StudyDescription[ns1:Type='Abstract']/ns1:Content[@xml:lang=$lang]"
                    />
                </span>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='keywords']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3> <span class="lplink" property="dcat:keyword">
                    <xsl:for-each
                        select="ns1:TopicalCoverage/ns1:Keywords/ns1:Keyword[@xml:lang=$lang]">
                        <a href="javascript:;" onclick="studySearch('{text()}')">
                            <span itemprop="keyword">
                                <span itemscope="itemscope" itemtype="http://schema.org/Text">
                                    <xsl:value-of select="text()"/>
                                </span>, </span>
                        </a>
                    </xsl:for-each>
                </span>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='classification']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <span class="lplink">
                    <xsl:for-each
                        select="ns1:TopicalCoverage/ns1:Subjects/ns1:Subject[@xml:lang=$lang]">
                        <a href="javascript:;" onclick="studySearch('{text()}')">
                            <span itemprop="about">
                                <xsl:value-of select="concat(text(), ', ')"/>
                            </span>
                        </a>
                    </xsl:for-each>
                </span>
                <a name="universe"/>  <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='universe']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2> <xsl:value-of
                    select="ns1:Universes/ns1:Universe/ns1:Label[@xml:lang=$lang]/text()"/>, <em>
                    <xsl:value-of
                        select="ns1:Universes/ns1:Universe/ns1:Description[@xml:lang=$lang]/text()"
                    />
                </em>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='geographiccoverage']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <span rel="dcterms:spatial" resource="http://dbpedia.org/resource/Denmark"/>
                <xsl:value-of
                    select="concat(translate(substring(ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Label,1,1), $vLower, $vUpper), substring(ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Label, 2), substring(' ', 1 div not(position()=last())))"/>
                <xsl:if
                    test="ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Description[@xml:lang=$lang]"
                    >, <em>
                        <xsl:value-of
                            select="ns1:GeographicCoverages/ns1:GeographicCoverage/ns1:Description[@xml:lang=$lang]/text()"
                        />
                    </em>
                </xsl:if>
                <!-- - variables - -->
                <a name="dataset"/>  <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='dataset']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <p class="lp">
                    <a href="javascript:;" onclick="createOrder()">
                        <xsl:value-of
                            select="$labels/LandingPageLabels/Label[@id='askfordata']/LabelText[@xml:lang=$lang]/text()"
                        />
                    </a>
                </p>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='variables']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:NumberVariables"/>
                <br/>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='respondenter']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='respondenter_numberunits']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:NumberOfUnits"/>
                <br/>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='respondenter_samplenumberunits']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:value-of select="ns1:DataSets/ns1:DataSet/ns1:SampleNumberOfUnits"/>
                <!-- - methodology - -->
                <a name="method"/>
                <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='method']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <!-- kind of data -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='studytype']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:for-each select="ns1:Methodology/ns1:DataType">
                        <xsl:variable name="kindOfDataId" select="ns1:DataTypeIdentifier"/>
                        <xsl:value-of
                            select="$kindOfDataCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$kindOfDataId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                        <xsl:text>, </xsl:text>
                    </xsl:for-each>
                </p>
                <!-- time method -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='timemethod']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:variable name="timeMethodId"
                        select="ns1:Methodology/ns1:TimeMethod/ns1:TimeMethodIdentifier"/>
                    <xsl:value-of
                        select="$timeMethodCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$timeMethodId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                    <xsl:if
                        test="ns1:Methodology/ns1:TimeMethod/ns1:Description[@xml:lang=$lang]/text()"
                        >, <em>
                            <xsl:value-of
                                select="ns1:Methodology/ns1:TimeMethod/ns1:Description[@xml:lang=$lang]/text()"
                            />
                        </em>
                    </xsl:if>
                </p>
                <!-- sampling procedure -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='samplingprocedure']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:variable name="samplingProcedureId"
                        select="ns1:Methodology/ns1:SamplingProcedure/ns1:SamplingProcedureIdentifier"/>
                    <xsl:value-of
                        select="$samplingprocedureCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$samplingProcedureId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                    <xsl:if
                        test="ns1:Methodology/ns1:SamplingProcedure/ns1:Description[@xml:lang=$lang]/text()"
                        >, <em>
                            <xsl:value-of
                                select="ns1:Methodology/ns1:SamplingProcedure/ns1:Description[@xml:lang=$lang]/text()"
                            />
                        </em>
                    </xsl:if>
                </p>
                <!-- action to minimize loose -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='actiontominimizeloos']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:value-of
                        select="ns1:Methodology/ns1:ActionToMinimizeLosses/ns1:Description[@xml:lang=$lang]/text()"
                    />
                </p>
                <!-- - data collection - -->
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='datacollection']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <!-- mode of collection -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='modeofcollection']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:variable name="modeOfCollectionId"
                        select="ns1:DataCollection/ns1:ModeOfCollection/ns1:ModeOfCollectionIdentifier"/>
                    <xsl:value-of
                        select="$dataCollectionModeCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$modeOfCollectionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                    <xsl:if
                        test="ns1:DataCollection/ns1:ModeOfCollection/ns1:Description[@xml:lang=$lang]/text()"
                        >, <em>
                            <xsl:value-of
                                select="ns1:DataCollection/ns1:ModeOfCollection/ns1:Description[@xml:lang=$lang]/text()"
                            />
                        </em>
                    </xsl:if>
                    <br/>
                </p>
                <!-- data collection methodology -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='testtype']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:variable name="methodologyId"
                        select="ns1:Methodology/ns1:TestType/ns1:TestTypeIdentifier"/>
                    <xsl:value-of
                        select="$dataCollectionMethodCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$methodologyId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                    <xsl:if
                        test="ns1:Methodology/ns1:TestType/ns1:Description[@xml:lang=$lang]/text()"
                        >, <em>
                            <xsl:value-of
                                select="ns1:Methodology/ns1:TestType/ns1:Description[@xml:lang=$lang]/text()"
                            />
                        </em>
                    </xsl:if>
                </p>
                <!-- number of questions -->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='numberofquestions']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:value-of select="ns1:Methodology/ns1:NumberOfQuestions"/>
                </p>
                <!-- data  collector-->
                <p class="lp">
                    <strong class="lp">
                        <xsl:value-of
                            select="concat($labels/LandingPageLabels/Label[@id='datacollector']/LabelText[@xml:lang=$lang]/text(), ': ')"
                        />
                    </strong>
                    <xsl:value-of select="ns1:DataCollection/ns1:DataCollectorOrganizationReference"/>
                    <br/>
                </p>
                <!-- - temporal coverage -  -->
                <span itemprop="temporal" rel="dcterms:temporal">
                    <span typeof="dcterms:periodOfTime" about="dcterms:temporal">
                        <h3 class="lp" property="dcterms:name">
                            <xsl:value-of
                                select="$labels/LandingPageLabels/Label[@id='temporalcoverage']/LabelText[@xml:lang=$lang]/text()"
                            />
                        </h3>
                        <!-- todo: udskriv noter (todo: de er ikke med i metadata: tilføj dem) -->
                        <strong class="lp">
                            <xsl:value-of
                                select="concat($labels/LandingPageLabels/Label[@id='temporalcoverage_startdate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                            />
                        </strong>
                        <span itemprop="startDate" property="dcterms:start">
                            <xsl:value-of
                                select="ns1:TemporalCoverages/ns1:TemporalCoverage/ns1:StartDate"/>
                        </span>
                        <br/>
                        <strong class="lp">
                            <xsl:value-of
                                select="concat($labels/LandingPageLabels/Label[@id='temporalcoverage_enddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                            />
                        </strong>
                        <span itemprop="endDate" property="dcterms:end">
                            <xsl:value-of
                                select="ns1:TemporalCoverages/ns1:TemporalCoverage/ns1:EndDate"/>
                        </span>
                    </span>
                </span>
                <br/>
                <!-- - citation - -->
                <a name="citation"/>
                <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='citation']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <xsl:for-each select="ns1:PrincipalInvestigators/ns1:PrincipalInvestigator">
                    <xsl:choose>
                        <xsl:when test="ns1:Person/ns1:LastName/text()">
                            <xsl:value-of
                                select="concat(ns1:Person/ns1:FirstName, ' ', ns1:Person/ns1:LastName, ', ')"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="concat(ns1:Person/ns1:FirstName, ', ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                <em>
                    <xsl:value-of select="ns1:Titles/ns1:Title[@xml:lang=$lang]/text()"/>, </em>
                <span rel="dcterms:publisher">
                    <span itemprop="publisher" itemscope="itemscope"
                        itemtype="http://schema.org/Organization" typeof="foaf:Organization"
                        about="dcterms:publisher">
                        <span itemprop="name" property="dcterms:title">
                            <xsl:value-of select="ns1:Archive"/>
                        </span>
                    </span>
                </span>, <xsl:value-of select="substring-before(ns1:PublicationDate, '-')"/>. 1
                datafil: <xsl:value-of select="concat('DDA-', $studyId)"/>, version: <xsl:value-of
                    select="ns1:StudyIdentifier/ns1:CurrentVersion"/>, <a
                    href="{ns1:PIDs/ns1:PID/ns1:ID}">
                    <xsl:value-of select="ns1:PIDs/ns1:PID/ns1:ID"/>
                </a>
                <h3 class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='persistentidentifier']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </h3>
                <p class="lp">
                    <strong class="lp">URL: </strong>
                    <a href="http://{$hostname}/catalogue/{$studyId}"
                            >http://dda.dk/catalogue/<xsl:value-of select="$studyId"/>
                    </a>
                    <br/>
                </p>
                <p class="lp">
                    <strong class="lp">DOI: </strong>
                    <span property="dcterms:identifier" content="{ns1:PIDs/ns1:PID/ns1:ID}"/>
                    <a href="{ns1:PIDs/ns1:PID/ns1:ID}">
                        <xsl:value-of select="ns1:PIDs/ns1:PID/ns1:ID"/>
                    </a>
                </p>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='archiveinfo']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='receiveddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:value-of select="ns1:StudyRecievedDate"/>
                <br/>  <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='publisheddate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <span itemprop="datePublished" property="dcterms:issued">
                    <xsl:value-of select="ns1:StudyPublicationDate"/>
                </span>
                <!-- - access - -->
                <a name="status"/>
                <h2 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='access']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h2>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='studystate']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:variable name="stateId" select="ns1:State"/>
                <xsl:value-of
                    select="$studyStateCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$stateId]/Value[@ColumnRef='reusestatus']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                <br/>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='restrictions']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:variable name="restrictionId" select="ns1:Access/ns1:Restriction"/>
                <xsl:value-of
                    select="$accessRestrictionsCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$restrictionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                <br/>
                <strong class="lp">
                    <xsl:value-of
                        select="concat($labels/LandingPageLabels/Label[@id='accessconditions']/LabelText[@xml:lang=$lang]/text(), ': ')"
                    />
                </strong>
                <xsl:variable name="conditionId" select="ns1:Access/ns1:Condition"/>
                <xsl:value-of
                    select="$accessConditionsCV/gc:CodeList/SimpleCodeList/Row[Value/@ColumnRef='code' and Value/SimpleValue/text()=$conditionId]/Value[@ColumnRef='description']/ComplexValue/ddi-cv:Value[@xml:lang=$lang]/text()"/>
                <br/>
                <a name="metadata"/>
                <h2 class="lp">Metadata</h2>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='studymetadata']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <xsl:variable name="latestVersion" select="ns1:StudyIdentifier/ns1:CurrentVersion"/>
                <a
                    href="http://{$hostname}/urn-resolution/ddi-3.1?urn=urn:ddi:dk.dda:{$studyId}:{$latestVersion}">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='latestversion']/LabelText[@xml:lang=$lang]/text()"/>
                    <xsl:value-of select="$latestVersion"/>
                </a>
                <xsl:if test="$previousVersions != ','">
                    <p class="lp">
                        <strong class="lp">
                            <xsl:value-of
                                select="$labels/LandingPageLabels/Label[@id='previousversions']/LabelText[@xml:lang=$lang]/text()"
                            />
                        </strong>
                    </p>
                </xsl:if>
                <xsl:call-template name="PreviousVersionsOfStudy">
                    <xsl:with-param name="inputString" select="$previousVersions"/>
                    <xsl:with-param name="separator" select="','"/>
                    <xsl:with-param name="studyId" select="$studyId"/>
                    <xsl:with-param name="hostname" select="$hostname"/>
                    <xsl:with-param name="lang" select="$lang"/>
                </xsl:call-template>
                <h3 class="lp">
                    <xsl:value-of
                        select="$labels/LandingPageLabels/Label[@id='otherformats']/LabelText[@xml:lang=$lang]/text()"
                    />
                </h3>
                <p class="lp">
                    <a href="http://{$hostname}/catalogue/{$studyId}/doc/ddastudymetadata">
                        <xsl:value-of
                            select="$labels/LandingPageLabels/Label[@id='studydescription']/LabelText[@xml:lang=$lang]/text()"
                        />
                    </a>
                </p>
                <!--a href="#">DublinCore</a><br-->
                <p class="lp">
                    <a href="{ns1:PIDs/ns1:PID/ns1:ID}">
                        <xsl:value-of
                            select="$labels/LandingPageLabels/Label[@id='datacite']/LabelText[@xml:lang=$lang]/text()"
                        />
                    </a>
                </p>
                <!--a href="#">MARC</a-->
            </div>
        </form>

        <!-- - publications - -->
        <a name="publications"/>
        <h2 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='publications']/LabelText[@xml:lang=$lang]/text()"
            />
        </h2>
        <!-- primary -->
        <h3 class="lp">
            <xsl:value-of
                select="$labels/LandingPageLabels/Label[@id='primary-publications']/LabelText[@xml:lang=$lang]/text()"
            />
        </h3>
        <xsl:for-each select="ns1:Publications/ns1:Publication">
            <xsl:if test="ns1:PublicationType='Primary'">
                <xsl:call-template name="Publication"/>
            </xsl:if>
        </xsl:for-each>
        <!-- secondary -->
        <xsl:variable name="anySecondaryPublication">
            <xsl:for-each select="ns1:Publications/ns1:Publication">
                <xsl:if test="ns1:PublicationType='Secondary'">
                    <xsl:text>1</xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="$anySecondaryPublication!=''">
            <h3 class="lp">
                <xsl:value-of
                    select="$labels/LandingPageLabels/Label[@id='secondary-publications']/LabelText[@xml:lang=$lang]/text()"
                />
            </h3>
            <xsl:for-each select="ns1:Publications/ns1:Publication">
                <xsl:if test="ns1:PublicationType='Secondary'">
                    <xsl:call-template name="Publication"/>
                </xsl:if>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

    <xsl:template name="Publication">
        <!-- author -->
        <xsl:value-of select="ns1:Authors/ns1:Person/ns1:FirstName"/>
        <xsl:text>, </xsl:text>
        <!-- title -->
        <em>
            <xsl:value-of select="ns1:Titles/ns1:Title"/>
        </em>
        <xsl:text>, </xsl:text>
        <!-- publisher -->
        <xsl:if test="ns1:Publisher">
            <xsl:value-of select="ns1:Publisher"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- pub ref and page -->
        <xsl:if test="ns1:PublicationReferenceAndPage">
            <xsl:value-of select="ns1:PublicationReferenceAndPage"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <!-- year -->
        <xsl:if test="ns1:Year">
            <xsl:value-of select="ns1:Year"/>
        </xsl:if>
        <br/>
    </xsl:template>

    <!-- Xslt 1.0 tokenize templates til at håndtere visning af eventuelt tidligere versioner -->
    <xsl:template name="PreviousVersionsOfStudy">
        <xsl:param name="inputString"/>
        <xsl:param name="separator"/>
        <xsl:param name="studyId"/>
        <xsl:param name="hostname"/>
        <xsl:param name="lang"/>
        <xsl:variable name="token" select="substring-before($inputString, $separator)"/>
        <xsl:variable name="nextToken" select="substring-after($inputString, $separator)"/>
        <xsl:if test="$token">
            <p class="lp">
                <a
                    href="http://{$hostname}/urn-resolution/ddi-3.1?urn=urn:ddi:dk.dda:{$studyId}:{$token}"
                    > Version: <xsl:value-of select="$token"/>
                </a>
                <br/>
            </p>
        </xsl:if>
        <xsl:if test="$nextToken">
            <xsl:call-template name="PreviousVersionsOfStudy">
                <xsl:with-param name="inputString" select="$nextToken"/>
                <xsl:with-param name="separator" select="$separator"/>
                <xsl:with-param name="studyId" select="$studyId"/>
                <xsl:with-param name="hostname" select="$hostname"/>
                <xsl:with-param name="lang" select="$lang"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
