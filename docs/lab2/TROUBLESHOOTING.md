# TROUBLESHOOTING del Lab 2
## Node Exporter — métricas node_* no aparecen en head -20
No es un error. Las primeras líneas son métricas internas del runtime de Go. Las métricas del sistema están
más abajo. Verificar con:
<br />curl -s http://localhost:9100/metrics | grep 'node_cpu_seconds_total' | head -5
<br />curl -s http://localhost:9100/metrics | grep 'node_memory_MemTotal_bytes'
## Node Exporter no arranca (exec format error)
Causa: descargaste la versión amd64 en lugar de arm64.
<br />uname -m # debe mostrar: aarch64
<br />Descargar: node_exporter-X.X.X.linux-arm64.tar.gz
## scp falla con 'path canonicalization failed'
Causa: el directorio destino no existe en VM1. Solución: crearlo antes del scp.
<br />ssh adminlab@192.168.64.10 'mkdir -p ~/lab-hardening/vm2-monitor/CARPETA'
<br />luego ejecutar el scp
## Prometheus target en estado DOWN
Causa 1: Node Exporter no está corriendo.
<br />systemctl status node_exporter
Causa 2: UFW bloquea el puerto 9100.
<br />ufw status verbose | grep 9100
<br />ufw allow from 192.168.64.20 to any port 9100 proto tcp
## Grafana no carga en el navegador
<br />sudo ufw allow from 192.168.64.1 to any port 3000 proto tcp
## Error en YAML de reglas Prometheus: 'did not find expected key'
Causa: indentación incorrecta o comillas simples en expresiones PromQL. Usar la versión corregida del Día 3
con comillas dobles. Validar siempre con:
<br />promtool check rules /etc/prometheus/rules/lab-alerts.yml
## AIDE — error: missing configuration
En Ubuntu 22.04, AIDE no detecta el archivo de configuración automáticamente. Siempre usar:
<br />sudo aide --check --config /etc/aide/aide.conf
<br />sudo aide --init --config /etc/aide/aide.conf
<br />sudo aide --update --config /etc/aide/aide.conf
## AIDE muestra lista enorme de d+++ en el primer check
La base de datos estaba vacía al momento del check. Reinicializar:
<br />sudo rm /var/lib/aide/aide.db
<br />sudo aide --init --config /etc/aide/aide.conf
<br />sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
<br />sudo aide --check --config /etc/aide/aide.conf
## AIDE siempre reporta audit.log como cambiado
Comportamiento esperado e inevitable. auditd escribe en ese archivo continuamente durante los ~4 minutos del
escaneo. El WARNING 'hash could not be calculated' confirma que es ruido operacional, no una intrusión. Ver
NOTAS.md en el repositorio.
## AIDE reporta cambios después de un git commit
El directorio del repositorio Git es monitoreado por alguna regla genérica. Asegurarse de que las exclusiones en
05-lab-exclusions.conf incluyan la ruta del repositorio:
<br />!/home/adminlab/lab-hardening
<br />!/root/lab-hardening
## AIDE tarda mucho en inicializar
Normal — la primera vez escanea todo el sistema. Puede tardar 5-10 minutos. Dejar correr en background:
<br />sudo aide --init --config /etc/aide/aide.conf &
## Warning de apt-key deprecated al instalar Grafana
Solo un aviso — Grafana se instala correctamente. Para futuros labs usar el método moderno con gpg
--dearmor (ver paso 3.1 corregido). Si Grafana ya está funcionando, no es necesario reinstalar.
