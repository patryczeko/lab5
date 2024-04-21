const http = require('http');
const os = require('os');

const PORT = process.env.PORT || 3000;
const VERSION = process.env.VERSION || '1.0.0';

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });

  const serverIP = req.connection.localAddress;
  const serverHostname = os.hostname();

  res.end(`Adres IP serwera: ${serverIP}\nNazwa serwera: ${serverHostname}\nWersja aplikacji: ${VERSION}\n`);
});

server.listen(PORT, () => {
  console.log(`Serwer uruchomiony na porcie ${PORT}`);
});