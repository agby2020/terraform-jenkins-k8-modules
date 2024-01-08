variable "jenkins_namespace" {
  description = ""
  default = "jenkins"
  type = string
}

variable "jenkins_cluster_role" {
  description = ""
  default = "jenkins-admin"
  type = string
}

variable "jenkins_cluster_role_rule" {
  description = ""
  
  default = {
    api_groups = [""]
    resources = ["*"]
    verbs = ["*"]
  }

  type = map(list(string))
  
}

variable "jenkins_service_account" {
  description = ""
  default = "jenkins-admin"
  type = string
}