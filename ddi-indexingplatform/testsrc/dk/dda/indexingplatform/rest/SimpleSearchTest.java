package dk.dda.indexingplatform.rest;

import junit.framework.Assert;

import org.ddialliance.ddieditor.model.lightxmlobject.CustomListType;
import org.ddialliance.ddieditor.model.lightxmlobject.CustomType;
import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectListType;
import org.ddialliance.ddieditor.model.lightxmlobject.LightXmlObjectType;
import org.junit.Test;

import dk.dda.ddi.indexingplatform.simplesearch.SimpleSearchParametersDocument;
import dk.dda.indexingplatform.util.CustomListElement;
import dk.dda.indexingplatform.util.MetadataBuilder;

public class SimpleSearchTest extends Testbase {

	@Test
	public void searchStudyId() throws Exception {
		SimpleSearchParametersDocument doc = MetadataBuilder
				.getSimpleSearchParameters();
		String studyId = "13794";
		doc.getSimpleSearchParameters().setSearchString(studyId);

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.SIMPLE_SEARCH, doc.xmlText());

		Assert.assertEquals("Result size not same!", 1, result
				.getLightXmlObjectList().size());
		Assert.assertEquals("Not same id!", studyId, result
				.getLightXmlObjectList().get(0).getId());
	}

	@Test
	public void searchStudyUnitTitle() throws Exception {
		SimpleSearchParametersDocument doc = MetadataBuilder
				.getSimpleSearchParameters();
		doc.getSimpleSearchParameters().setSearchString("karriereforløb");

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.SIMPLE_SEARCH, doc.getSimpleSearchParameters()
						.xmlText());

		Assert.assertTrue("No results!",
				result.getLightXmlObjectList().size() > 0);

		for (LightXmlObjectType lightXmlObject : result.getLightXmlObjectList()) {
			for (CustomListType customList : lightXmlObject.getCustomListList()) {
				if (CustomListElement
						.getCustomListElement(customList.getType()).equals(
								CustomListElement.STUDY_UNIT)) {
					for (CustomType custom : customList.getCustomList()) {
						if (custom.getOption().equals("id")
								&& MetadataBuilder
										.getTextOnMixedElement(custom).equals(
												"2482")) {
							return;
						}
					}
				}
			}
		}
		Assert.fail("StudyUnit not found!");
	}
	
	@Test
	public void searchQuestionItem() throws Exception {
//		restClient.logQuery=true;
		SimpleSearchParametersDocument doc = MetadataBuilder
				.getSimpleSearchParameters();
		doc.getSimpleSearchParameters().setSearchString("karriere");

		LightXmlObjectListType result = restClient.getAsLightXmlObject(
				RestTarget.SIMPLE_SEARCH, doc.getSimpleSearchParameters()
						.xmlText());

		Assert.assertTrue("No results!",
				result.getLightXmlObjectList().size() > 0);
		int count =0;
		for (LightXmlObjectType lightXmlObject : result.getLightXmlObjectList()) {
			if (lightXmlObject.getElement().equals("QuestionItem")) {
				count++;
			}
		}
		Assert.assertEquals("Not exact no of question items", 2, count);
	}
}
