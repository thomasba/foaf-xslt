example.rdf: example.ttl
	rapper -i turtle -o rdfxml-abbrev example.ttl > example.rdf
	sed -i 's/\(<?xml [^>]*?>\)/\1\n<?xml-stylesheet type="text\/xsl" href="..\/foaf.xslt"?>/' example.rdf
