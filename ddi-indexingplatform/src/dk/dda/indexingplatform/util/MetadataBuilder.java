package dk.dda.indexingplatform.util;

import java.math.BigInteger;

import org.apache.xmlbeans.XmlCursor;
import org.apache.xmlbeans.XmlCursor.TokenType;
import org.apache.xmlbeans.XmlObject;

import dk.dda.ddi.indexingplatform.advancedsearch.AdvancedSearchParametersDocument;
import dk.dda.ddi.indexingplatform.advancedsearch.AdvancedSearchParametersType;
import dk.dda.ddi.indexingplatform.scope.ScopeDocument;
import dk.dda.ddi.indexingplatform.scope.ScopeType;
import dk.dda.ddi.indexingplatform.searchmetadata.SearchMetaDataDocument;
import dk.dda.ddi.indexingplatform.searchmetadata.SearchMetaDataType;
import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersDocument;
import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersType;

public class MetadataBuilder {
	/**
	 * Constructs a basic simple search parameter with full search scope and
	 * -meta data
	 * 
	 * @return simple search parameter
	 */
	public static SimpleSearchParametersDocument getSimpleSearchParameters() {
		SimpleSearchParametersDocument doc = SimpleSearchParametersDocument.Factory
				.newInstance();

		SimpleSearchParametersType type = doc.addNewSimpleSearchParameters();
		type.setScope(getScope());
		type.setSearchMetaData(getSearchMetaData());
		return doc;
	}

	/**
	 * Constructs a basic advanced search parameter with full search scope and
	 * -meta data
	 * 
	 * @return advanced search parameter
	 */
	public static AdvancedSearchParametersDocument getAdvancedSearchParametersDocument() {
		AdvancedSearchParametersDocument doc = AdvancedSearchParametersDocument.Factory
				.newInstance();

		AdvancedSearchParametersType type = doc
				.addNewAdvancedSearchParameters();
		// type.setAbstractPurpose("");
		// type.setCategory("");
		// type.setConcept("");

		// temporal coverage
		// Calendar calFrom = Calendar.getInstance();
		// calFrom.clear();
		// calFrom.set(1970, 0, 0);
		// type.setCoverageFrom(calFrom);
		// Calendar calTo = Calendar.getInstance();
		// type.setCoverageTo(calTo);

		// type.setCreator("");
		// type.setKindOfData("");
		// type.setMultipleQuestionItem("");
		// type.setQuestionItem("");
		// type.setStudyId("");
		// type.setTitle("");
		// type.setTopicalCoverage("");
		// type.setUniverse("");
		// type.setVariable("");

		type.setScope(getScope());
		type.setSearchMetaData(getSearchMetaData());
		return doc;
	}

	/**
	 * Constructs a full search scope
	 * 
	 * @return scope
	 */
	public static ScopeType getScope() {
		ScopeType type = ScopeDocument.Factory.newInstance().addNewScope();

		type.addNewCategory();
		type.addNewConcept();
		type.addNewMultipleQuestionItem();
		type.addNewQuestionItem();
		type.addNewStudyUnit();
		type.addNewUniverse();
		type.addNewVariable();
		return type;
	}

	/**
	 * Constructs search meta data with hits pr. page: 10 and start hit: 1
	 * 
	 * @return search meta data
	 */
	public static SearchMetaDataType getSearchMetaData() {
		SearchMetaDataType type = SearchMetaDataDocument.Factory.newInstance()
				.addNewSearchMetaData();
		type.setHitsPerpage(new BigInteger("10"));
		type.setHitStart(new BigInteger("0"));
		return type;
	}

	public static String getUrn(String id, String version) {
		return "urn:ddi:dk.dda:" + id + ":" + version;
	}

	/**
	 * Retrieve text on a mixed content element
	 * 
	 * @param xmlObject
	 *            to retrieve text from
	 * @return text
	 */
	public static String getTextOnMixedElement(XmlObject xmlObject) {
		if (xmlObject == null) { // guard
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
