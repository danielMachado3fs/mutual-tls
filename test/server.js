const https = require("https");
const fs = require("fs");

const options = {
	key: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/scripts-server/output/server.com.br.key.pem",
	),
	cert: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/scripts-server/output/server.com.br.cert.pem",
	),
	ca: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/certs/ca-chain.cert.pem",
	),
	passphrase: "pass@key",
	requestCert: true,
	rejectUnauthorized: true,
};

https
	.createServer(options, (req, res) => {
		res.writeHead(200);
		res.end("Teste Certificados");
	})
	.listen(4000);
