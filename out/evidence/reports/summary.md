# QSP Report Summary

- Generated: `2026-01-30T07:38:06Z`
- Git commit: `3d435f3`

This page provides a **single-glance PASS/FAIL overview** for both **Demo** and **Attack scenarios**.

## Overview

| Item | Status | Report | Evidence |
|---|---:|---|---|
| Demo | **N/A** | `out/logs/demo.json` | `N/A` |
| Attack-01 | **PASS** | `out/logs/attack_01_tamper_sig.json` | `out/logs/server167_attack01.log:44:error = RuntimeError: ack confirm mismatch` |
| Attack-02 | **N/A** | `out/logs/attack_02_replay.json` | `N/A` |
| Attack-03 | **N/A** | `out/logs/attack_03_epoch_rollback.json` | `N/A` |
| Attack-04 | **N/A** | `out/logs/attack_04_wrong_session_id.json` | `N/A` |
| Attack-05 | **N/A** | `out/logs/attack_05_key_schedule_confusion.json` | `N/A` |
| Attack-06 | **N/A** | `out/logs/attack_06_phase_confusion.json` | `N/A` |

## Demo

- Status: **N/A**
- Report: `out/logs/demo.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

## Attack-01

- Status: **PASS**
- Report: `out/logs/attack_01_tamper_sig.json`
- Evidence: `out/logs/server167_attack01.log:44:error = RuntimeError: ack confirm mismatch`

### Preview
```
{"stage":176,"attack":"attack_01_tamper_sig","ts_utc":"2026-01-30T07:38:05Z","expected":"FAIL_CLOSED","observed":"FAIL_CLOSED_REKEY_REJECTED","ok":true,"client_rc":0,"artifacts":{"server_log":"out/logs/server167_attack01.log","client_log":"out/logs/client167_attack01.log"}}

```

## Attack-02

- Status: **N/A**
- Report: `out/logs/attack_02_replay.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

## Attack-03

- Status: **N/A**
- Report: `out/logs/attack_03_epoch_rollback.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

## Attack-04

- Status: **N/A**
- Report: `out/logs/attack_04_wrong_session_id.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

## Attack-05

- Status: **N/A**
- Report: `out/logs/attack_05_key_schedule_confusion.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

## Attack-06

- Status: **N/A**
- Report: `out/logs/attack_06_phase_confusion.json`
- Evidence: `N/A`

### Preview
```
_(report not found)_
```

---

## Next

- Add more scenarios: **attack-07 (phase confusion: INIT instead of ACK / duplicate COMMIT / out-of-order frames)** etc.
