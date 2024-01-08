provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_persistent_volume_claim" "jenkins_pv_claim" {
  metadata {
    name = var.pvc_name
    namespace = var.pvc_namespace
  }
  spec {
    storage_class_name = var.storage_class_name
    access_modes = var.pvc_accessmode

    resources {
        requests = {"storage" = "3Gi"}
        limits = {storage = "5Gi"}
    }
  }
}