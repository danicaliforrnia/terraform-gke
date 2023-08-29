provider "google" {
  project = var.project_id
  region  = var.region
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                         = "27.0.0"
  project_id                      = var.project_id
  name                            = "${var.cluster_name}-${var.env_name}"
  description                     = var.cluster_description
  regional                        = true
  region                          = var.region
  network                         = module.network.network_name
  subnetwork                      = module.network.subnets_names[0]
  ip_range_pods                   = var.ip_range_pods_name
  ip_range_services               = var.ip_range_services_name
  master_ipv4_cidr_block          = var.master_range
  network_policy                  = true
  horizontal_pod_autoscaling      = true
  enable_vertical_pod_autoscaling = true
  remove_default_node_pool        = true
  gke_backup_agent_config         = true
  identity_namespace              = "enabled"

  node_pools = [
    {
      name            = "${var.cluster_name}-node-pool-${var.env_name}"
      machine_type    = "e2-standard-4"
      min_count       = 2
      max_count       = 5
      disk_size_gb    = 30
      auto_repair     = true
      auto_upgrade    = true
      service_account = google_service_account.nodes_service_account.email
    }
  ]
}

resource "google_gke_backup_backup_plan" "basic" {
  name     = "backup-plan-${var.env_name}"
  cluster  = module.gke.cluster_id
  location = var.region
  retention_policy {
    backup_retain_days = 7
  }
  backup_schedule {
    cron_schedule = "0 0 * * *"
  }
  backup_config {
    include_volume_data = true
    include_secrets     = true
    all_namespaces      = true
  }
}