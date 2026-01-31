module "network" {
  source              = "../../modules/network"
  project_id          = var.project_id
  region              = var.region
  network_name        = "ms-vpc"
  public_subnet_cidr  = "10.10.0.0/24"
  private_subnet_cidr = "10.20.0.0/24"
  pods_range_name     = "pods-range"
  pods_range_cidr     = "10.30.0.0/16"
  services_range_name = "services-range"
  services_range_cidr = "10.40.0.0/20"
}

module "gke" {
  source               = "../../modules/gke"
  project_id           = var.project_id
  region               = var.region
  cluster_name         = "ms-gke"
  network_self_link    = module.network.network_self_link
  subnetwork_self_link = module.network.private_subnet_self_link
  pods_range_name      = module.network.pods_range_name
  services_range_name  = module.network.services_range_name
  node_locations       = var.zones
  node_machine_type    = "e2-medium"
  node_count           = 1
}