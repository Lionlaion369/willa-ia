// backend/server.js
import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import dotenv from "dotenv";
import { askWilla } from "./ia_engine.js";

dotenv.config();
const app = express();
app.use(cors());
app.use(bodyParser.json());

// API principal
app.post("/api/willa", async (req, res) => {
  const { command } = req.body;
  try {
    const reply = await askWilla(command);
    res.json({ reply });
  } catch (error) {
    console.error("❌ Erro IA:", error);
    res.status(500).json({ error: "Erro ao processar comando" });
  }
});

app.listen(3000, () => {
  console.log("🚀 Super Willa Backend rodando em http://localhost:3000");
});
