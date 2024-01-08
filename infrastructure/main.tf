provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_namespace" "jenkins_namespace" {
  metadata {
    name = "jenkins"
  }
}

resource "kubernetes_cluster_role" "jenkins_cluster_role" {
  metadata {
    name = var.jenkins_cluster_role
  }

  rule {
    api_groups = var.jenkins_cluster_role_rule["api_groups"]
    resources = var.jenkins_cluster_role_rule["resources"]
    verbs = var.jenkins_cluster_role_rule["verbs"]
  }
}

resource "kubernetes_service_account" "jenkins_service_account" {
  metadata {
    name = "jenkins-admin"
    namespace = kubernetes_namespace.jenkins_namespace.metadata[0].name
  }
}

resource "kubernetes_cluster_role_binding" "jenkins_account_role_binding" {

  metadata {
    name = kubernetes_service_account.jenkins_service_account.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = kubernetes_cluster_role.jenkins_cluster_role.metadata[0].name
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.jenkins_service_account.metadata[0].name
    namespace = kubernetes_namespace.jenkins_namespace.metadata[0].name
  }

}