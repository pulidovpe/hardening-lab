## Permisos requeridos en VM2 antes de iniciar rsyslog
```bash
sudo mkdir -p /var/log/remote
sudo chown -R syslog:adm /var/log/remote
sudo chmod -R 775 /var/log/remote
```
Sin estos permisos rsyslog no puede crear los archivos de log
y los mensajes remotos se descartan silenciosamente.
