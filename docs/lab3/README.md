## Lab 3: Auditoría y Cumplimiento CIS con OpenSCAP
![OpenSCAP](https://img.shields.io/badge/OpenSCAP-1.3.10-blue)
![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-orange)
![CIS](https://img.shields.io/badge/CIS-Level_1_Server-green)
### Ciclo de auditoría
| Fase | Herramienta | Resultado |
|-------------|--------------|------------------------------|
| Escaneo | OpenSCAP | Baseline de cumplimiento CIS |
| Análisis | oscap + grep | 10 controles priorizados |
| Remediación | Ansible | Playbook automatizado |
| Re-escaneo | OpenSCAP | Score mejorado verificado |
### Resultados
| Métrica | Baseline | Post-Remediación |
|------------------|----------|-----------------|
| Score CIS L1 | XX% | XX% |
| Controles PASS | XXX | XXX |
| Controles FAIL | XXX | XXX |
| Remediados | — | XX |
### Stack
OpenSCAP 1.3.10 · scap-security-guide 0.1.78 · Ansible · CIS Ubuntu 24.04
