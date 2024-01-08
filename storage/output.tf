output "pvc_name" {
  description = ""
  value = kubernetes_persistent_volume_claim.jenkins_pv_claim.metadata[0].name
}

output "pvc_namespace" {
  description = ""
  value = kubernetes_persistent_volume_claim.jenkins_pv_claim.metadata[0].namespace
}

output "pvc_accessmode" {
  description = ""
  value = kubernetes_persistent_volume_claim.jenkins_pv_claim.access_modes
}