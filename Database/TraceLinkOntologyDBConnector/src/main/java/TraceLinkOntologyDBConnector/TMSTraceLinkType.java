package TraceLinkOntologyDBConnector;

//Purpose: This class is designed to represent a trace link type in the program
//		The instances of this class are typically created by RDFOntology or TMSDBManager (included in DBOntology objects)
public class TMSTraceLinkType extends TMSTraceLinkObject {

	public TMSTraceLinkType(String iri, String name) {
		super(iri, name);
	}

	public TMSTraceLinkType(String iri) {
		super(iri);
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
