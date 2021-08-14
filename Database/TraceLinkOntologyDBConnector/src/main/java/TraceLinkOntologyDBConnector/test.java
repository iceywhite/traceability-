package TraceLinkOntologyDBConnector;

import java.io.File;

import org.semanticweb.owlapi.model.OWLOntologyCreationException;

public class test {

	public static void main(String[] args) {
		try {
			RDFOntology ont = new RDFOntology(new File("testRDF/TraceLinksFullVersion.rdf"));
			System.out.println(ont.getOntology());
		} catch (OWLOntologyCreationException e) {
			System.out.println("Error: Fail to read tracelink ontology from file. Please check your RDF file.");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
