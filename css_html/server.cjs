const path = require('path');
const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.static(path.join(__dirname, 'concepts')));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'concepts', 'index.html'));
});

app.get('/:concept', (req, res) => {
  const concept = req.params.concept;
  res.sendFile(path.join(__dirname, 'concepts', `${concept}.html`));
});

app.listen(PORT, () => {
  console.log(`serving index.html at http://localhost:${PORT}`);
});
