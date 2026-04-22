{{/*
Expand the name of the chart.
*/}}
{{- define "terrascaler.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "terrascaler.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "terrascaler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "terrascaler.labels" -}}
helm.sh/chart: {{ include "terrascaler.chart" . }}
{{ include "terrascaler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "terrascaler.selectorLabels" -}}
app.kubernetes.io/name: {{ include "terrascaler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "terrascaler.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "terrascaler.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the GitLab token secret name.
*/}}
{{- define "terrascaler.gitlabTokenSecretName" -}}
{{- default (printf "%s-gitlab" (include "terrascaler.fullname" .)) .Values.gitlab.existingSecret }}
{{- end -}}

{{/*
Create the name of the cluster role to use.
*/}}
{{- define "terrascaler.clusterRoleName" -}}
{{- if .Values.clusterRole.create -}}
    {{ default (include "terrascaler.fullname" .) .Values.clusterRole.name }}
{{- else -}}
    {{ default "default" .Values.clusterRole.name }}
{{- end -}}
{{- end -}}
