# filesystem-exporter chart

The [filesystem-exporter chart](https://github.com/containeroo/helm-charts/tree/master/charts/filesystem-exporter) installs filesystem-exporter, a Prometheus exporter that scans an already-mounted filesystem path and reports capacity, availability, and used bytes.

## Installation

```shell
helm repo add containeroo https://charts.containeroo.ch
helm install filesystem-exporter containeroo/filesystem-exporter \
  --set volume.persistentVolumeClaim.claimName=data
```

## Configuration

The following table lists the configurable parameters of the filesystem-exporter Helm chart and their default values.

| Parameter | Default | Description |
| --- | --- | --- |
| `replicaCount` | `1` | Number of replicas |
| `image.repository` | `ghcr.io/containeroo/filesystem-exporter` | Image repository |
| `image.pullPolicy` | `IfNotPresent` | Image pull policy |
| `image.tag` | `None` | Overrides the image tag of chart `appVersion` |
| `imagePullSecrets` | `[]` | Image pull secrets |
| `nameOverride` | `None` | Override chart name |
| `fullnameOverride` | `None` | Override full resource name |
| `commonLabels` | `{}` | Additional labels added to chart resources |
| `serviceAccount.create` | `true` | If `true`, create a new service account |
| `serviceAccount.annotations` | `{}` | Additional ServiceAccount annotations |
| `serviceAccount.name` | `None` | ServiceAccount name to use |
| `filesystem.path` | `/data` | Filesystem path inside the container to scan |
| `filesystem.reportChildDirs` | `false` | Report metrics for immediate child directories |
| `filesystem.scanConcurrency` | `1` | Maximum concurrent metadata operations |
| `collector.interval` | `5m` | Collection interval |
| `collector.timeout` | `2m` | Single collection timeout |
| `logLevel` | `info` | Exporter log level |
| `metrics.port` | `9799` | Exporter metrics port |
| `metrics.path` | `/metrics` | Metrics endpoint path |
| `metrics.service.enabled` | `true` | Create a metrics Service |
| `metrics.service.annotations` | `{}` | Additional Service annotations |
| `metrics.service.additionalLabels` | `{}` | Additional Service labels |
| `metrics.service.portName` | `http-metrics` | Metrics Service port name |
| `metrics.service.port` | `9799` | Metrics Service port |
| `metrics.serviceMonitor.enabled` | `false` | Create a Prometheus Operator ServiceMonitor |
| `metrics.serviceMonitor.namespace` | same as release namespace | Namespace for the ServiceMonitor |
| `metrics.serviceMonitor.additionalLabels` | `{}` | Additional ServiceMonitor labels |
| `metrics.serviceMonitor.scrapeInterval` | `30s` | ServiceMonitor scrape interval |
| `metrics.serviceMonitor.targetLabels` | `[]` | Service labels copied to scraped metrics |
| `metrics.prometheusRule.enabled` | `false` | Create a PrometheusRule |
| `metrics.prometheusRule.namespace` | same as release namespace | Namespace for the PrometheusRule |
| `metrics.prometheusRule.additionalLabels` | `{}` | Additional PrometheusRule labels |
| `openshift.hostMountAnyuidSCC.create` | `false` | Bind the service account to OpenShift `hostmount-anyuid` SCC |
| `volume` | `{}` | Kubernetes volume source mounted at `filesystem.path`; empty uses `emptyDir` |
| `volumeMount.readOnly` | `true` | Mount the filesystem read-only |
| `podAnnotations` | `{}` | Additional pod annotations |
| `podLabels` | `{}` | Additional pod labels |
| `podSecurityContext` | `{}` | Pod security context |
| `securityContext` | `{}` | Container security context |
| `resources.requests.cpu` | `100m` | CPU resource request |
| `resources.requests.memory` | `128Mi` | Memory resource request |
| `resources.limits.memory` | `512Mi` | Memory resource limit |
| `nodeSelector` | `{}` | Node selector properties |
| `tolerations` | `[]` | Toleration properties |
| `affinity` | `{}` | Affinity properties |
