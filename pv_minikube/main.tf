provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_storage_class" "minikube_host_storage_class" {
  metadata {
    name = var.name
  }

  storage_provisioner = "k8s.io/minikube-hostpath"
  volume_binding_mode = "Immediate"
}