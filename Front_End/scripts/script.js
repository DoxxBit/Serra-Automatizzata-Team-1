// Script gestione allarmi per home.html

// Simulazione di allarmi (sostituisci con fetch da API se necessario)
const allarmi = [
  {
    nome: "Temperatura sopra la media",
    messaggio: "Temperatura più alta del solito",
    timestamp: Date.now() - 10 * 60 * 1000 // 10 minuti fa
  },
  {
    nome: "Umidità bassa",
    messaggio: "Umidità sotto il livello minimo",
    timestamp: Date.now() - 3 * 60 * 1000 // 3 minuti fa
  }
];

function mostraAllarmePiuRecente() {
  if (allarmi.length === 0) return;
  // Ordina per timestamp decrescente (più recente per primo)
  const allarme = allarmi.sort((a, b) => b.timestamp - a.timestamp)[0];
  const minutiFa = Math.floor((Date.now() - allarme.timestamp) / 60000);
  const container = document.getElementById('allarme-container');
  if (!container) return;
  container.innerHTML = `
    <div class="flex items-center gap-4 bg-[#111b22] px-4 min-h-[72px] py-2 justify-between">
      <div class="flex items-center gap-4">
        <div class="text-white flex items-center justify-center rounded-lg bg-[#243947] shrink-0 size-12" data-icon="Thermometer" data-size="24px" data-weight="regular">
          <svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" fill="currentColor" viewBox="0 0 256 256">
            <path d="M212,56a28,28,0,1,0,28,28A28,28,0,0,0,212,56Zm0,40a12,12,0,1,1,12-12A12,12,0,0,1,212,96Zm-84,57V88a8,8,0,0,0-16,0v65a32,32,0,1,0,16,0Zm-8,47a16,16,0,1,1,16-16A16,16,0,0,1,120,200Zm40-66V48a40,40,0,0,0-80,0v86a64,64,0,1,0,80,0Zm-40,98a48,48,0,0,1-27.42-87.4A8,8,0,0,0,96,138V48a24,24,0,0,1,48,0v90a8,8,0,0,0,3.42,6.56A48,48,0,0,1,120,232Z"></path>
          </svg>
        </div>
        <div class="flex flex-col justify-center">
          <p class="text-white text-base font-medium leading-normal line-clamp-1">
            ${allarme.nome}
          </p>
          <p class="text-[#93b3c8] text-sm font-normal leading-normal line-clamp-2">
            ${allarme.messaggio}
          </p>
        </div>
      </div>
      <div class="shrink-0">
        <p class="text-[#93b3c8] text-sm font-normal leading-normal">${minutiFa} min fa</p>
      </div>
    </div>
  `;
}

document.addEventListener('DOMContentLoaded', () => {
  mostraAllarmePiuRecente();
  setInterval(mostraAllarmePiuRecente, 60000); // aggiorna ogni minuto
});
