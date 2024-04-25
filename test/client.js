const https = require("https");
const fs = require("fs");

const options = {
	hostname: "localhost",
	port: 4000,
	path: "/",
	method: "GET",
	key: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/scripts-client/output/gateway-hml.appmarketing.com.br.key.pem",
	),
	cert: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/scripts-client/output/gateway-hml.appmarketing.com.br.cert.pem",
	),
	passphrase: "gateway@KeyPdv-9Md0g8@hml",
	ciphers: "DEFAULT:@SECLEVEL=0",
	// minVersion: "TLSv1.2",
	// ca: fs.readFileSync(
	// 	"/home/danielmachado/www/mutual-tls/ca/intermediate/certs/ca-chain.cert.pem",
	// ),
};

https
	.request(options, (res) => {
		console.log(`statusCode: ${res.statusCode}`);
		res.on("data", (d) => {
			process.stdout.write(d);
		});
	})
	.end();
