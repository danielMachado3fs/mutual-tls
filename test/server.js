const https = require("https");
const fs = require("fs");

const options = {
	key: fs.readFileSync("/ca/intermediate/private/server.key.pem"),
	cert: fs.readFileSync("/ca/intermediate/certs/server.cert.pem"),
	ca: fs.readFileSync("/ca/intermediate/certs/ca-chain.cert.pem"),
	passphrase: "456456",
	requestCert: true,
	rejectUnauthorized: true,
};

https
	.createServer(options, (req, res) => {
		res.writeHead(200);
		res.end("Teste Certificados");
	})
	.listen(4000);
