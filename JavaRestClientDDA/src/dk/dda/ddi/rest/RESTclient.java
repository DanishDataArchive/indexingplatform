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
import java.util.Map;
import java.net.Authenticator;
import java.net.PasswordAuthentication;

/**
 * @author Kemal Pajevic
 */
public class RESTclient {
	
	private static final String BASE_URL = "http://localhost:8080/exist/rest/db/dda/rest/";
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

   public RESTclient() {
	   Authenticator.setDefault(new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USER, PASSWORD.toCharArray());
			}
		});
	
    }

    private void POST() {
		service = Service.create(qname);
		service.addPort(qname, HTTPBinding.HTTP_BINDING, BASE_URL + "simple-search.xquery");
        Dispatch<Source> dispatcher = service.createDispatch(qname, Source.class, Service.Mode.MESSAGE);
        Map<String, Object> requestContext = dispatcher.getRequestContext();
        requestContext.put(MessageContext.HTTP_REQUEST_METHOD, "POST");
        Source result = dispatcher.invoke(new StreamSource(new StringReader(simpleSearchParameters)));
        printSource(result);
    }


//    private  void GET() {
//		service = Service.create(qname);
//		service.addPort(qname, HTTPBinding.HTTP_BINDING, BASE_URL + "simple-search.xquery");
//		Dispatch<Source> dispatcher = service.createDispatch(qname, Source.class, Service.Mode.MESSAGE);
//        Map<String, Object> requestContext = dispatcher.getRequestContext();
//        requestContext.put(MessageContext.HTTP_REQUEST_METHOD, "GET");
//        Source result = dispatcher.invoke(null);
//        printSource(result);
//    }


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
        client.POST();
        //client.GET();
    }

}
