async function sendCommand() {
  const command = document.getElementById("input").value;
  const output = document.getElementById("output");
  output.textContent = "⏳ Processando...";

  try {
    const res = await fetch("http://localhost:3000/api/willa", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ command }),
    });
    const data = await res.json();
    output.textContent = data.reply;
  } catch (err) {
    output.textContent = "❌ Erro ao conectar com Willa.";
  }
}
