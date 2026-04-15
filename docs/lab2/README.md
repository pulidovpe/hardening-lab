# Lab 2: Monitoreo de Infraestructura

![Prometheus](https://img.shields.io/badge/Prometheus-2.53-orange)
![Grafana](https://img.shields.io/badge/Grafana-latest-yellow)
![Status](https://img.shields.io/badge/status-completado-green)

## Stack de monitoreo

| Componente | Version | VM | Puerto |
|---------------|---------|---------|--------|
| Node Exporter | 1.8.2 | VM1+VM2 | 9100 |
| Prometheus | 2.53.0 | VM2 | 9090 |
| Grafana | latest | VM2 | 3000 |
| AIDE | 0.18 | VM1 | - |

## Alertas configuradas

- NodeDown: nodo sin responder > 1 minuto
- HighCPUUsage: CPU > 80% por > 2 minutos
- LowMemory: memoria disponible < 10%
- DiskSpaceRunningOut: disco libre < 15%

## Errores conocidos y soluciones
Ver [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
