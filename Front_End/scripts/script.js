// Script gestione allarmi per home.html

// Simulazione di allarmi (sostituisci con fetch da API se necessario)
const allarmi = [
  {
    nome: "Temperatura sopra la media",
    messaggio: "Temperatura più alta del solito",
    valore: 28, // Celsius
    timestamp: Date.now() - 10 * 60 * 1000 // 10 minuti fa
  },
  {
    nome: "Umidità bassa",
    messaggio: "Umidità sotto il livello minimo",
    valore: 22, // Celsius
    timestamp: Date.now() - 3 * 60 * 1000 // 3 minuti fa
  }
];

function celsiusToFahrenheit(c) {
  return Math.round((c * 9/5 + 32) * 10) / 10;
}
function fahrenheitToCelsius(f) {
  return Math.round(((f - 32) * 5/9) * 10) / 10;
}

function mostraAllarmePiuRecente() {
  if (allarmi.length === 0) return;
  const unit = getUnit();
  const allarme = allarmi.sort((a, b) => b.timestamp - a.timestamp)[0];
  const minutiFa = Math.floor((Date.now() - allarme.timestamp) / 60000);
  const container = document.getElementById('allarme-container');
  if (!container) return;
  let valore = allarme.valore;
  let simbolo = '°C';
  if (unit === 'F') {
    valore = celsiusToFahrenheit(valore);
    simbolo = '°F';
  }
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
            ${allarme.messaggio} (${valore}${simbolo})
          </p>
        </div>
      </div>
      <div class="shrink-0">
        <p class="text-[#93b3c8] text-sm font-normal leading-normal">${minutiFa} min fa</p>
      </div>
    </div>
  `;
}

// --- DYNAMIC TEMPERATURE SETTER FOR HOME PAGE (DRY) ---
let homeTempsC = [24, 22]; // [current, weekly] default/base values in Celsius

function setHomeTemperature(index, temp, unit = 'C') {
  // index: 0 = current, 1 = weekly
  homeTempsC[index] = unit === 'F' ? fahrenheitToCelsius(temp) : temp;
  aggiornaTemperatureHome();
}

function aggiornaTemperatureHome() {
  const unit = getUnit();
  const tempEls = document.querySelectorAll('#convert-temp');
  tempEls.forEach((el, i) => {
    let temp = homeTempsC[i] || 22;
    let simbolo = '°C';
    if (unit === 'F') {
      temp = celsiusToFahrenheit(temp);
      simbolo = '°F';
    }
    el.textContent = temp + simbolo;
  });
}

// --- HISTORY PAGE TEMPERATURE UNIT HANDLING ---
let historyTempsC = [22, 22]; // [info, weekly] default/base values in Celsius

function setHistoryTemperature(index, temp, unit = 'C') {
  // index: 0 = info, 1 = weekly
  historyTempsC[index] = unit === 'F' ? fahrenheitToCelsius(temp) : temp;
  aggiornaTemperatureHistory();
}

function aggiornaTemperatureHistory() {
  const unit = getUnit();
  const tempEls = document.querySelectorAll('#convert-temp');
  tempEls.forEach((el, i) => {
    let temp = historyTempsC[i] || 22;
    let simbolo = '°C';
    if (unit === 'F') {
      temp = celsiusToFahrenheit(temp);
      simbolo = '°F';
    }
    el.textContent = temp + simbolo;
  });
}

// --- TOGGLE BUTTONS & UNIT HANDLING FOR SETTINGS PAGE (INTEGRATO) ---
function setUnitButtons(unit) {
  const btnC = document.getElementById('btn-celsius');
  const btnF = document.getElementById('btn-fahrenheit');
  if (!btnC || !btnF) return;
  btnC.classList.remove('bg-[--color-accent]', 'text-white');
  btnF.classList.remove('bg-[--color-accent]', 'text-white');
  if (unit === 'C') {
    btnC.classList.add('bg-[--color-accent]', 'text-white');
  } else {
    btnF.classList.add('bg-[--color-accent]', 'text-white');
  }
}
function getUnit() {
  const u = localStorage.getItem('unit');
  if (!u) return 'C';
  if (u === 'fahrenheit' || u === 'F') return 'F';
  return 'C';
}
function updateUnitUI() {
  setUnitButtons(getUnit());
}
function setupUnitToggle() {
  const btnC = document.getElementById('btn-celsius');
  const btnF = document.getElementById('btn-fahrenheit');
  if (!btnC || !btnF) return;
  updateUnitUI();
  btnC.addEventListener('click', function() {
    if (getUnit() === 'C') return;
    localStorage.setItem('unit', 'C');
    updateUnitUI();
  });
  btnF.addEventListener('click', function() {
    if (getUnit() === 'F') return;
    localStorage.setItem('unit', 'F');
    updateUnitUI();
  });
  window.addEventListener('storage', (e) => {
    if (e.key === 'unit') updateUnitUI();
  });
}
if (window.location.pathname.includes('settings.html')) {
  document.addEventListener('DOMContentLoaded', setupUnitToggle);
}

// Detect if we are on history.html
if (window.location.pathname.includes('history.html')) {
  document.addEventListener('DOMContentLoaded', () => {
    aggiornaTemperatureHistory();
  });
  window.addEventListener('unit-changed', aggiornaTemperatureHistory);
  window.addEventListener('storage', (e) => {
    if (e.key === 'unit') aggiornaTemperatureHistory();
  });
}

// Detect if we are on home.html
if (window.location.pathname.endsWith('home.html')) {
  document.addEventListener('DOMContentLoaded', () => {
    mostraAllarmePiuRecente();
    aggiornaTemperatureHome();
    setInterval(mostraAllarmePiuRecente, 60000); // aggiorna ogni minuto
  });
  window.addEventListener('unit-changed', () => {
    mostraAllarmePiuRecente();
    aggiornaTemperatureHome();
  });
  window.addEventListener('storage', (e) => {
    if (e.key === 'unit') {
      mostraAllarmePiuRecente();
      aggiornaTemperatureHome();
    }
  });
}

// --- SETTINGS PAGE TEMPERATURE RANGE HANDLING (DRY) ---
let settingsTempRangeC = [20, 30]; // [min, max] in Celsius

function setSettingsTempRange(min, max, unit = 'C') {
  settingsTempRangeC[0] = unit === 'F' ? fahrenheitToCelsius(min) : min;
  settingsTempRangeC[1] = unit === 'F' ? fahrenheitToCelsius(max) : max;
  aggiornaSettingsTempRange();
}

function aggiornaSettingsTempRange() {
  const unit = getUnit();
  const tempEls = document.querySelectorAll('#convert-temp');
  tempEls.forEach((el) => {
    
    if (settingsTempRangeC.length === 2) {
      let min = settingsTempRangeC[0];
      let max = settingsTempRangeC[1];
      let simbolo = '°C';
      if (unit === 'F') {
        min = celsiusToFahrenheit(min);
        max = celsiusToFahrenheit(max);
        simbolo = '°F';
      }
      el.textContent = `${min}${simbolo} - ${max}${simbolo}`;
    }
  });
}

// Aggiorna anche su cambio unità
if (window.location.pathname.includes('settings.html')) {
  document.addEventListener('DOMContentLoaded', aggiornaSettingsTempRange);
  window.addEventListener('unit-changed', aggiornaSettingsTempRange);
  window.addEventListener('storage', (e) => {
    if (e.key === 'unit') aggiornaSettingsTempRange();
  });
}


