package dk.dda.indexingplatform.util;

import java.math.BigInteger;

import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlCursor.TokenType;

import dk.dda.ddi.indexingplatform.scope.ScopeType;
import dk.dda.ddi.indexingplatform.searchmetadata.SearchMetaDataType;
import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersDocument;
import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersType;

public class MetadataBuilder {
	/**
	 * Constructs a simple search parameter with hits pr page: 10 and start hit: 1 
	 * @return simple search parameter
	 */
	public static SimpleSearchParametersDocument getSimpleSearchParameters() {
		SimpleSearchParametersDocument doc = SimpleSearchParametersDocument.Factory
				.newInstance();
		SimpleSearchParametersType type = doc.addNewSimpleSearchParameters();

		ScopeType scope = type.addNewScope();
		scope.addNewCategory();
		scope.addNewConcept();
		scope.addNewMultipleQuestionItem();
		scope.addNewQuestionItem();
		scope.addNewStudyUnit();
		scope.addNewUniverse();
		scope.addNewVariable();

		SearchMetaDataType searchMetaData = type.addNewSearchMetaData();
		searchMetaData.setHitsPerpage(new BigInteger("10"));
		searchMetaData.setHitStart(new BigInteger("0"));

		return doc;
	}
	
	/**
	 * Retrieve text on a mixed content element
	 * 
	 * @param xmlObject
	 *            to retrieve text from
	 * @return text
	 */
	public static String getTextOnMixedElement(XmlObject xmlObject) {
		if (xmlObject==null) { // guard
			return "";
		}
		
		XmlCursor xmlCursor = xmlObject.newCursor();
		// toLastAttribute does not skip namespaces - so continue
		// until none empty TEXT token
		xmlCursor.toLastAttribute();
		TokenType token = xmlCursor.toNextToken();
		if (token.equals(TokenType.END) || token.equals(TokenType.ENDDOC)) {
			return "";
		}

		String text = null;
		try {
			text = xmlCursor.getTextValue().trim();
		} catch (IllegalMonitorStateException e) {
			return "";
		}

		while (!token.equals(XmlCursor.TokenType.TEXT)
				|| (token.equals(XmlCursor.TokenType.TEXT) && text.length() == 0)) {
			token = xmlCursor.toNextToken();
			if (token.equals(XmlCursor.TokenType.END)) {
				return "";
			}
			text = xmlCursor.getTextValue().trim();
		}
		xmlCursor.dispose();
		return text;
	}
	
	/**
	 * Set text on a mixed content element at first position after attributs
	 * 
	 * @param xmlObject
	 *            to set text on
	 * @param text
	 *            to set
	 * @return altered xml object
	 */
	public static XmlObject setTextOnMixedElement(XmlObject xmlObject,
			String text) {
		XmlCursor xmlCursor = xmlObject.newCursor();

		// insert new text
		xmlCursor.toFirstContentToken();
		xmlCursor.insertChars(text);

		// remove old text
		String result = xmlCursor.getChars();
		xmlCursor.removeChars(result.length());
		xmlCursor.dispose();

		return xmlObject;
	}
}
