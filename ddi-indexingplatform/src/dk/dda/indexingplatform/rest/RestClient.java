package dk.dda.indexingplatform.rest;

import java.io.StringReader;
import java.io.StringWriter;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.Map;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import javax.xml.ws.handler.MessageContext;
import javax.xml.ws.http.HTTPBinding;

import org.apache.xmlbeans.XmlException;
import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectListDocument;
import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectListType;

public class RestClient {
	private static final String BASE_URL = "http://localhost:8080/exist/rest/db/dda/rest/";
	private static final QName qname = new QName("", "");
	private static final String USER = "admin";
	private static final String PASSWORD = "";
public boolean logQuery = false;
	private Service service;

	public RestClient() {
		Authenticator.setDefault(new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(USER, PASSWORD.toCharArray());
			}
		});
	}

	public Source get(RestTarget restTarget, String pox) {
		// service
		service = Service.create(qname);
		service.addPort(qname, HTTPBinding.HTTP_BINDING,
				BASE_URL + restTarget.getQuery());
		Dispatch<Source> dispatcher = service.createDispatch(qname,
				Source.class, Service.Mode.MESSAGE);

		// context
		// TODO change to GET!
		Map<String, Object> requestContext = dispatcher.getRequestContext();
		requestContext.put(MessageContext.HTTP_REQUEST_METHOD, "POST");

		// dispatch
		Source result = dispatcher.invoke(new StreamSource(
				new StringReader(pox)));
		return result;
	}

	public String getReturnString(RestTarget restTarget, String pox)
			throws TransformerException {
		return transform(get(restTarget, pox));
	}

	public LightXmlObjectListType getAsLightXmlObject(RestTarget restTarget,
			String pox) throws TransformerException, XmlException {
		return LightXmlObjectListDocument.Factory.parse(
				transform(get(restTarget, pox))).getLightXmlObjectList();
	}

	private String transform(Source source) throws TransformerException {
		StringWriter result = new StringWriter();

		Transformer transformer = TransformerFactory.newInstance()
				.newTransformer();
		transformer.transform(source, new StreamResult(result));
		
		if (logQuery) {
			System.out.println(result.toString());
		}
		return result.toString();
	}
}
