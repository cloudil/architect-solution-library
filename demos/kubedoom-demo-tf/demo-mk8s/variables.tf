variable "network_name" {
  description = "network-name for k8s kubedoom demo"
  type        = string
  default     = "kubedoom-network"
}

variable "network_description" {
  description = "network-description for k8s kubedoom demo"
  type        = string
  default     = "Network for k8s kubedoom demo"
}

variable "subnet_cidr" {
  description = "subnet for k8s kubedoom demo"
  default = "10.120.0.0/16"
}
variable "k8s_service_ipv4_range" {
  type        = string
  default     = "10.150.0.0/16"
  description = "CIDR for k8s services"
}

variable "k8s_pod_ipv4_range" {
  type        = string
  default     = "10.140.0.0/16"
  description = "CIDR for pods in k8s cluster"
}
variable "k8s_whitelist" {
  type        = list(any)
  default     = ["0.0.0.0/0"]
  description = "Range of ip-addresses which can access cluster API with kubectl etc"
}

variable "labels" {
  description = "A set of key/value label pairs to assign."
  type        = map(string)
  default = {
    demo = "k8s-kubedoom"
  }
}