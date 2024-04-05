const https = require("https");
const fs = require("fs");

const options = {
	hostname: "localhost",
	port: 443,
	path: "/",
	method: "GET",
	key: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/private/teste.americavistos.com.br.key.pem",
	),
	cert: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/certs/teste.americavistos.com.br.cert.pem",
	),
	ca: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/ca/intermediate/certs/ca-chain.cert.pem",
		// "/home/appmarketing/www/mutual-tls/ca/intermediate/csr/gateway.appmarketing.com.br.csr.pem",
	),
	passphrase: "america@cert",
	rejectUnauthorized: true,
};

https
	.request(options, (res) => {
		console.log(`statusCode: ${res.statusCode}`);
		res.on("data", (d) => {
			process.stdout.write(d);
		});
	})
	.end();
