package kubernetes

# Conftest policy for basic Kubernetes security/operational hygiene.
# It is intentionally minimal and focused for an educational CI/CD pipeline.

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.securityContext.allowPrivilegeEscalation == false
  msg := sprintf("container %q must set securityContext.allowPrivilegeEscalation=false", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.securityContext.runAsNonRoot == true
  msg := sprintf("container %q must set securityContext.runAsNonRoot=true", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not has_drop_all(c)
  msg := sprintf("container %q must drop ALL capabilities", [c.name])
}

has_drop_all(c) {
  drops := c.securityContext.capabilities.drop
  drops[_] == "ALL"
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.resources.requests.cpu
  msg := sprintf("container %q must set resources.requests.cpu", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.resources.requests.memory
  msg := sprintf("container %q must set resources.requests.memory", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.resources.limits.cpu
  msg := sprintf("container %q must set resources.limits.cpu", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.resources.limits.memory
  msg := sprintf("container %q must set resources.limits.memory", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.readinessProbe
  msg := sprintf("container %q must define a readinessProbe", [c.name])
}

deny[msg] {
  input.kind == "Deployment"
  some i
  c := input.spec.template.spec.containers[i]
  not c.livenessProbe
  msg := sprintf("container %q must define a livenessProbe", [c.name])
}
