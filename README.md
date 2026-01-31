# QSP Stage176 — External PoC Package
MIT License © 2025 Motohiro Suzuki

---

## 🔹 Overview

**Stage176** is an **external-facing Proof-of-Concept (PoC) package** for the  
**Quantum-Safe Protocol (QSP)**.

This stage is explicitly designed so that **external organizations**  
(e.g., research institutes, national labs, security teams, vendors) can:

- clone the repository
- run a single command
- observe correct protocol behavior **and**
- verify safe failure under adversarial conditions

No cryptographic secrets are embedded in this repository.

---

## 🎯 Goal of Stage176

> “Make QSP safe to touch.”

Stage176 is the **entry point** for:
- joint research
- external PoC
- security training
- protocol evaluation

It prioritizes:
- reproducibility
- fail-closed behavior
- clarity of expected failures

---

## 📦 What Is Included

Stage176 provides:

- Docker-based reproducible environment
- One-shot execution runner (`matrix`)
- Explicit attack scenarios (Attack-01 to Attack-06)
- Structured logs and summaries
- Clear expectations for failure behavior

Out of scope:
- performance benchmarking
- production tuning
- hardware QKD integration

---

## 🚀 Quick Start

### Requirements
- Docker
- Docker Compose (v2)

### Run Everything (Recommended)

```bash
docker compose -f docker/docker-compose.yml run --rm --build matrix
This single command will:

Run a normal protocol demonstration

Execute all attack scenarios

Collect logs

Generate a human-readable summary

🧪 Execution Flow
The matrix runner performs:

Normal operation

Stage167-A protocol demo

Attack scenarios

Attack-01 → Attack-06

Evidence collection

Summary generation

If all attacks fail safely, the final result is:

[matrix] FINAL = PASS
🧨 Attack Scenarios
ID	Description	Expected Result
Attack-01	Tampered ACK signature	Fail-closed
Attack-02	Replay (ACK after commit)	Fail-closed
Attack-03	Epoch rollback	Fail-closed
Attack-04	Wrong session ID	Fail-closed
Attack-05	Key schedule confusion	Fail-closed
Attack-06	Phase confusion (COMMIT instead of ACK)	Fail-closed
Each scenario is implemented as an independent, reproducible script.

🔐 Security Property Demonstrated
Stage176 validates the following property:

Any detected protocol inconsistency MUST immediately terminate the session
without exposing key material (fail-closed).

There is no silent recovery and no undefined behavior.

📁 Output Artifacts
At runtime, the following artifacts are generated locally:

JSON event logs

client/server logs

summary.md (aggregated result)

These files are:

reproducible

environment-dependent

intentionally not committed to the repository

🧠 Design Philosophy
Stage176 is intentionally conservative.

Explicit failure > silent success

Reproducibility > optimization

Safety > performance

This makes the package suitable for external evaluation without additional trust assumptions.

🧭 Intended Use
External PoC

Joint research

Security workshops

Training material

Protocol review

Stage176 is safe to distribute and safe to execute.

📜 License
This project is licensed under the MIT License.

© 2025 Motohiro Suzuki