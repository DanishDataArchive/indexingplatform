<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:import href="../landingpage/cv/CvListToHtml.xsl"/>
    <xsl:import href="result-html-fragments-default.xsl"/>
    <!--xsl:import href="@UI-BRANDING-RESULT@"/-->
    
    <xsl:output method="html" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" indent="yes"/>
    <xsl:param name="type"/>
    <xsl:param name="grouped"/>
    <xsl:param name="lang" select="'en'"/>
    <xsl:param name="hostname"/>
    
    <xsl:variable name="labels" select="document('techinfo-labels.xml')/TechInfoLabels/Label"/>
    
    <xsl:template match="*">
        <html>
            <head>
                <meta http-equiv="Content-type" content="text/html;charset=UTF-8"/>
                <link rel="stylesheet" type="text/css" href="theme/style.css"/>
                <link rel="stylesheet" type="text/css" href="theme/result.css"/>
                <link rel="shortcut icon" href="theme/favicon.ico"/>                
                <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css" />
                <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
                <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
                <script type="text/javascript">
                    @WEB-SITE-TRACKING@
                </script>
                <script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
                <script src="js/cvi_busy_lib.js" type="text/javascript"></script>
                <script type="text/javascript">
                    var lang = 'da';
                    function changeLang(newLang) {
                    current = 'http://' + window.location.hostname + window.location.pathname;
                    window.location.replace(current + '?lang=' +newLang);
                    }
                    
                    var busy;
                    function makebusy(element) {
                    try {busy.remove(); busy='';}catch(e) {busy=getBusyOverlay(element,{color:'#f5f5f5', opacity:0.25},{color:'#000000', size:45, type:'o'});}
                    }
                </script>
                <title>
                    <xsl:value-of select="$labels[@id='title']/LabelText[@xml:lang=$lang]/text()"/>
                </title>
            </head>
            <body>
                <div align="center">
                    <table id="table1" class="frametable" border="0" cellpadding="0" cellspacing="0" width="962">
                        <tbody>
                            <xsl:call-template name="result-header-top">
                                <xsl:with-param name="lang" select="$lang"/>
                                <xsl:with-param name="hostname" select="$hostname"/>
                                <xsl:with-param name="img" select="'digits'"/>
                            </xsl:call-template>
                            <tr>
                                <td mainframe="" valign="top">
                                    <table id="table2" class="main" border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tbody>
                                            <tr>
                                                <xsl:call-template name="result-header-leftmenu">
                                                    <xsl:with-param name="lang" select="$lang"/>
                                                    <xsl:with-param name="hostname" select="$hostname"/>
                                                </xsl:call-template>
                                                <td valign="top" width="580">
                                                    
                                                    <div align="center">
                                                        <table id="printContent" border="0" cellpadding="0" cellspacing="0" width="700">
                                                            <!--org width 530 -->
                                                            <tbody>
                                                                <tr>
                                                                    <td valign="top">
                                                                        <h1 class="lp"><xsl:value-of select="$labels[@id='title']/LabelText[@xml:lang=$lang]/text()"/></h1>
                                                                        
                                                                        <!-- DDA landingpage -->                                                                        
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-dda-landing-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>                                                                        
                                                                        <xsl:value-of  select="$labels[@id='text-dda-landing-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        
                                                                        <!-- CV documentation -->                                  
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-cv-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>                                                                        
                                                                        <xsl:choose>
                                                                            <!-- hack to curcumvent xhtml tags :( -->
                                                                            <xsl:when test="$lang='da'">DDA klassifikationer anvendt på studiebeskrivelses- metode og livscyklusniveau. Klassifikationerne er defineret i <a href="http://docs.oasis-open.org/codelist/cs-genericode-1.0/doc/oasis-code-list-representation-genericode.html">Genericode</a> format.</xsl:when>
                                                                            <xsl:otherwise>DDA controled vocabularies describing study level description -method and lifecycle events. The controled vocabularies are defined in <a href="http://docs.oasis-open.org/codelist/cs-genericode-1.0/doc/oasis-code-list-representation-genericode.html">Genericode</a> format.</xsl:otherwise>
                                                                        </xsl:choose>
                                                                        <h3 class="lp"><xsl:value-of select="$labels[@id='a-cv-doc']/LabelText[@xml:lang=$lang]/text()"/></h3>
                                                                        <xsl:call-template name="cvToHtml">
                                                                            <xsl:with-param name="cvList" select="document('../landingpage/cv/cvlist.xml')/CvList"/>
                                                                            <xsl:with-param name="hostname" select="$hostname"/>
                                                                        </xsl:call-template>
                                                                                                 
                                                                        <!-- Search API -->                                                                        
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>
                                                                        <xsl:value-of select="$labels[@id='text-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        <xsl:choose>
                                                                            <!-- hack to circumvent xhtml tags :( -->
                                                                            <xsl:when test="$lang='da'"></xsl:when>
                                                                            <xsl:otherwise>
                                                                                <ul>
                                                                                    <li>Study unit description</li>
                                                                                    <li>Variable labels and description</li>
                                                                                    <li>Question texts and description</li>
                                                                                    <li>Universe descriptions and label</li>
                                                                                    <li>Concept descriptions and labels</li>
                                                                                    <li>Category texts</li>
                                                                                </ul>                                                                                
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>     
                                                                        <h3 class="lp">
                                                                            <!-- url params method -->
                                                                            <xsl:value-of select="$labels[@id='url-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        </h3>
                                                                        <p>
                                                                            <xsl:value-of select="$labels[@id='url-detail-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                            <xsl:choose>
                                                                                <!-- hack to circumvent xhtml tags :( -->
                                                                                <xsl:when test="$lang='da'"></xsl:when>
                                                                                <xsl:otherwise>
                                                                                    <ul>
                                                                                        <li><b>search-string</b> - the search string - [mandatory]</li>
                                                                                        <li><b>hits-perpage</b> - number of hit pr. page with a maxium of 500 - [optionel]</li>
                                                                                        <li><b>hit-start</b> - results will start at result number - [optionel]</li>
                                                                                        <li><b>lang</b> - defined result language  - [optionel] all language results will be outputed</li>
                                                                                        <li><b>StudyUnit</b> - true - [optionel]</li>
                                                                                        <li><b>Variable</b> - true - [optionel]</li>
                                                                                        <li><b>QuestionItem</b> - true - [optionel]</li>
                                                                                        <li><b>Universe</b> - true - [optionel]</li>
                                                                                        <li><b>Concept</b> - true - [optionel]</li>
                                                                                        <li><b>Category</b> - true - [optionel]</li>
                                                                                    </ul>                                                                                
                                                                                </xsl:otherwise>
                                                                            </xsl:choose>                                                                            
                                                                        </p>
                                                                        <p>
                                                                            <xsl:value-of select="$labels[@id='url-text-ex-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        </p>
                                                                        <p>
                                                                            <b><xsl:value-of select="$labels[@id='url-ex-search-api-doc']/LabelText[@xml:lang=$lang]/text()"/></b>    
                                                                        </p>
                                                                        
                                                                        <!-- Schema documentation -->
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-schema-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>
                                                                        <xsl:value-of select="$labels[@id='text-schema-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        <ul>
                                                                            <xsl:for-each select="resource">
                                                                                <xsl:variable name="schemaPath" select="@name"/>
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$schemaPath='MetaDataSchema.xsd'"></xsl:when>
                                                                                    <xsl:otherwise><li><a href="http://{$hostname}/search-technical-information/schema/{$schemaPath}"><xsl:value-of select="$schemaPath"/></a></li></xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </xsl:for-each>
                                                                        </ul>
                                                                        
                                                                        <!-- URN resolution service -->                                  
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>
                                                                        <xsl:value-of select="$labels[@id='text-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/>                                                                       
                                                                        <p>
                                                                            <xsl:value-of select="$labels[@id='detail-a-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/><a href="http:/{$hostname}/urn-resolution/ddi-3.1">http://<xsl:value-of select="$hostname"/>/urn-resolution/ddi-3.1</a>
                                                                            <xsl:value-of select="$labels[@id='detail-b-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/>
                                                                        </p>
                                                                        <p>
                                                                            <xsl:value-of select="$labels[@id='detail-c-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/>    
                                                                        </p>
                                                                        <p>
                                                                            <b><xsl:value-of select="$labels[@id='detail-d-urn-service-doc']/LabelText[@xml:lang=$lang]/text()"/></b>    
                                                                        </p>
                                                                        
                                                                        <!-- Source code -->
                                                                        <h2 class="lp"><xsl:value-of select="$labels[@id='title-source-doc']/LabelText[@xml:lang=$lang]/text()"/></h2>
                                                                        <xsl:value-of select="$labels[@id='details-source-doc']/LabelText[@xml:lang=$lang]/text()"/>                                                                       
                                                                        <a href="https://github.com/DanishDataArchive/indexingplatform">github.com/DanishDataArchive/indexingplatform</a>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            
                            <xsl:call-template name="result-footer-content">
                                <xsl:with-param name="lang" select="$lang"/>
                            </xsl:call-template>
                            
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
