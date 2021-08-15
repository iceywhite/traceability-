package TraceLinkOntologyDBConnector;

import java.io.File;

import org.semanticweb.HermiT.ReasonerFactory;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.reasoner.OWLReasoner;

// Purpose: This class is designed to read trace link ontology from RDF file using OWLAPI
public class RDFOntology {

	private static OWLOntologyManager ontManager = OWLManager.createOWLOntologyManager();
	private static OWLDataFactory df = ontManager.getOWLDataFactory();

	private OWLOntology ontology; // The trace link ontology read from RDF file
	private OWLReasoner reasoner;

	// Constructor: read ontology from local RDF file
	public RDFOntology(File file) throws OWLOntologyCreationException {
		this.ontology = readFromFile(file);
		setReasoner();
	}

	// Constructor: read ontology from web
	public RDFOntology(IRI iri) throws OWLOntologyCreationException {
		this.ontology = readFromWeb(iri);
		setReasoner();
	}

	// Creation method: from file
	public static RDFOntology loadFrom(File file) throws OWLOntologyCreationException {
		return new RDFOntology(file);
	}

	// Creation method: from web
	public static RDFOntology loadFrom(IRI iri) throws OWLOntologyCreationException {
		return new RDFOntology(iri);
	}

	public static OWLOntologyManager getOWLOntologyManager() {
		return ontManager;
	}

	public static OWLDataFactory getDataFactory() {
		return df;
	}

	public OWLOntology getOntology() {
		return ontology;
	}
	
	public OWLReasoner getReasoner() {
		return reasoner;
	}
	
	// Flush the reasoner (to get the latest change of the ontology)
	public void flushReasoner() {
		reasoner.flush();
	}
	
	
	public void setReasoner() {
		this.reasoner = getNewReasoner();
	}
	
	// Get a new reasoner of the ontology
	private OWLReasoner getNewReasoner() {
		ReasonerFactory rf = new ReasonerFactory();
		return rf.createReasoner(getOntology());
	}

	// Read trace link ontology from RDF file
	private static OWLOntology readFromFile(File file) throws OWLOntologyCreationException {
		return ontManager.loadOntologyFromOntologyDocument(file);
	}

	// Read trace link ontology from web identified by iri
	private static OWLOntology readFromWeb(IRI iri) throws OWLOntologyCreationException {
		return ontManager.loadOntologyFromOntologyDocument(iri);
	}
	
	//This main method is for testing
	public static void main(String[] args) {
		try {
			//Read trace link ontology from RDF file
			RDFOntology ont = new RDFOntology(new File("testRDF/TraceLinksFullVersion.rdf"));
			//Read test
			System.out.println(ont.getOntology());
			//Print all instances of class Dependency
			System.out.println("\nInstances of class Dependency: \n");
			IRI iri = IRI.create("http://www.ontorion.com/ontologies/Ontology92f6fe28b5854078a984b0607d68f51e#Dependency");
			ont.getReasoner().getInstances(RDFOntology.getDataFactory().getOWLClass(iri)).entities().forEach(System.out::println);
		} catch (OWLOntologyCreationException e) {
			System.out.println("Error: Fail to read tracelink ontology from file. Please check your RDF file.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
