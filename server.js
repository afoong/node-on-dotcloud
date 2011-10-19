var http = require('http');

process.on('SIGTERM', function () {
    console.log('Got SIGTERM exiting...');
    process.exit(0);
});

http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Hello World\n');
}).listen(process.env['PORT_WWW'], "0.0.0.0");
