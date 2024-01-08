output "storage_class_name" {
  description = ""
  value = kubernetes_storage_class.minikube_host_storage_class.metadata[0].name
}