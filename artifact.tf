resource "google_artifact_registry_repository" "imagina_registry" {
  location      = var.region
  repository_id = "${var.artifact_registry_name}-${var.env_name}"
  description   = var.artifact_registry_description
  format        = "DOCKER"
}