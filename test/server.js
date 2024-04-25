const https = require("https");
const fs = require("fs");

const options = {
	// key: fs.readFileSync(
	// 	"/home/danielmachado/www/mutual-tls/scripts-server/output/teste.pdvpix.com.br.key.pem",
	// ),
	// cert: fs.readFileSync(
	// 	"/home/danielmachado/www/mutual-tls/scripts-server/output/teste.pdvpix.com.br.cert.pem",
	// ),
	ca: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/ca/intermediate/certs/ca-chain.cert.pem",
	),
	passphrase: "pdv@KeyPdv-6851Yy@hml",
	requestCert: true,
	rejectUnauthorized: true,
	ciphers: "DEFAULT:@SECLEVEL=0",
	minVersion: "TLSv1.3",
	// maxVersion: "TLSv1.2",
	// secureProtocol: "TLSv1_3_method",
};

https
	.createServer(options, (req, res) => {
		res.writeHead(200);
		res.end("Teste Certificados");
	})
	.listen(4000);
