// 1. block type
// 2. resource type
// 3. object reference

# Terraform init -> Initialize the working director

resource "random_string" "suffix" {
  // attributes here
  length  = 6
  upper   = false
  special = false
}

locals {
  environment_prefix = "${var.application_name}-${var.environment_name}-${random_string.suffix.result}"
}

locals {
  min_nodes = 5
  max_nodes = 9
}

resource "random_string" "list" {
  count = length(var.regions)

  length  = 6
  upper   = false
  special = false
}

resource "random_string" "map" {
  for_each = var.region_instance_count

  length  = 6
  upper   = false
  special = false
}
