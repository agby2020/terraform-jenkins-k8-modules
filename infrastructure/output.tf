output "jenkins_namespace" {
  description = ""
  value = kubernetes_namespace.jenkins_namespace.metadata[0].name
}

output "jenkins_service_account" {
  description = ""
  value = kubernetes_service_account.jenkins_service_account.metadata[0].name
}