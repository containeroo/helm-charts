# Containeroo Helm Charts

This repository contains [Helm](https://helm.sh) charts for the following projects:

* cloudflare-operator
* local-path-provisioner (created by Rancher)
* nfs-client-provisioner (created by Kubernetes SIG External Storage) (DEPRECATED: use https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner instead)
* cert-manager-webhook-bluecat

## Adding this Repository to Helm

Add the repository to Helm:

```bash
helm repo add containeroo https://charts.containeroo.ch
```
