const https = require("https");
const fs = require("fs");

const options = {
	hostname: "localhost",
	port: 4000,
	path: "/",
	method: "GET",
	key: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/output-certs/clients/pdvpix/gateway-hml/mtls-client.key",
	),
	cert: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/output-certs/clients/pdvpix/gateway-hml/mtls-client.crt",
	),
	ca: fs.readFileSync(
		"/home/danielmachado/www/mutual-tls/output-certs/server/pdvpix/mtls-server.crt",
	),
	passphrase: "123456",
};

https
	.request(options, (res) => {
		console.log(`statusCode: ${res.statusCode}`);
		res.on("data", (d) => {
			process.stdout.write(d);
		});
	})
	.end();
