# Helm Chart Values for autovpa

This document provides an overview of the configurable values for the autovpa Helm chart. Adjust them in `values.yaml` when deploying the chart.

## Installation

```bash
helm repo add containeroo https://charts.containeroo.ch
helm repo update containeroo
helm upgrade --install autovpa containeroo/autovpa
```

## General Configuration

| Key                | Description                         | Default Value                 |
| ------------------ | ----------------------------------- | ----------------------------- |
| `image.repository` | The container image repository.     | `ghcr.io/containeroo/autovpa` |
| `image.tag`        | Overrides the default image tag.    | Chart `appVersion`            |
| `image.pullPolicy` | The image pull policy.              | `IfNotPresent`                |
| `imagePullSecrets` | Secrets for pulling private images. | `[]`                          |

---

## Pod Configuration

| Key              | Description                            | Default Value |
| ---------------- | -------------------------------------- | ------------- |
| `replicas`       | Number of replicas for the deployment. | `1`           |
| `sidecars`       | Additional containers for the pod.     | `[]`          |
| `podAnnotations` | Annotations for the pod.               | `{}`          |
| `podLabels`      | Labels for the pod.                    | `{}`          |
| `nodeSelector`   | Node selector for pod placement.       | `{}`          |
| `tolerations`    | Tolerations for pod scheduling.        | `[]`          |
| `affinity`       | Affinity rules for pod placement.      | `{}`          |

---

## Profile & annotations

| Key                    | Description                                   | Default Value                    |
| ---------------------- | --------------------------------------------- | -------------------------------- |
| `profile.path`         | Path to the profiles file in the container.   | `/etc/autovpa/config.yaml`       |
| `profile.annotation`   | Workload annotation used to select a profile. | `autovpa.containeroo.ch/profile` |
| `profile.managedLabel` | Label applied to managed VPAs.                | `autovpa.containeroo.ch/managed` |
| `profile.nameTemplate` | Template for VPA names.                       | `{{ .WorkloadName }}-{{ .Profile }}-vpa` |
| `profile.configMap.create` | Create and mount a profile ConfigMap.      | `true`                           |
| `profile.configMap.name` | Existing/custom profile ConfigMap name.      | `""`                             |
| `profile.configMap.key` | Key containing the profile configuration.     | `config.yaml`                    |
| `profile.defaultProfile` | Name of the default profile.                 | `default`                        |
| `profile.profiles` | Profile definitions written to the ConfigMap.       | Default profile with `Off` mode  |

---

## Probes

| Key                      | Description                            | Default Value       |
| ------------------------ | -------------------------------------- | ------------------- |
| `startupProbe.enabled`   | Enable startup probe.                  | `true`              |
| `startupProbe.spec`      | Configuration for the startup probe.   | See default values. |
| `livenessProbe.enabled`  | Enable liveness probe.                 | `true`              |
| `livenessProbe.spec`     | Configuration for the liveness probe.  | See default values. |
| `readinessProbe.enabled` | Enable readiness probe.                | `true`              |
| `readinessProbe.spec`    | Configuration for the readiness probe. | See default values. |

---

## Security

| Key                  | Description                          | Default Value |
| -------------------- | ------------------------------------ | ------------- |
| `podSecurityContext` | Security context for the pod.        | `{}`          |
| `securityContext`    | Security context for the containers. | `{}`          |

---

## Resource Configuration

| Key                         | Description                       | Default Value |
| --------------------------- | --------------------------------- | ------------- |
| `resources.limits.cpu`      | CPU limit for the container.      | `100m`        |
| `resources.limits.memory`   | Memory limit for the container.   | `200Mi`       |
| `resources.requests.cpu`    | CPU request for the container.    | `100m`        |
| `resources.requests.memory` | Memory request for the container. | `200Mi`       |

---

## Metrics Configuration

| Key                                       | Description                             | Default Value       |
| ----------------------------------------- | --------------------------------------- | ------------------- |
| `metrics.enabled`                         | Enable metrics collection.              | `true`              |
| `metrics.service.type`                    | Metrics service type.                   | `ClusterIP`         |
| `metrics.service.ports`                   | Ports for the metrics service.          | See default values. |
| `metrics.prometheusRule.enabled`          | Enable Prometheus rules for alerts.     | `true`              |
| `metrics.prometheusRule.namespace`        | Namespace for Prometheus rules.         | `monitoring`        |
| `metrics.prometheusRule.severity`         | Severity of alerts.                     | `critical`          |
| `metrics.prometheusRule.additionalLabels` | Additional labels for Prometheus rules. | `{}`                |

---

## RBAC and Service Account

| Key                          | Description                                | Default Value |
| ---------------------------- | ------------------------------------------ | ------------- |
| `clusterRole.create`         | Create a ClusterRole and binding.          | `true`        |
| `clusterRole.name`           | Custom name for the ClusterRole.           | `""`          |
| `clusterRole.extraRules`     | Additional RBAC rules for the ClusterRole. | `[]`          |
| `role.create`                | Create a namespace-scoped Role and binding. | `false`       |
| `role.name`                  | Custom name for the Role.                    | `""`          |
| `role.extraRules`            | Additional RBAC rules for the Role.          | `[]`          |
| `serviceAccount.create`      | Create a ServiceAccount.                   | `true`        |
| `serviceAccount.annotations` | Annotations for the ServiceAccount.        | `{}`          |
| `serviceAccount.name`        | Custom name for the ServiceAccount.        | `""`          |

---

## Leader Election

| Key                      | Description             | Default Value |
| ------------------------ | ----------------------- | ------------- |
| `leaderElection.enabled` | Enable leader election. | `true`        |

---

## Logging Configuration

| Key              | Description     | Default Value |
| ---------------- | --------------- | ------------- |
| `logging.format` | Logging format. | `json`        |

---

## Environment Variables

| Key   | Description                        | Default Value                        |
| ----- | ---------------------------------- | ------------------------------------ |
| `env` | Environment variables for the pod. | `[{name: TZ, value: Europe/Zurich}]` |

---

## Arguments

| Key         | Description                  | Default Value |
| ----------- | ---------------------------- | ------------- |
| `extraArgs` | Extra arguments for the pod. | `[]`          |

---

## Extra Configuration

| Key            | Description                         | Default Value |
| -------------- | ----------------------------------- | ------------- |
| `extraObjects` | Extra Kubernetes objects to deploy. | `[]`          |
