#!/usr/bin/env node

console.log('🐳 Multi-stage build app starting...');
console.log('Node version:', process.version);
console.log('Platform:', process.platform);
console.log('PID:', process.pid);

const http = require('http');

const server = http.createServer((req, res) => {
    if (req.url === '/health') {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end('OK');
    } else {
        res.writeHead(200, { 'Content-Type': 'text/plain' });
        res.end('Hello from multi-stage Docker build!');
    }
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
