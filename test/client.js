const https = require("https");
const fs = require("fs");

const options = {
	hostname: "localhost",
	port: 4000,
	path: "/",
	method: "GET",
	key: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/scripts-client/output/client.com.br.key.pem",
	),
	cert: fs.readFileSync(
		"/home/appmarketing/www/mutual-tls/scripts-client/output/client.com.br.cert.pem",
	),
	passphrase: "pass@key",
};

https
	.request(options, (res) => {
		console.log(`statusCode: ${res.statusCode}`);
		res.on("data", (d) => {
			process.stdout.write(d);
		});
	})
	.end();
