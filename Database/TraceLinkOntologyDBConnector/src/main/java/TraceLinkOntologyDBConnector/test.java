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
			//Print all instances of class Dependency
			IRI iri = IRI.create("http://www.ontorion.com/ontologies/Ontology92f6fe28b5854078a984b0607d68f51e#Dependency");
			ont.getReasoner().getInstances(ont.getDataFactory().getOWLClass(iri)).entities().forEach(System.out::println);
		} catch (OWLOntologyCreationException e) {
			System.out.println("Error: Fail to read tracelink ontology from file. Please check your RDF file.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
