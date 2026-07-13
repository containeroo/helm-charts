{{/*
Expand the name of the chart.
*/}}
{{- define "chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "chart.fullname" -}}
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
Common labels.
*/}}
{{- define "chart.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{ include "chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: controller
{{- end }}

{{/*
Create the name of the service account to use.
*/}}
{{- define "chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use.
*/}}
{{- define "chart.clusterRoleName" -}}
{{- if .Values.clusterRole.create -}}
{{ default (printf "%s-manager" (include "chart.fullname" .)) .Values.clusterRole.name }}
{{- else -}}
{{ default "default" .Values.clusterRole.name }}
{{- end -}}
{{- end -}}

{{/*
Resolve the namespace to use for namespaced objects.
*/}}
{{- define "chart.namespaceName" -}}
{{- default .Release.Namespace .Values.namespace.name -}}
{{- end -}}

{{/*
Metrics auth cluster role name.
*/}}
{{- define "chart.metricsAuthClusterRoleName" -}}
{{- default (printf "%s-metrics-auth" (include "chart.fullname" .)) .Values.metrics.rbac.name -}}
{{- end -}}

{{/*
Leader election role name.
*/}}
{{- define "chart.leaderElectionRoleName" -}}
{{- printf "%s-leader-election" (include "chart.fullname" .) -}}
{{- end -}}

{{/*
Metrics service name.
*/}}
{{- define "chart.metricsServiceName" -}}
{{- printf "%s-metrics" (include "chart.fullname" .) -}}
{{- end -}}

{{/*
ServiceMonitor name.
*/}}
{{- define "chart.serviceMonitorName" -}}
{{- printf "%s-metrics-monitor" (include "chart.fullname" .) -}}
{{- end -}}

{{/*
PrometheusRule name.
*/}}
{{- define "chart.prometheusRuleName" -}}
{{- printf "%s-alerts" (include "chart.fullname" .) -}}
{{- end -}}
