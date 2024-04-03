
# Comprehensive Guide on Using LimitRange in Helm Charts

This document provides an in-depth look at how i used `LimitRange` objects within Helm charts to manage resource allocations for Kubernetes pods. We'll break down each component of the examples provided to ensure a thorough understanding of their purposes and how they integrate into Helm charts.

## Example 1: Basic LimitRange Definition

This example defines a `LimitRange` that sets maximum resource limits for pods and default request and limit values for containers within those pods.

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: {{ include "chart.fullname" . }}-limitrange
  labels:
    {{- include "chart.labels" . | nindent 4 }}
spec:
  limits:
    - type: Pod
      max:
        memory: "1Gi"
        cpu: "1000m"
    - type: Container
      defaultRequest:
        memory: "64Mi"
        cpu: "100m"
      default:
        memory: "128Mi"
        cpu: "200m"
      max:
        memory: "256Mi"
        cpu: "400m"
```

### Breakdown:

- `apiVersion`, `kind`, `metadata`: Standard Kubernetes YAML configuration indicating the resource type (`LimitRange`) and metadata.
- `{{ include "chart.fullname" . }}-limitrange`: Dynamically sets the `LimitRange` name using the Helm template function that generates a full name based on the release.
- `{{- include "chart.labels" . | nindent 4 }}`: Applies labels from the chart's `_helpers.tpl` file, properly indented.
- `spec.limits`: Specifies limits for `Pod` and `Container` types, including maximum limits for pods and default requests/limits for containers.

## Example 2: Conditional LimitRange with Values from `values.yaml`

This example shows a conditional `LimitRange` definition that uses values from the chart's `values.yaml` file, allowing customization based on user preferences.

```yaml
{{- if .Values.limitRange.enabled }}
apiVersion: v1
kind: LimitRange
metadata:
  name: {{ include "chart.fullname" . }}-limitrange
  labels:
    {{- include "chart.labels" . | nindent 4 }}
spec:
  limits:
    - type: Container
      defaultRequest:
        memory: "{{ .Values.limitRange.defaultRequest.memory }}"
        cpu: "{{ .Values.limitRange.defaultRequest.cpu }}"
      default:
        memory: "{{ .Values.limitRange.default.memory }}"
        cpu: "{{ .Values.limitRange.default.cpu }}"
      max:
        memory: "{{ .Values.limitRange.max.memory }}"
        cpu: "{{ .Values.limitRange.max.cpu }}"
{{- end }}
```

### Breakdown:

- `{{- if .Values.limitRange.enabled }} ... {{- end }}`: Conditionally creates the `LimitRange` based on a value in `values.yaml`, allowing the `LimitRange` to be toggled on or off.
- Values like `{{ .Values.limitRange.defaultRequest.memory }}` are placeholders that get replaced with actual values from the `values.yaml` file, making the chart highly configurable.

## Example 3: Configurations in `values.yaml`

These configurations in `values.yaml` allow users to customize the `LimitRange` without altering the chart's templates.

```yaml
limitRange:
  enabled: true
  defaultRequest:
    memory: "64Mi"
    cpu: "100m"
  default:
    memory: "128Mi"
    cpu: "200m"
  max:
    memory: "256Mi"
    cpu: "400m"
```

### Breakdown:

- `limitRange`: Top-level key in `values.yaml` for `LimitRange` configurations.
- `enabled`: A boolean flag to enable or disable the creation of the `LimitRange` object.
- `defaultRequest`, `default`, `max`: Specify the default request values, default limit values, and maximum allowable limits for memory and CPU resources, respectively.

## Common Problems and Solutions

### 1. Check Helm Release

If you're managing your Kubernetes resources using Helm, and you've updated your charts to include a `LimitRange`, it's essential to ensure the release was successfully upgraded.

**Commands:**

```bash
helm list
helm status <release-name>
```

### 2. Inspect the Applied LimitRange

To verify that your `LimitRange` has been applied to the namespace:

```bash
kubectl get limitrange -n <namespace>
kubectl describe limitrange <limitrange-name> -n <namespace>
```

### 3. Understand LimitRange Behavior

- **Existing Pods/Containers**: `LimitRange` does not change resources for already running pods.
- **New Pods/Containers**: Applies default requests and limits for newly created or recreated pods.

### 4. Pod Specifications

Ensure pods do not specify resource requests and limits that override the `LimitRange`. Adjust the pod specifications if necessary.

### 5. Debugging and Logging

For issues applying the `LimitRange`, use the `--debug` flag with `helm upgrade` to check for errors or warnings.

```bash
helm upgrade <release-name> <chart-path> --debug
```

By following these guidelines, you can effectively use `LimitRange` to manage resource allocation within your Kubernetes namespaces, ensuring efficient and optimized use of cluster resources.


## Summary

These examples illustrate how Helm charts can dynamically manage Kubernetes `LimitRange` objects using templates and values from `values.yaml`. This approach provides flexibility, allowing resource constraints to be customized per deployment without changing the core chart templates.

