variable "deployment_name" {
  description = ""
  default = "jenkins"
  type = string
}

variable "namespace" {
  description = ""
  default = "jenkins"
  type = string
}

variable "selector_app" {
  description = ""
  default = "jenkins-server"
  type = string
}

variable "replicas_count" {
  description = ""
  default = 1
  type = number
}

variable "fs_group" {
  description = ""
  default = 1000
  type = number
}

variable "run_as_user" {
  description = ""
  default = 1000
  type = number
}

variable "image" {
  description = ""
  default = "jenkins/jenkins:lts"
  type = string
}

variable "request_cpu" {
  description = ""
  default = "1000m"
  type = string
}

variable "limit_cpu" {
  description = ""
  default = "1000m"
  type = string
}

variable "request_memory" {
  description = ""
  default = "2G"
  type = string
}

variable "limit_memory" {
  description = ""
  default = "2G"
  type = string
}

variable "service_account_name" {
  description = ""
  default = "jenkins-admin"
  type = string
}

variable "jenkins_home" {
  description = ""
  default = "/var/jenkins_home"
  type = string
}

variable "jenkins_casc_configs_dir" {
  description = ""
  default = "/var/jenkins_home/casc_configs/"
  type = string
}

# HArdcoded values - due to the current inability to use variable sin default values definitions
variable "pvc_mounts" {
  description = ""

  default = {
    jenkins-home = "/var/jenkins_home"
    jenkins-jobs = "/var/jenkins_home/jobs"
  }

  type = map(string)
}

variable "casc_configs" {
  description = ""
  default = ["jenkins"]
  type = list(string)
}

variable "httpport" {
  description = ""
  default = 8080
  type = number
}

variable "jnlpport" {
  description = ""
  default = 50000
  type = number
}