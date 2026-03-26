# Troubleshooting — Errores conocidos
## MFA no pide código TOTP (Permission denied inmediato)
**Síntoma:** `ssh -vvv` muestra `partial success` luego
`No more authentication methods to try`
**Causa 1:** Parámetro incorrecto en sshd_config.
En OpenSSH 9.6 usar `KbdInteractiveAuthentication yes`
(no `ChallengeResponseAuthentication`)
**Causa 2:** `@include common-auth` sin comentar en /etc/pam.d/sshd
**Causa 3:** Falta `KbdInteractiveAuthentication yes` en ~/.ssh/config del cliente
## rsyslog crea archivo llamado '%HOSTNAME%.log' literalmente
**Causa:** Sintaxis antigua de template no funciona en rsyslog 8+
**Solución:** Usar sintaxis nueva en /etc/rsyslog.d/10-remote.conf:
template(name="RemoteLogs" type="string"
string="/var/log/remote/%HOSTNAME%.log")
## rsyslog no crea archivos en /var/log/remote/
**Causa:** rsyslog corre como usuario 'syslog', sin permisos de escritura
**Solución:**
sudo chown -R syslog:adm /var/log/remote
sudo chmod -R 775 /var/log/remote
## SCP entre VMs falla (Permission denied publickey)
**Causa:** VM2 solo tiene autorizada la llave de la Mac, no la de VM1.
**Solución:** Usar la Mac como intermediario para mover archivos entre VMs:
# Mac descarga de VM2
scp adminlab@192.168.64.20:/ruta/archivo /tmp/
# Mac sube a VM1
scp /tmp/archivo adminlab@192.168.64.10:~/lab-hardening/ruta/
## auditd: 'Syscall name unknown: open' al cargar reglas
**Causa:** Las VMs Ubuntu sobre Apple Silicon M4 (UTM) usan arquitectura
aarch64, no x86_64. En aarch64 hay dos diferencias:
1. El flag de arquitectura es 'aarch64', no 'b64'
2. La syscall 'open' no existe — fue reemplazada por 'openat'
**Síntoma:** Error en línea con '-F arch=b64 -S open'
**Solución:** Reemplazar en todas las reglas con syscalls:
-F arch=b64 → -F arch=aarch64
-S open → -S openat
## SSH no interactivo falla con 'sudo: a terminal is required'
**Síntoma:** ssh user@vm2 'sudo comando' > archivo.txt
devuelve: sudo: a terminal is required to read the password
**Causa:** sudo necesita TTY. La redirección elimina la TTY.
**Solución:** Sesión interactiva + guardar en archivo + scp:
ssh adminlab@192.168.64.20
sudo ufw status verbose > ~/ufw-status.txt && exit
scp adminlab@192.168.64.20:~/ufw-status.txt /tmp/
## Hydra: 'does not support password authentication (method reply 4)'
**Causa:** No es un error — es el comportamiento correcto.
PasswordAuthentication=no rechaza el ataque a nivel de protocolo.
**Para demostrar fail2ban:** usar intentos con usuario inexistente:
for i in 1 2 3 4 5; do
ssh -o BatchMode=yes usuariofake@192.168.64.10; sleep 1
done
sudo fail2ban-client status sshd # IP de VM3 aparece baneada
## Paquete 'wordlists' no encontrado en Ubuntu 22.04
**Solución:** Descargar rockyou.txt directamente:
sudo mkdir -p /usr/share/wordlists
sudo curl -L https://github.com/brannondorsey/naive-hashcat/
releases/download/data/rockyou.txt
-o /usr/share/wordlists/rockyou.txt
## Ataque 3: dmesg y ufw.log vacíos tras SYN flood
**Causa:** tcp_syncookies mitiga silenciosamente sin generar logs.
UFW descarta paquetes a velocidad de línea sin loguearlos.
**La evidencia real:** '0 packets received' en VM3 + sistema
respondiendo normalmente durante el flood.
**Verificación correcta:**
sysctl net.ipv4.tcp_syncookies # debe ser 1
cat /proc/net/netstat | grep -i sync # SyncookiesSent > 0
## Ataque 4: scp da 'Connection refused' en lugar de 'Permission denied'
**Causa:** VM3 seguía baneada por fail2ban desde el Ataque 2.
El bloqueo ocurre antes de llegar al filesystem, por eso
auditd no registra nada relacionado con /etc/shadow.
**Solución:** Desbanear VM3 antes del Ataque 4:
sudo fail2ban-client set sshd unbanip 192.168.64.30
## Ataque 4: 'su -s /bin/bash nobody' se queda colgado
**Causa:** su intenta autenticar via PAM. Con MFA configurado,
PAM espera indefinidamente una respuesta de autenticación.
**Solución:** Usar sudo -u para ejecutar como otro usuario sin PAM:
echo 'cat /etc/shadow' | sudo -u www-data bash 2>/dev/null || true
sudo ausearch -k access_denied | tail -15
