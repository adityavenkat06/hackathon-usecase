output "cluster_name" {
  value = module.gke.cluster_name
}

output "cluster_location" {
  value = module.gke.cluster_location
}

output "artifact_registry_repository" {
  value = module.artifact_registry.repository_id
}
