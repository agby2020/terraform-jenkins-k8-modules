provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_config_map" "casc_config_map" {
    for_each = toset(var.casc_config_files)
    metadata {
        name = join("-", [ "casc", each.key ])
        namespace = var.namespace
    }

  data  = {
    "jenkins.yaml" = file(join(".", [ each.key, "yaml" ]))
  }
}