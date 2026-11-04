# agent-forge-operator chart

The [agent-forge-operator chart](https://github.com/containeroo/helm-charts/tree/master/charts/agent-forge-operator) provides a Helm chart as a first-class method of installation on Kubernetes.

The chart installs the `VsphereAgent`, `VsphereAgentPool`, `OpenStackAgent`, and
`OpenStackAgentPool` CRDs from the chart `crds/` directory. Version 1.3.2 uses
operator image `v1.3.2` and includes OpenStack provider permissions. Existing
`crdRoles` names are preserved; those roles now cover both providers.

## Installation

```shell
helm repo add containeroo https://charts.containeroo.ch
helm install agent-forge-operator containeroo/agent-forge-operator --namespace agent-forge-operator-system --create-namespace
```

## Configuration

The following table lists the configurable parameters of the agent-forge-operator Helm chart and their default values.

| Parameter                                      | Default                                             | Description                                           |
| ---------------------------------------------- | --------------------------------------------------- | ----------------------------------------------------- |
| `image.repository`                             | `ghcr.io/containeroo/agent-forge-operator`          | Image repository                                      |
| `image.pullPolicy`                             | `IfNotPresent`                                      | Image pull policy                                     |
| `image.tag`                                    | `None`                                              | Overrides the image tag of chart `appVersion`         |
| `imagePullSecrets`                             | `[]`                                                | Image pull secrets                                    |
| `args`                                         | `["--leader-elect", "--health-probe-bind-address=:8081", "--metrics-bind-address=:8443"]` | Command line arguments to pass to the container |
| `nameOverride`                                 | `None`                                              | Override the chart name                               |
| `fullnameOverride`                             | `None`                                              | Override the full name of resources                   |
| `serviceAccount.create`                        | `true`                                              | If `true`, create a new service account               |
| `serviceAccount.annotations`                   | `{}`                                                | Additional Service Account annotations                |
| `serviceAccount.name`                          | `agent-forge-operator`                              | Service account to be used                            |
| `clusterRole.create`                           | `true`                                              | If `true`, create cluster role and cluster role binding |
| `clusterRole.name`                             | `agent-forge-operator`                              | The name of a cluster role to bind to                 |
| `clusterRole.extraRules`                       | `[]`                                                | Additional rules to be included in the role           |
| `crdRoles.create`                              | `true`                                              | Create user-facing roles for managing the operator CRDs |
| `crdRoles.adminName`                           | `vsphereagentpool-admin-role`                       | Name of the full-access CRD role                       |
| `crdRoles.editorName`                          | `vsphereagentpool-editor-role`                      | Name of the CRD editor role                            |
| `crdRoles.viewerName`                          | `vsphereagentpool-viewer-role`                      | Name of the read-only CRD role                         |
| `leaderElectionRole.create`                    | `true`                                              | If `true`, create leader election role and role binding |
| `leaderElectionRole.name`                      | `agent-forge-operator-leader-election`              | The name of a leader election role to bind to         |
| `leaderElectionRole.extraRules`                | `[]`                                                | Additional rules to be included in the role           |
| `podAnnotations`                               | `{kubectl.kubernetes.io/default-container: agent-forge-operator}` | Additional pod annotations                  |
| `podSecurityContext`                           | `{runAsNonRoot: true, seccompProfile: {type: RuntimeDefault}}` | Pod-level security context                 |
| `securityContext`                              | `{allowPrivilegeEscalation: false, capabilities: {drop: [ALL]}}` | Container-level security context           |
| `resources.requests.cpu`                       | `10m`                                               | CPU resource requests for the deployment              |
| `resources.requests.memory`                    | `64Mi`                                              | Memory resource requests for the deployment           |
| `resources.limits.cpu`                         | `500m`                                              | CPU resource limits for the deployment                |
| `resources.limits.memory`                      | `128Mi`                                             | Memory resource limits for the deployment             |
| `metrics.service.enabled`                      | `true`                                              | Enable metrics service                                |
| `metrics.containerPort`                        | `8443`                                              | Metrics container port                                |
| `metrics.service.portName`                     | `https`                                             | Metrics service port name                             |
| `metrics.service.port`                         | `8443`                                              | Metrics service port                                  |
| `metrics.service.targetPort`                   | `metrics`                                           | Metrics service target port                           |
| `metrics.service.additionalLabels`             | `{}`                                                | Additional labels for the metrics service             |
| `metrics.authRole.create`                      | `true`                                              | Create authn/authz RBAC for secure metrics            |
| `metrics.authRole.name`                        | `agent-forge-operator-metrics-auth`                 | Metrics auth role name                                |
| `metrics.readerRole.create`                    | `false`                                             | Create a cluster role that can read `/metrics`        |
| `metrics.readerRole.name`                      | `agent-forge-operator-metrics-reader`               | Metrics reader role name                              |
| `metrics.serviceMonitor.enabled`               | `false`                                             | Enable ServiceMonitor                                 |
| `metrics.serviceMonitor.namespace`             | same as release namespace                           | Namespace for the ServiceMonitor                      |
| `metrics.serviceMonitor.additionalLabels`      | `{}`                                                | Additional labels for the ServiceMonitor              |
| `metrics.serviceMonitor.scrapeInterval`        | `60s`                                               | Scrape interval for the ServiceMonitor                |
| `metrics.serviceMonitor.scheme`                | `https`                                             | Metrics scrape scheme                                 |
| `metrics.serviceMonitor.bearerTokenFile`       | `/var/run/secrets/kubernetes.io/serviceaccount/token` | Bearer token file for secure metrics                |
| `metrics.serviceMonitor.tlsConfig`             | `{insecureSkipVerify: true}`                        | TLS config for the ServiceMonitor                     |
| `metrics.prometheusRule.enabled`               | `false`                                             | Enable PrometheusRule                                 |
| `metrics.prometheusRule.namespace`             | same as release namespace                           | Namespace for the PrometheusRule                      |
| `metrics.prometheusRule.additionalLabels`      | `{}`                                                | Additional labels for the PrometheusRule              |
| `livenessProbe.enabled`                        | `true`                                              | If `true`, enables livenessProbe for the deployment   |
| `readinessProbe.enabled`                       | `true`                                              | If `true`, enables readinessProbe for the deployment  |
| `nodeSelector`                                 | `{}`                                                | Node Selector properties for the deployment           |
| `tolerations`                                  | `[]`                                                | Tolerations properties for the deployment             |
| `affinity`                                     | `{}`                                                | Affinity properties for the deployment                |
| `sidecars`                                     | `[]`                                                | Add additional sidecar containers to the operator pod |

## CRD Upgrades

Helm installs CRDs from the chart `crds/` directory on first install, but does not upgrade or delete CRDs during normal chart upgrades. When using the Commodore component, CRDs are rendered into the catalog and managed by Argo CD together with the operator resources.

## Upgrading to 1.3.2

This patch fixes `DiscoveryImageChangedBeforeUpload`: the operator hashes and
uploads the same downloaded ISO snapshot. Workers stuck before discovery-volume
or instance creation recover automatically, preserving their existing port and OS
volume. Shared image references and restart recovery are respected; discovery
media on running workers is never replaced. CRDs, RBAC, and Helm values are
unchanged from 1.3.1.

```shell
helm repo update containeroo
helm upgrade agent-forge-operator containeroo/agent-forge-operator \
  --namespace agent-forge-operator-system --version 1.3.2 \
  --reuse-values --set-string image.tag=v1.3.2
```

Use your existing release name and namespace. After upgrading, affected workers
may briefly report `RefreshingDiscoveryImage` while the obsolete cache reference
is released. No worker deletion, status reset, or OS volume recreation is needed.
If cleanup fails, the condition message reports the error and recovery resumes
on a later reconciliation. `DiscoveryImageRefreshBlocked` indicates provisioning
has advanced beyond safe image refresh; do not bypass that guard.

## Upgrading to 1.3.1

This patch adds safe OpenStack diagnostics in worker condition messages and logs,
and explicit HTTP support through the credentials Secret. CRDs and RBAC are
unchanged from 1.3.0. If upgrading from an earlier version, apply the release CRDs
first as described below.

```shell
helm repo update containeroo
helm upgrade agent-forge-operator containeroo/agent-forge-operator \
  --namespace agent-forge-operator-system --version 1.3.1 \
  --reuse-values --set-string image.tag=v1.3.1
```

Use your existing release name and namespace. The explicit image tag overrides
any old tag retained by `--reuse-values`. For an HTTP-only OpenStack deployment,
opt in on its existing credentials Secret (use your own namespace and Secret name):

```shell
kubectl -n example-cluster patch secret example-openstack-credentials \
  --type=merge -p '{"stringData":{"allow-insecure-http":"true"}}'
```

Keep `auth-url` set to the scheme actually served by Keystone. This opt-in permits
HTTP for authentication and service catalog endpoints; credentials and tokens
travel without TLS protection. HTTPS remains the default, and HTTPS certificate
verification is always enabled. The Secret change takes effect on existing workers
without replacing them. The chart does not manage credentials or transport policy.

Read `.status.conditions[].message` on the `OpenStackAgent` for the failed service,
operation, safe category, HTTP status, and validated request ID where available.
Raw errors, response bodies, endpoints, and credentials remain excluded. See the
[OpenStack troubleshooting guide](https://github.com/containeroo/agent-forge-operator/blob/v1.3.1/docs/openstack.md#troubleshooting-and-recovery).

## Upgrading to 1.3.0

Apply the release CRDs **before** upgrading the controller. Helm does not update
CRDs from `crds/` on upgrade, so `helm upgrade` alone is insufficient when adding
the OpenStack provider. The bundle includes updated vSphere schemas too.

```shell
kubectl apply --server-side -f https://github.com/containeroo/agent-forge-operator/releases/download/v1.3.0/crds.yaml
helm repo update containeroo
helm upgrade agent-forge-operator containeroo/agent-forge-operator \
  --namespace agent-forge-operator-system --version 1.3.0 \
  --reuse-values --set-string image.tag=v1.3.0
```

Use your existing Helm release name and namespace if they differ. The explicit
image tag overrides any tag retained from previous values. If you use a custom
registry, make image `v1.3.0` available there first. If `clusterRole.create=false`,
update the externally managed role with the new OpenStack and cache permissions.
The chart does not create or read OpenStack credentials. Supply a Secret in each
pool namespace and configure `OpenStackAgentPool` separately.

See the [OpenStack setup guide](https://github.com/containeroo/agent-forge-operator/blob/v1.3.0/docs/openstack.md)
for authentication, examples, cleanup, and compatibility checks. OpenStack keeps
the discovery ISO attached for the entire worker lifetime: OS boot index 0,
ISO CD-ROM boot index 1. Validate firmware fallback and reboot behavior before
production use. Retained ISO media can contain sensitive bootstrap material.
The vSphere ISO ejection setting and existing Helm value names remain unchanged.

## Upgrading to 1.2.0

Apply the updated CRDs before upgrading the controller; Helm does not upgrade
resources in `crds/` during a normal Helm upgrade:

```shell
kubectl apply -f https://github.com/containeroo/agent-forge-operator/releases/download/v1.2.0/crds.yaml
```

Automatic discovery ISO ejection is disabled by default. Enable it on an individual
`VsphereAgentPool` with `spec.iso.ejectAfterInstall: true` after canary validation.
This is a pool setting, not a Helm value. Persisted in-progress ejections complete
across restarts and after opt-out. This release adds the required `status.isoEjection`
recovery fields to the `VsphereAgent` CRD.
