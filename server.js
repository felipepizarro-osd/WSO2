const express = require('express');
const app = express();
const path = require('path');

const filesPath = '/Users/felipepizarro/Documents/software';

app.get('/download/:filename', (req, res) => {
    const filename = req.params.filename;
    res.download(path.join(filesPath, filename));
});

app.listen(8000, () => {
    console.log('Server is running on port 8000');
});
