variable "service_name" {
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

variable "port" {
  description = ""
  default = 8080
  type = number
}

variable "target_port" {
  description = ""
  default = 8080
  type = number
}

variable "node_port" {
  description = ""
  default = 30000
  type = number
}