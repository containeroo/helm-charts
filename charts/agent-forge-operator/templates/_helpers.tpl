{{/*
Expand the name of the chart.
*/}}
{{- define "agent-forge-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "agent-forge-operator.fullname" -}}
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
{{- define "agent-forge-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "agent-forge-operator.labels" -}}
helm.sh/chart: {{ include "agent-forge-operator.chart" . }}
{{ include "agent-forge-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "agent-forge-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "agent-forge-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "agent-forge-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "agent-forge-operator.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the cluster role to use.
*/}}
{{- define "agent-forge-operator.clusterRoleName" -}}
{{- if .Values.clusterRole.create -}}
    {{ default (include "agent-forge-operator.fullname" .) .Values.clusterRole.name }}
{{- else -}}
    {{ default "default" .Values.clusterRole.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the leader election role to use.
*/}}
{{- define "agent-forge-operator.leaderElectionRoleName" -}}
{{- if .Values.leaderElectionRole.create -}}
    {{ default (printf "%s-leader-election" (include "agent-forge-operator.fullname" .)) .Values.leaderElectionRole.name }}
{{- else -}}
    {{ default "default" .Values.leaderElectionRole.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the metrics auth role to use.
*/}}
{{- define "agent-forge-operator.metricsAuthRoleName" -}}
{{- default (printf "%s-metrics-auth" (include "agent-forge-operator.fullname" .)) .Values.metrics.authRole.name }}
{{- end -}}
