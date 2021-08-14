package TraceLinkOntologyDBConnector;

import java.io.File;

import org.semanticweb.HermiT.ReasonerFactory;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.reasoner.OWLReasoner;

//This class is designed to read trace link ontology from RDF file using OWLAPI
public class RDFOntology {
	
	//The trace link ontology read from RDF file
	private OWLOntology ontology;
	
	//Constructor: read ontology from local RDF file
	public RDFOntology(File file) throws OWLOntologyCreationException {
		this.ontology = readFromFile(file);
	}
	
	//Constructor: read ontology from web
	public RDFOntology(IRI iri) throws OWLOntologyCreationException {
		this.ontology = readFromWeb(iri);
	}

	public OWLOntology getOntology() {
		return ontology;
	}
	
	public OWLReasoner getReasoner() {
		ReasonerFactory rf = new ReasonerFactory();
		return rf.createReasoner(getOntology());
	}
	
	public OWLDataFactory getDataFactory() {
		return this.getOntology().getOWLOntologyManager().getOWLDataFactory();
	}

	private static OWLOntology readFromFile(File file) throws OWLOntologyCreationException {
		//Read trace link ontology from RDF file
		OWLOntologyManager man = OWLManager.createOWLOntologyManager();
		return man.loadOntologyFromOntologyDocument(file);
	}
	
	private static OWLOntology readFromWeb(IRI iri) throws OWLOntologyCreationException {
		//Read trace link ontology from RDF file
		OWLOntologyManager man = OWLManager.createOWLOntologyManager();
		return man.loadOntologyFromOntologyDocument(iri);
	}

}
