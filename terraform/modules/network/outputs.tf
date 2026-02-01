output "network_self_link" {
  value = google_compute_network.vpc.self_link
}

output "private_subnet_self_link" {
  value = google_compute_subnetwork.private.self_link
}

output "public_subnet_self_link" {
  value = google_compute_subnetwork.public.self_link
}

output "pods_range_name" {
  value = var.pods_range_name
}

output "services_range_name" {
  value = var.services_range_name
}
