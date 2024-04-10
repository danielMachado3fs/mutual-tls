const https = require("https");
const fs = require("fs");

const options = {
	hostname: "localhost",
	port: 4000,
	path: "/",
	method: "GET",
	key: fs.readFileSync("../ca/intermediate/private/client.key.pem"),
	cert: fs.readFileSync("../ca/intermediate/certs/client.cert.pem"),
	ca: fs.readFileSync("../ca/intermediate/certs/ca-chain.cert.pem"),
	passphrase: "789789",
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
