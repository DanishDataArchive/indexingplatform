package dk.dda.indexingplatform.rest;


import org.ddialliance.ddi3.xml.xmlbeans.datacollection.QuestionItemDocument;
import org.ddialliance.ddi3.xml.xmlbeans.datacollection.QuestionItemType;
import org.ddialliance.ddi3.xml.xmlbeans.reusable.IdentifiedStructuredStringType;
import org.ddialliance.ddi3.xml.xmlbeans.studyunit.AbstractDocument;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;

import dk.dda.indexingplatform.util.MetadataBuilder;

public class UrnTest extends Testbase {
	@Test
	public void versionableUrn() throws Exception {
		String id = "quei-11f628da-15b3-4140-8735-a9811bddb733";
		String result = 
				restClient.getUrn(MetadataBuilder.getUrn(
				id, "1.0.0"));		
		QuestionItemType type = QuestionItemDocument.Factory.parse(result).getQuestionItem();
		Assert.assertEquals("Not same id!", id, type.getId());
	}
	
	@Test
	public void identifiableUrn() throws Exception {
		String id = "abst-449ad130-d802-47b5-bec9-50be68aba742";
		String result = 
				restClient.getUrn(MetadataBuilder.getUrn(
				id, "1.0.0"));		
		IdentifiedStructuredStringType type = AbstractDocument.Factory.parse(result).getAbstract();
		Assert.assertEquals("Not same id!", id, type.getId());
		System.out.println(MetadataBuilder.getTextOnMixedElement(type.getContent()));
	}
}
