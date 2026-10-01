{{/*
This file defines reusable helpers for the Helm chart. Each define block is a
named template, similar to a function, that other templates can call with "include"
to fill in parts of the Kubernetes YAML, such as names, labels, and image references.
Helm evaluates these helpers when rendering the chart; they do not run inside
the containers. This file does not create a Kubernetes resource on its own.
*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "hello-world.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "hello-world.fullname" -}}
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
{{- define "hello-world.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hello-world.labels" -}}
helm.sh/chart: {{ include "hello-world.chart" . }}
app.kubernetes.io/name: {{ include "hello-world.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Build image reference from registry, repository, and tag.
Usage: {{ include "hello-world.image" (dict "image" .Values.job.image "global" .Values.global) }}
*/}}
{{- define "hello-world.image" -}}
{{- $registry := .global.imageRegistry -}}
{{- $repository := .image.repository -}}
{{- $tag := default .global.imageTag .image.tag -}}
{{- if $registry -}}
{{- printf "%s/%s:%s" $registry $repository $tag -}}
{{- else -}}
{{- printf "%s:%s" $repository $tag -}}
{{- end -}}
{{- end }}
