provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_service" "jenkins_service" {
  metadata {
    name = var.service_name
    namespace = var.namespace
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

resource "kubernetes_secret" "jenkins_tls_secret" {
  metadata {
    name      = var.tls_secret_name
    namespace = var.namespace
  }

  data = {
    "tls.crt" = file("jenkins.crt")
    "tls.key" = file("jenkins.key")
  }
}

resource "kubernetes_ingress_v1" "jenkins_ingress" {

  metadata {
    name      = var.ingress_name
    namespace = var.namespace
  }

  spec {
    tls {
      hosts      = [ var.jenkins_domain_names ]  # Replace with your Jenkins domain
      secret_name = kubernetes_secret.jenkins_tls_secret.metadata[0].name
    }

   rule {
      host = each.key
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.jenkins_service.metadata[0].name
              port {
                number = var.ingress_port
              }
            }
          }
        }
      }
    }

  }

}
