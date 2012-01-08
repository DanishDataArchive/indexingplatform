package dk.dda.indexingplatform.rest;

import static org.junit.Assert.*;
import junit.framework.Assert;

import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectListType;
import org.junit.Ignore;
import org.junit.Test;

import dk.dda.ddi.indexingplatform.advancedsearch.AdvancedSearchParametersDocument;
import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersDocument;
import dk.dda.indexingplatform.util.MetadataBuilder;

public class AdvancedSearchTest extends Testbase {
	String test = "<asp:AdvancedSearchParameters xmlns:sm=\"http://dda.dk/ddi/search-metadata\""
			+ " xmlns:s=\"http://dda.dk/ddi/scope\""
			+ " xmlns:asp=\"http://dda.dk/ddi/advanced-search-parameters\" >"
			+ "<asp:studyId>13794</asp:studyId>"
			+ "<asp:title>kommunale</asp:title>"
			+ "<asp:topicalCoverage>Tillidserhverv</asp:topicalCoverage>"
			+ "<asp:spatialCoverage>national</asp:spatialCoverage>"
			+ "<asp:abstract-purpose>udvalgstilknytning</asp:abstract-purpose>"
			+ "<asp:creator>Søren</asp:creator>"
			+ "<asp:kindOfData>Spørgeskemaundersøgelse</asp:kindOfData>"
			+ "<asp:coverageFrom>2000-08-01</asp:coverageFrom>"
			+ "<asp:coverageTo>2000-12-01</asp:coverageTo>"
			+ "<asp:Variable>STUDIENUMMER</asp:Variable>"
			+ "<asp:QuestionItem>studiesituation</asp:QuestionItem>"
			+ "<sm:SearchMetaData hits-perpage=\"10\" hit-start=\"0\"/>"
			+ "<s:Scope>"
			+ "<s:StudyUnit/>"
			+ "<s:Variable/>"
			+ "<s:QuestionItem/>"
			+ "<s:MultipleQuestionItem/>"
			+ "<s:Universe/>"
			+ "<s:Concept/>"
			+ "<s:Category/>"
			+ "</s:Scope>"
			+ "</asp:AdvancedSearchParameters>";

	@Test
	public void testTest() throws Exception {
		restClient.logQuery = true;
		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.ADVANCED_SEARCH, test);

		Assert.assertTrue("No results!",
				result.getLightXmlObjectList().size() > 0);
	}

	@Test
	public void abstractPurposeTest() throws Exception {
		restClient.logQuery = true;
		AdvancedSearchParametersDocument doc = MetadataBuilder
				.getAdvancedSearchParametersDocument();
		doc.getAdvancedSearchParameters().setAbstractPurpose(
				"udvalgstilknytning");

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.ADVANCED_SEARCH, doc.getAdvancedSearchParameters()
						.xmlText());

		Assert.assertTrue("No results!",
				result.getLightXmlObjectList().size() > 0);
	}

	@Test
	public void topicalCoverageTest() throws Exception {
		restClient.logQuery = true;
		AdvancedSearchParametersDocument doc = MetadataBuilder
				.getAdvancedSearchParametersDocument();
		doc.getAdvancedSearchParameters().setTopicalCoverage("Tillidserhverv");

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.ADVANCED_SEARCH, doc.getAdvancedSearchParameters()
						.xmlText());

		Assert.assertTrue("No results!",
				result.getLightXmlObjectList().size() > 0);
	}
}
