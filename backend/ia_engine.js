// backend/ia_engine.js
import fetch from "node-fetch";

export async function askWilla(command) {
  const response = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
    },
    body: JSON.stringify({
      model: "gpt-4o-mini", // ou gpt-5 quando disponível
      messages: [{ role: "user", content: command }],
    }),
  });

  const data = await response.json();
  return data.choices?.[0]?.message?.content || "⚠️ Sem resposta.";
}
