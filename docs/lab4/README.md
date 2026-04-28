b 4: VPN y Acceso Remoto Seguro
### Comparación WireGuard vs OpenVPN vs Túneles SSH
| Criterio | WireGuard | OpenVPN | SSH Tunnel |
|-----------------|---------------|-------------|-------------|
| Instalación | Muy simple | Compleja | Sin instalar |
| Velocidad | Muy alta | Media | Alta |
| Gestión usuarios| Manual | PKI/CRL | Llaves SSH |
| Kill-switch | Sí (iptables) | Sí | No nativo |
| Logging | Mínimo | Detallado | Via SSH |
| Uso ideal | VPN personal | Corporativo | Acceso temp |

### Configuraciones aplicadas
- VM1: WireGuard servidor + OpenVPN servidor + Unbound DNS + NAT
- VM2: WireGuard cliente (kill-switch + DNS privado) + OpenVPN cliente
- Mac: Túneles SSH local/remoto/SOCKS5 + ProxyJump a VM3

## Errores conocidos y soluciones
Ver [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
