/*
 * RESTclient.java
 */

package dk.dda.ddi.rest;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import javax.xml.ws.handler.MessageContext;
import javax.xml.ws.http.HTTPBinding;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Map;
import java.net.Authenticator;
import java.net.PasswordAuthentication;

/**
 * @author Kemal Pajevic
 */
public class RESTclient {
	
	private static final String BASE_URL = "http://192.168.99.5:8080/exist/rest/db/dda/rest/";
	private static final String BASE_URN_URL = "http://192.168.99.5:8080/exist/rest/db/dda/rest/";
	private static final String SIMPLE_SEARCH_PAGE = "simple-search.xquery";
	private static final String ADVANCED_SEARCH_PAGE = "advanced-search.xquery";
	private static final String URN_RESOLUTION_PAGE = "urn-resolution.xquery";
    private static final QName qname = new QName("", "");
    private static final String USER = "admin";
	private static final String PASSWORD = "";
	
    private Service service;
    
    private static final String simpleSearchParameters = 	"<ssp:SimpleSearchParameters" +
    														" xmlns:smd=\"http://dda.dk/ddi/search-metadata\"" +
												    		" xmlns:ssp=\"http://dda.dk/ddi/simple-search-parameters\"" +
												    		" xmlns:s=\"http://dda.dk/ddi/scope\"" +
												    		" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">" +
												    		"    <ssp:search-string>national</ssp:search-string>" +
												    		"    <smd:SearchMetaData hits-perpage=\"10\" hit-start=\"0\"/>" +
												    		"    <s:Scope>" +
												    		"        <s:StudyUnit/>" +
												    		"        <s:Variable/>" +
												    		"        <s:QuestionItem/>" +
												    		"        <s:MultipleQuestionItem/>" +
												    		"        <s:Universe/>" +
												    		"        <s:Concept/>" +
												    		"        <s:Category/>" +
												    		"    </s:Scope>" +
												    		"</ssp:SimpleSearchParameters>";
    private static final String advancedSearchParameters = 	"<asp:AdvancedSearchParameters xmlns:sm=\"http://dda.dk/ddi/search-metadata\"" +
    														"     xmlns:s=\"http://dda.dk/ddi/scope\"" +
    														"     xmlns:asp=\"http://dda.dk/ddi/advanced-search-parameters\"" +
    														"     xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"" +
    														"     xsi:schemaLocation=\"http://dda.dk/ddi/advanced-search-parameters file:/C:/Users/kp/Dropbox/DDA/DDA-IPF/schema/search/advanced-search-parameters.xsd\">" +
    														"        <asp:studyId>13794</asp:studyId>" +
    														"        <asp:title>kommunale</asp:title>" +
    														"        <asp:topicalCoverage>Tillidserhverv</asp:topicalCoverage>" +
    														"        <asp:spatialCoverage>national</asp:spatialCoverage>" +
    														"        <asp:abstract-purpose>udvalgstilknytning</asp:abstract-purpose>" +
    														"        <asp:creator>Søren</asp:creator>" +
    														"        <asp:kindOfData>Spørgeskemaundersøgelse</asp:kindOfData>" +
    														"        <asp:coverageFrom>2000-08-01</asp:coverageFrom>" +
    														"        <asp:coverageTo>2000-12-01</asp:coverageTo>" +
    														"        <asp:Variable>STUDIENUMMER</asp:Variable>" +
    														"        <asp:QuestionItem>studiesituation</asp:QuestionItem>" +
    														"        <sm:SearchMetaData hits-perpage=\"10\" hit-start=\"0\"/>" +
    														"        <s:Scope>" +
    														"            <s:StudyUnit/>" +
    														"            <s:Variable/>" +
    														"            <s:QuestionItem/>" +
    														"            <s:MultipleQuestionItem/>" +
    														"            <s:Universe/>" +
    														"            <s:Concept/>" +
    														"            <s:Category/>" +
    														"        </s:Scope>" +
    														"    </asp:AdvancedSearchParameters>";
    private static final String urn = "urn:ddi:dk.dda:quei-c5539352-4c17-42e7-b6b4-ea775ccc82fb:1.0.0";
    
   public RESTclient() {
	   Authenticator.setDefault(new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USER, PASSWORD.toCharArray());
			}
		});
	
    }

    private void POST(String page, String data) {
		service = Service.create(qname);
		service.addPort(qname, HTTPBinding.HTTP_BINDING, page);
        Dispatch<Source> dispatcher = service.createDispatch(qname, Source.class, Service.Mode.MESSAGE);
        Map<String, Object> requestContext = dispatcher.getRequestContext();
        requestContext.put(MessageContext.HTTP_REQUEST_METHOD, "POST");
        Source result = dispatcher.invoke(new StreamSource(new StringReader(data)));
        printSource(result);
    }


    private  void GET(String page, String parameters) {
    	service = Service.create(qname);
		service.addPort(qname, HTTPBinding.HTTP_BINDING, page + "?" + parameters);
		Dispatch<Source> dispatcher = service.createDispatch(qname, Source.class, Service.Mode.MESSAGE);
        Map<String, Object> requestContext = dispatcher.getRequestContext();
        requestContext.put(MessageContext.HTTP_REQUEST_METHOD, "GET");
        Source result = dispatcher.invoke(null);
        printSource(result);
    }


/** Convenience method for printing the source XML to the console
 */
    public  void printSource(Source s) {
        try {
            //System.out.println("============================= Response Received =========================================");
            TransformerFactory factory = TransformerFactory.newInstance();
            Transformer transformer = factory.newTransformer();
            // also print to console
            transformer.transform(s, new StreamResult(System.out));
            //System.out.println("\n=========================================================================================");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public static void main(String argsp[]) {
    	RESTclient client= new RESTclient();
        //client.POST(BASE_URL + SIMPLE_SEARCH_PAGE, simpleSearchParameters);
    	//client.POST(BASE_URL + ADVANCED_SEARCH_PAGE, advancedSearchParameters);
    	String httpParameters = "urn1=" + urn;
        client.GET(BASE_URN_URL + URN_RESOLUTION_PAGE, httpParameters);
    }

}
