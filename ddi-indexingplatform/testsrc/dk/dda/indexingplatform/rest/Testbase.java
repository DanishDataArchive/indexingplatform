package dk.dda.indexingplatform.rest;

import org.apache.xmlbeans.XmlException;
import org.junit.BeforeClass;

import dk.dda.ddi.indexingplatform.resultmetadata.ResultMetaDataDocument;
import dk.dda.ddi.indexingplatform.resultmetadata.ResultMetaDataType;

public class Testbase {
	static RestClient restClient;

	@BeforeClass
	public static void setUp() {
		restClient = new RestClient();
	}

	public ResultMetaDataType getResultMetaData(String result)
			throws XmlException {
		return ResultMetaDataDocument.Factory.parse(result).getResultMetaData();
	}
}
