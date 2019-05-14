const http = require('http');
const config = require('./util/config.js');

const cfg = config("config.json");

console.log(cfg);


http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write('Hello World!');
  res.end();
}).listen(cfg.serverPort);
