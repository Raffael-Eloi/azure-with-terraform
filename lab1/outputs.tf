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
