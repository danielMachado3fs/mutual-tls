const https = require("https");
const fs = require("fs");

const options = {
	cert: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/output-certs/server/pdvpix/mtls-server.crt",
	),
	key: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/output-certs/server/pdvpix/mtls-server.key",
	),
	ca: [
		fs.readFileSync(
			"/home/danielmachado/www/mutual-tls/output-certs/clients/pdvpix/gateway-hml/mtls-client.crt",
		),
	],
	passphrase: "123456",
	requestCert: true,
	rejectUnauthorized: true,
};

https
	.createServer(options, (req, res) => {
		res.writeHead(200);
		res.end("Teste Certificados");
	})
	.listen(4000);
