const https = require("https");
const fs = require("fs");

const options = {
	key: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/private/gateway.appmarketing.com.br.key.pem",
	),
	cert: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/certs/gateway.appmarketing.com.br.cert.pem",
	),
	ca: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/certs/ca-chain.cert.pem",
		// "/home/appmarketing/www/mutual-tls/ca/intermediate/certs/intermediate-ca.cert.pem",
	),
	passphrase: "appmarketing@gateway",
	requestCert: true,
	rejectUnauthorized: true,
};

https
	.createServer(options, (req, res) => {
		res.writeHead(200);
		res.end("Teste Certificados");
	})
	.listen(443);
