resource "google_service_account" "nodes_service_account" {
  account_id   = "${var.env_name}-node-sa"
  display_name = "GCP Service Account for nodes in ${var.env_name} environment"
}

resource "google_project_iam_member" "nodes_service_account_roles" {
  project = var.project_id
  role    = "roles/container.nodeServiceAccount"
  member  = "serviceAccount:${google_service_account.nodes_service_account.email}"
}

resource "google_service_account" "backend_service_account" {
  account_id   = "${var.env_name}-backend-sa"
  display_name = "GCP Service Account bound to Backend Service Account in ${var.env_name} environment"
}

resource "google_service_account_iam_binding" "backend_service_account_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${google_service_account.backend_service_account.email}"
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[backend/backend-sa]",
  ]
}

resource "google_artifact_registry_repository_iam_member" "repo_iam" {
  repository = google_artifact_registry_repository.imagina_registry.name
  location   = google_artifact_registry_repository.imagina_registry.location
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.nodes_service_account.email}"
}