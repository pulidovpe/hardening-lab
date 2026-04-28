# Referencia de Túneles SSH
## Túnel local (acceso a servicio remoto desde local)
ssh -L puerto_local:destino:puerto_remoto user@gateway -N
## Túnel remoto (exponer servicio local en servidor remoto)
ssh -R puerto_remoto:localhost:puerto_local user@servidor -N
## Proxy SOCKS5 dinámico
ssh -D puerto_local user@gateway -N
## ProxyJump (bastion host)
ssh -J user@bastion user@destino_final
