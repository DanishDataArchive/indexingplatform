package dk.dda.indexingplatform.util;

public enum CustomListElement {
	STUDY_UNIT("StudyUnit"), CATEGORY("Category"), DOMAIN_TYPE("Domain_Type"), REPRESENTATION_TYPE("RepresentationType");
	
	private String type;

	private CustomListElement(String type) {
		this.type = type;
	}

	public String getType() {
		return type;
	}
	
	public static CustomListElement getCustomListElement(String elementName)
			throws Exception {
		for (int i = 0; i < CustomListElement.values().length; i++) {
			CustomListElement elementType = CustomListElement.values()[i];
			if (elementType.getType().equals(elementName)) {
				return elementType;
			}
		}
		// not found
		Exception e = new Exception("Not found: "+elementName);
		throw e;
	}
}
