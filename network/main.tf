provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_service" "jenkins_service" {
  metadata {
    name = var.jenkins_service_name
    namespace = var.jenkins_namespace
  }
  spec {
    selector = {"app": var.selector_app}
    type = "NodePort"
    port {
      port = var.port
      target_port = var.target_port
      node_port   = var.node_port
    }
  }
}