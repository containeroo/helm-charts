# Containeroo Helm Charts

This repository contains [Helm](https://helm.sh) charts for the following projects:

* autovpa
* cloudflare-operator
* agent-forge-operator
* terrascaler
* local-path-provisioner (created by Rancher)
* nfs-client-provisioner (created by Kubernetes SIG External Storage)
  (DEPRECATED: use
  [nfs-subdir-external-provisioner](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)
  instead)
* cert-manager-webhook-bluecat
* filesystem-exporter
* kube-ephemeral-container-exporter

## Adding this Repository to Helm

Add the repository to Helm:

```bash
helm repo add containeroo https://charts.containeroo.ch
```
