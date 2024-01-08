variable "pvc_name" {
  description = ""
  default = "jenkins-home"
  type = string
}

variable "pvc_namespace" {
  description = ""
  default = "jenkins"
  type = string
}

variable "storage_class_name" {
  description = ""
  default = "minikube-host"
  type = string
}

variable "requested_volume" {
  description = ""
  default = "1G"
  type = string
}

variable "limit_volume" {
  description = ""
  default = "3G"
  type = string
}

variable "pvc_accessmode" {
  description = ""
  default = [ "ReadWriteOnce" ]
  type = list(string)
}