# 🌿 Sistema di Monitoraggio per Serra Intelligente (Software)

Progetto software per il monitoraggio in tempo reale della temperatura in una serra, con architettura basata su **MQTT, Python, InfluxDB e Grafana**.  
*(Versione senza hardware - simulazione dati inclusa)*

---

## 📌 Panoramica
**Obiettivo**: Realizzare un sistema scalabile per:
- Raccolta dati da sensori (simulati via software).
- Elaborazione e storage in database time-series.
- Visualizzazione in dashboard con alert e storico.

---

## 🛠️ Tecnologie
| Componente       | Tecnologia/Tool          |
|------------------|--------------------------|
| **Broker MQTT**  | Mosquitto (Docker)       |
| **Backend**      | Python (paho-mqtt, FastAPI) |
| **Database**     | InfluxDB 2.0             |
| **Dashboard**    | Grafana                  |
| **Simulazione**  | Script Python (Faker)    |
| **Deploy**       | Docker, Docker Compose   |

---

## 👥 Team & Ruoli
| Collaboratore | Ruolo                | Responsabilità                            |
|---------------|----------------------|-------------------------------------------|
| **A**         | Project Manager      | Coordinamento, documentazione, sprint    |
| **B**         | Backend Developer    | Broker MQTT, API, elaborazione dati       |
| **C**         | Frontend Developer   | Dashboard Grafana/Node-RED                |
| **D**         | DevOps/QA            | Deploy, sicurezza, testing                |

---

## 📋 Task Suddivisi per Sprint

### **Sprint 1 - Setup Ambiente**
| Task                          | Assegnato | Stato |
|-------------------------------|-----------|-------|
| Configurare Mosquitto (Docker)| D         | ✅    |
| Creare simulatore dati Python | B         | ✅    |
| Setup InfluxDB + retention    | D         | ⏳    |

### **Sprint 2 - Core Development**
| Task                          | Assegnato | Stato |
|-------------------------------|-----------|-------|
| Elaboratore dati (validazione)| B         | ⏳    |
| Dashboard base (Grafana)      | C         | ✅    |
| Test integrazione MQTT-DB     | D         | ❌    |

### **Sprint 3 - Avanzato**
| Task                          | Assegnato | Stato |
|-------------------------------|-----------|-------|
| API REST per soglie allarme   | B         | ❌    |
| Alert in Grafana              | C         | ❌    |
| Sicurezza MQTT (TLS)          | D         | ❌    |

### **Backlog (Estensioni)**
- Autenticazione dashboard (Grafana OAuth).  
- Notifiche Telegram/Email.  
- Scalabilità con Kafka.  

---

## 🚀 Come Iniziare
### Prerequisiti
- MQTT
- Docker e Docker Compose installati.
- Python 3.8+ or Node-Red for sensors simulation data injection
- Java 21+ for Enterprice back-end
- React or static Web for fron-end UI
- 
### Installazione
1. **Clona il repository**:
   ```bash
   git clone https://github.com/DoxxBit/Serra-Automatizzata-Team-1.git
   cd Serra-Automatizzata-Team-1

