package TraceLinkOntologyDBConnector;

import java.io.File;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;

public class test {

	public static void main(String[] args) {
		try {
			//Read trace link ontology from RDF file
			RDFOntology ont = new RDFOntology(new File("testRDF/TraceLinksFullVersion.rdf"));
			//Read test
			System.out.println(ont.getOntology());
			//Print all superclass of class Inter
			System.out.println("\nSuperclass of class Inter: \n");
			IRI iri = IRI.create("http://www.ontorion.com/ontologies/Ontology92f6fe28b5854078a984b0607d68f51e#Inter");
			ont.getReasoner().getSuperClasses(RDFOntology.getDataFactory().getOWLClass(iri)).entities().forEach(System.out::println);
		} catch (OWLOntologyCreationException e) {
			System.out.println("Error: Fail to read tracelink ontology from file. Please check your RDF file.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
//	public static void main(String[] args) {
//		try {
//			//Read trace link ontology from RDF file
//			RDFOntology ont = new RDFOntology(new File("testRDF/TraceLinksFullVersion.rdf"));
//			//Read test
//			System.out.println(ont.getOntology());
//			if (ont.getReasoner().isConsistent()) System.out.println("The trace link ontology is consistant.");
//			else System.out.println("The trace link ontology is not consistant.");
//			//Print all superclass of class Inter
//			System.out.println("\nTypes of named individual derive (Direct): \n");
//			IRI iri = IRI.create("http://www.ontorion.com/ontologies/Ontology92f6fe28b5854078a984b0607d68f51e#Derive");
//			ont.getReasoner().getTypes(RDFOntology.getDataFactory().getOWLNamedIndividual(iri), true).entities().forEach(System.out::println);
//		} catch (OWLOntologyCreationException e) {
//			System.out.println("Error: Failed to read tracelink ontology from file. Please check your RDF file.");
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//	}

}
