package dk.dda.indexingplatform.rest;


import org.ddialliance.ddi3.xml.xmlbeans.datacollection.QuestionItemDocument;
import org.ddialliance.ddi3.xml.xmlbeans.datacollection.QuestionItemType;
import org.ddialliance.ddi3.xml.xmlbeans.reusable.IdentifiedStructuredStringType;
import org.ddialliance.ddi3.xml.xmlbeans.studyunit.AbstractDocument;
import org.junit.Assert;
import org.junit.Test;

import dk.dda.indexingplatform.util.MetadataBuilder;

public class UrnTest extends Testbase {
	@Test
	public void dublicateAbstractInDDAUrnCollection() throws Exception {
		//Assert.fail("400 error code returned when same study unit file is loaded into collection!");
		// 
		String id = "abst-7889222a-5069-48a7-a4ac-b111d4f1bb51";
		String result = 
				restClient.getUrn(MetadataBuilder.getUrn(
				id, "1.0.0"));		

		IdentifiedStructuredStringType type = AbstractDocument.Factory.parse(result).getAbstract();
		Assert.assertEquals("Not same id!", id, type.getId());
		System.out.println(MetadataBuilder.getTextOnMixedElement(type.getContent()));	
	}

	@Test
	public void dublicateQuestionItemInDDAUrnCollection() throws Exception {
		//Assert.fail("400 error code returned when same study unit file is loaded into collection!");
		// 
		String id = "quei-13b3ae4b-0c86-4813-9276-7684d4441e45";
		String result=null;
				
				try {
					result = restClient.getUrn(MetadataBuilder.getUrn(
					id, "1.0.0"));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}		

		QuestionItemType type = QuestionItemDocument.Factory.parse(result).getQuestionItem();
		Assert.assertEquals("Not same id!", id, type.getId());	
	}
	
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
