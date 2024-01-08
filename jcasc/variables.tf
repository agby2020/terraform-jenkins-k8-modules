variable "namespace" {
  description = ""
  default = "jenkins"
  type = string
}

variable "casc_config_files" {
  description = ""
  default = [ "jenkins" ]
  type = list(string)
}