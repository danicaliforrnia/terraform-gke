variable "project_id" {
  description = "El ID del proyecto donde estará el clúster"
}
variable "cluster_name" {
  type        = string
  description = "El nombre del clúster"
  default     = "imagina-gke"
}
variable "cluster_description" {
  type        = string
  description = "Descripción del clúster"
  default     = "Clúster de producción"
}
variable "env_name" {
  type        = string
  description = "El ambiente en la nube"
  default     = "prod"
}
variable "region" {
  type        = string
  description = "La región donde estará el clúster"
  default     = "europe-west1"
}
variable "network_name" {
  description = "La red VPC creada para el clúster"
  default     = "gke-network"
}
variable "subnetwork_name" {
  type        = string
  description = "La subred creada para el clúster"
  default     = "gke-subnet"
}
variable "subnetwork_ip" {
  type        = string
  description = "La dirección IP de la subred"
  default     = "10.10.0.0/16"
}
variable "master_range" {
  type        = string
  description = "El rango de direcciones IP para el plano de control"
  default     = "10.20.0.0/16"
}
variable "ip_range_pods_name" {
  type        = string
  description = "Nombre del rango de direcciones IP para los Pods"
  default     = "ip-range-pods"
}
variable "ip_range_pods" {
  type        = string
  description = "El rango de direcciones IP para los Pods"
  default     = "10.30.0.0/16"
}
variable "ip_range_services_name" {
  type        = string
  description = "Nombre del rango de direcciones IP para los Services"
  default     = "ip-range-services"
}
variable "ip_range_services" {
  type        = string
  description = "El rango de direcciones IP para los Services"
  default     = "10.40.0.0/16"
}
variable "artifact_registry_name" {
  type        = string
  description = "El nombre del Artifact Registry"
  default     = "imagina-registry"
}
variable "artifact_registry_description" {
  type        = string
  description = "La descripción del Artifact Registry"
  default     = "Registro privado de imagenes Docker"
}
variable "git_repo" {
  type        = string
  description = "Nombre del Repositorio Git"
}
variable "gcs_state_bucket" {
  type        = string
  description = "Nombre del bucket para almacenar el estado de Terraform"
}