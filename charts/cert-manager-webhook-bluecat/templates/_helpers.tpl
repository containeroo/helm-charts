{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "bluecat-webhook.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bluecat-webhook.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bluecat-webhook.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "bluecat-webhook.selfSignedIssuer" -}}
{{ printf "%s-selfsign" (include "bluecat-webhook.fullname" .) }}
{{- end -}}

{{- define "bluecat-webhook.rootCAIssuer" -}}
{{ printf "%s-ca" (include "bluecat-webhook.fullname" .) }}
{{- end -}}

{{- define "bluecat-webhook.rootCACertificate" -}}
{{ printf "%s-ca" (include "bluecat-webhook.fullname" .) }}
{{- end -}}

{{- define "bluecat-webhook.servingCertificate" -}}
{{ printf "%s-webhook-tls" (include "bluecat-webhook.fullname" .) }}
{{- end -}}
