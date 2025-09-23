// server/index.js
require('dotenv').config();
const express = require('express');
const fetch = require('node-fetch'); // or use openai sdk
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Protect this endpoint with a simple API_TOKEN header (set in client)
const API_TOKEN = process.env.SERVER_API_TOKEN; // generate a strong token and set in flutter client

const requireAuth = (req, res, next) => {
  const token = req.headers['x-server-token'];
  if (!token || token !== API_TOKEN) return res.status(401).json({error: 'unauthorized'});
  next();
};

app.post('/v1/chat', requireAuth, async (req, res) => {
  const { messages, model = 'gpt-4o-mini' } = req.body;
  try {
    // Example using OpenAI REST (adjust to SDK if you prefer)
    const resp = await fetch('https://api.openai.com/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model,
        messages,
        max_tokens: 800
      })
    });
    const data = await resp.json();
    res.json(data);
  } catch (err) {
    console.error(err);
    res.status(500).json({error: 'server_error', detail: err.message});
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server listening on ${PORT}`));
