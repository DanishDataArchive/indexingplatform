package dk.dda.indexingplatform.util;

import java.math.BigInteger;

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
}
