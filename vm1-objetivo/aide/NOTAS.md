## Comportamiento conocido: /var/log/audit/audit.log

AIDE reporta cambios en `/var/log/audit/audit.log` en cada ejecución.

**Causa:** `auditd` escribe en este archivo continuamente. Durante los ~4 minutos
que tarda el escaneo, el archivo crece, por lo que AIDE detecta diferencias
de tamaño entre el inicio y el fin del check.

**Por qué no es un problema:** El propio AIDE indica
"hash could not be calculated" — no puede verificar integridad del archivo
porque está siendo escrito activamente. Es ruido operacional esperado,
no una alerta de intrusión.

**Decisión:** Se excluye del monitoreo de integridad. Los logs de auditoría
tienen su propio mecanismo de integridad via `auditd` y `ausearch`.
