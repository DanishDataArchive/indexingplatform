package dk.dda.indexingplatform.rest;

/**
 * Enumeration of rest queries
 */
public enum RestTarget {
	SIMPLE_SEARCH("simple-search.xquery"), ADVANCED_SEARCH(
			"advanced-search.xquery"), URN_RESOLVE("urn-resolution.xquery");
	
	private String query;

	private RestTarget(String query) {
		this.query = query;
	}

	public String getQuery() {
		return query;
	}
}
