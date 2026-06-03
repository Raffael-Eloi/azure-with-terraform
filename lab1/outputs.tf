output "application_name_out" {
  value = var.application_name
}

output "environment_name_out" {
  value = var.environment_name
}

output "environment_prefix" {
  value = local.environment_prefix
}

output "suffix" {
  value = random_string.suffix.result
}

output "api_key" {
  value     = "${var.api_key}bar"
  sensitive = true
}

output "primary_region" {
  value = var.regions[0]
}

output "primary_region_instance_count" {
  value = var.region_instance_count[var.regions[0]]
}

output "kind" {
  value = var.sku_settings.kind
}

output "alpha" {
  value = module.alpha.random_string
}

output "bravo" {
  value = module.bravo.random_string
}

output "charlie" {
  // not sure
  value = module.charlie.charlie
}
