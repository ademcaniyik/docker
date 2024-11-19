// Tech.js

const express = require('express');
const app = express();
const port= 9999;

//GET

app.get('/',(req,res)=>{
    res.send('Dockerfile Node.js çalıştı'); 
    res.setHeader('Content-Type', 'text/plain'); 
    res.statusCode = 200;
});

//LISTEN

app.listen(port,()=>{
    console.log(`http://localhost:${port}`)
    alert(`http://localhost:${port}`)
});


