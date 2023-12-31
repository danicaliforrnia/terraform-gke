module "network" {
  source       = "terraform-google-modules/network/google"
  version      = "7.3.0"
  project_id   = var.project_id
  network_name = "${var.network_name}-${var.env_name}"

  subnets = [
    {
      subnet_name   = "${var.subnetwork_name}-${var.env_name}"
      subnet_ip     = var.subnetwork_ip
      subnet_region = var.region
    },
  ]

  secondary_ranges = {
    "${var.subnetwork_name}-${var.env_name}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = var.ip_range_pods
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = var.ip_range_services
      },
    ]
  }
}

resource "google_compute_global_address" "frontend" {
  name = "public-ip"
}