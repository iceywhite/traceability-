package TraceLinkOntologyDBConnector;

public class TMSTraceLinkObject {

	String iri;
	String name;
	
	protected TMSTraceLinkObject(String iri) {
		this.iri = iri;
		setNameDefault();
	}
	
	protected TMSTraceLinkObject(String iri, String name) {
		this.iri = iri;
		this.name = name;
	}

	public String getIri() {
		return iri;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDefaultName() {
		return formatName(iri.substring(iri.lastIndexOf("#")));
	}

	public void setNameDefault() {
		this.name = getDefaultName();
	}

	private static String formatName(String name) {
		// If the input name is empty or has a length = 1 -> return the input name
		if (name.length() <= 1)
			return name;
		// If the input name is started by a lower case letter (incorrect format) ->
		// return the input name
		else if (Character.isLowerCase(name.charAt(0)))
			return name;
		StringBuilder str = new StringBuilder(name);
		// Add '-' before every upper case letter except the first character
		for (int i = 1; i < str.length(); i++) {
			if (Character.isUpperCase(str.charAt(i))) {
				str.insert(i++, '-');
			}
		}
		// Return result
		return str.toString();

	}

	public static void main(String[] args) {
		System.out.println(formatName("DependOn"));

	}

}
