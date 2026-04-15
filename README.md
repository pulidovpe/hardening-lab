# Lab 1: Hardening Linux Profundo
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-orange)
![Status](https://img.shields.io/badge/status-completado-green)
## Objetivo
Endurecer un servidor Ubuntu 22.04 siguiendo prácticas CIS Benchmark
en un entorno de 3 VMs en UTM (Apple Silicon M4).
## Arquitectura
| VM | Hostname | IP | Rol |
|-----|----------------|----------------|------------------|
| VM1 | vm1-objetivo | 192.168.64.10 | Servidor objetivo|
| VM2 | vm2-monitor | 192.168.64.20 | Logs y auditoría |
| VM3 | vm3-atacante | 192.168.64.30 | Simulación ataque|
## Resultados
| Métrica | Antes | Después |
|-----------------------|-------|---------|
| Score Lynis | 56 | 65 |
| Servicios activos | 23 | 22 |
| Puertos expuestos | 06 | 06 |
| Parámetros sysctl | 0 | 28 |
## Configuraciones aplicadas
- **VM1:** SSH hardened (ed25519 + MFA TOTP), sysctl 28 parámetros,
AppArmor enforce, auditd reglas CIS, fail2ban, UFW
- **VM2:** rsyslog receptor centralizado, UFW
## Ataques simulados y resultados
| Ataque | Herramienta | Resultado | Evidencia |
|-----------------|-------------|------------------------|------------------|
| Escaneo puertos | nmap -sS | Todos filtrados | ufw-bloqueados |
| Fuerza bruta SSH| hydra | IP baneada (3 intentos)| fail2ban-baneadas|
| SYN flood | hping3 | Mitigado (syncookies) | dmesg |
| Exfiltración | scp shadow | Permission denied | auditd-denegados |
## Errores conocidos y soluciones
Ver [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
## Tecnologías
sshd · PAM · Google Authenticator · sysctl · AppArmor · auditd
rsyslog · fail2ban · UFW · nftables · Lynis · AIDE

# Lab 2: Monitoreo de Infraestructura
Ver [README.md](./docs/lab2/README.md)
