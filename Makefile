all:	
	make tests
	make build
	make clean

tests:
	xmllint --noout --schema test-xsds/epp.xsd examples/info-response.xml
	xmllint --noout --schema test-xsds/epp.xsd examples/create-command.xml
	xmllint --noout --schema test-xsds/epp.xsd examples/update-command.xml

build:
	perl -pi -e 's/^(.)/S: \1/' < examples/info-response.xml > examples/info-response.txt
	perl -pi -e 's/^(.)/C: \1/' < examples/create-command.xml > examples/create-command.txt
	perl -pi -e 's/^(.)/C: \1/' < examples/update-command.xml > examples/update-command.txt

	xmllint --xinclude draft-brown-auxcontact.xml.in > draft-brown-auxcontact.xml

	xml2rfc draft-brown-auxcontact.xml draft-brown-auxcontact.txt
	xml2rfc draft-brown-auxcontact.xml draft-brown-auxcontact.html

clean:
	rm -vf examples/*txt
