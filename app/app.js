const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    const now = new Date();
    res.send(`<h1>Hello Subi!</h1><p>CI/CD is working! Current time: ${now}</p>`);
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});

