package dk.dda.indexingplatform.rest;

import junit.framework.Assert;

import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectListType;
import org.junit.Test;

import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersDocument;
import dk.dda.indexingplatform.util.MetadataBuilder;

public class SimpleSearchTest extends Testbase {

	@Test
	public void searchStudyId() throws Exception {
		SimpleSearchParametersDocument doc = MetadataBuilder
				.getSimpleSearchParameters();
		String studyId = "13794";
		doc.getSimpleSearchParameters().setSearchString(studyId);
		// System.out.println(doc);

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.SIMPLE_SEARCH, doc.xmlText());

		Assert.assertEquals("Result size not same!", 1, result
				.getLightXmlObjectList().size());
		Assert.assertEquals("Not same id!", studyId, result
				.getLightXmlObjectList().get(0).getId());
		// System.out.println(result.xmlText());
	}

	@Test
	public void searchQuestion() throws Exception {
		SimpleSearchParametersDocument doc = MetadataBuilder
				.getSimpleSearchParameters();
		doc.getSimpleSearchParameters().setSearchString("studienummer");

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.SIMPLE_SEARCH, doc.getSimpleSearchParameters()
						.xmlText());
		
		Assert.assertTrue("No results!", result
				.getLightXmlObjectList().size() > 0);
	}
}
