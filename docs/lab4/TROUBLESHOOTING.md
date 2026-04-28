## [Lab 4] WireGuard: handshake nunca completa
Síntoma: sudo wg show no muestra 'latest handshake'
Causa 1: Puerto 51820 UDP bloqueado en UFW de VM1
Solución: sudo ufw allow 51820/udp
Causa 2: AllowedIPs incorrecto (las IPs del túnel no coinciden)
Causa 3: Copiaste la llave privada en lugar de la pública
Verificar: la llave pública tiene exactamente 44 caracteres
## [Lab 4] OpenVPN: VERIFY ERROR certificate revoked
Causa esperada si revocaste el certificado en el Día 5.
Para generar nuevo acceso: ./easyrsa gen-req vm2-v2 nopass
./easyrsa sign-req client vm2-v2
## [Lab 4] wg-quick: 'RTNETLINK answers: File exists'
Causa: la interfaz wg0 ya está activa
Solución: sudo wg-quick down wg0 && sudo wg-quick up wg0
## [Lab 4] Unbound: 'permission denied' puerto 53
Causa: systemd-resolved ya ocupa el puerto 53
Solución: cambiar Unbound a puerto 5353 y referenciar ese puerto en DNS=
o: sudo systemctl disable --now systemd-resolved
## [Lab 4] Túnel SSH: 'channel 2: open failed: connect failed'
Causa: el servicio destino no está corriendo en el puerto indicado
Verificar: ss -tlnp | grep PUERTO_OBJETIVO
