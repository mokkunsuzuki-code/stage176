# QSP Stage176 Specification
MIT License © 2025 Motohiro Suzuki

## 1. Purpose

Stage176 defines a **public-facing PoC package** for the Quantum-Safe Protocol (QSP),
intended for **external evaluation, training, and joint proof-of-concept activities**
by research institutions and industry partners.

The focus of this stage is not cryptographic novelty, but **operational safety,
reproducibility, and fail-closed behavior under adversarial conditions**.

---

## 2. Scope

Stage176 specifies:

- A Docker-based reproducible execution environment
- A single-shot runner ("matrix") for demonstrations and attacks
- A set of explicit attack scenarios (Attack-01 to Attack-06)
- Expected failure behavior (fail-closed) with evidence logs

Out of scope:

- Performance benchmarking
- Production hardening
- Hardware QKD integration

---

## 3. Execution Model

All evaluations are executed via Docker:

```bash
docker compose -f docker/docker-compose.yml run --rm --build matrix
The runner performs, in order:

Normal protocol demonstration (Stage167-A)

Attack scenarios (01–06)

Log collection

Summary generation

4. Attack Scenarios
ID	Attack Type	Expected Result
01	Tampered Signature	Fail-closed
02	Replay (ACK)	Fail-closed
03	Epoch Rollback	Fail-closed
04	Wrong Session ID	Fail-closed
05	Key Schedule Confusion	Fail-closed
06	Phase Confusion	Fail-closed
Each attack produces structured logs and a summary entry.

5. Security Property
The primary security claim of Stage176 is:

Any detected protocol inconsistency MUST result in immediate termination
without key material exposure (fail-closed).

6. Evidence
Evidence is generated at runtime and includes:

JSON event logs

Client/server logs

Aggregated summary (summary.md)

These artifacts are not version-controlled and are treated as experimental outputs.

7. Intended Use
External PoC

Security training

Research evaluation

Joint experimentation

Stage176 is designed to be safe to distribute and execute in external environments.


---

# ② Stage176｜README（MIT License付き）

```markdown
# QSP Stage176 — External PoC Package
MIT License © 2025 Motohiro Suzuki

## Overview

Stage176 is a **self-contained, reproducible PoC package** for evaluating the
Quantum-Safe Protocol (QSP) under adversarial conditions.

It is intended for:
- Research institutions (e.g., national labs, universities)
- Industry security teams
- Training and joint PoC activities

---

## Quick Start

```bash
git clone <this-repository>
cd stage176
docker compose -f docker/docker-compose.yml run --rm --build matrix
What This Demonstrates
Normal protocol operation

Explicit attack scenarios

Correct fail-closed behavior

Reproducible execution

No manual setup is required beyond Docker.

Attack Scenarios
Stage176 includes the following attacks:

Replay attacks

Epoch rollback

Session confusion

Key schedule confusion

Phase confusion (protocol state mismatch)

Each attack is expected to fail safely and produce evidence logs.

Output
After execution, the runner produces:

Structured JSON logs

Client/server traces

A human-readable summary

These files are generated locally and are not committed to the repository.

Design Philosophy
Stage176 prioritizes:

Safety over performance

Reproducibility over optimization

Explicit failure over silent behavior

This stage serves as the entry point for external evaluation of QSP.