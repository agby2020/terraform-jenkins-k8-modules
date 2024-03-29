provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_deployment" "jenkins_deployment" {

  metadata {
    name = var.deployment_name
    namespace = var.namespace
  }

  spec {

    replicas = var.replicas_count

    selector {
      match_labels = {"app": var.selector_app}
    }

    template {

      metadata {
        labels = {"app": var.selector_app}
      }

      spec {

        security_context {
            fs_group = var.fs_group
            run_as_user = var.run_as_user
        }

        service_account_name = var.service_account_name
        

        container {
          name = "jenkins"
          image = var.image

          env {
            name = "CASC_JENKINS_CONFIG"
            value = var.jenkins_casc_configs_dir
          }

          resources {
            limits = {memory: var.limit_memory, cpu: var.limit_cpu}
            requests = {memory: var.request_memory, cpu: var.request_cpu}
          }

          port {
            name = "httpport"
            container_port = var.httpport
          }

          port {
            name = "jnlpport"
            container_port = var.jnlpport
          }

          liveness_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            initial_delay_seconds = 60
            period_seconds = 10
            timeout_seconds = 5
            failure_threshold = 3
          }

          readiness_probe {
            http_get {
              path = "/login"
              port = 8080
            }
            initial_delay_seconds = 60
            period_seconds = 10
            timeout_seconds = 5
            failure_threshold = 3
          }

          dynamic "volume_mount" {
            for_each = var.pvc_mounts
            content {
              name = join("-", [ "pvc", volume_mount.key ])
              mount_path = volume_mount.value
            }
          }

          dynamic "volume_mount" {
            for_each = var.casc_configs
            content {
              name = volume_mount.value
              mount_path = join("", [ var.jenkins_casc_configs_dir, "/", volume_mount.value, ".yaml"])
              read_only = true
            }
          }
        }


        dynamic "volume" {
          for_each = var.pvc_mounts
          content {
            name = join("-", [ "pvc", volume.key ])
            persistent_volume_claim {
              claim_name = volume.key
            }
          }
        }

        dynamic "volume" {
          for_each = var.casc_configs
          content {
            name = volume.value
            config_map {
              name = volume.value
            }
          }
        }

      }

    }

  }

}