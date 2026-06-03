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

  regional_stamps = [
    {
      region         = "westus"
      name           = "vt-test-a"
      min_node_count = 4
      max_node_count = 8
    },
    {
      region         = "eastus"
      name           = "vt-test-b"
      min_node_count = 4
      max_node_count = 8
    }
  ]

  regional_stamps_map = {
    "vt-test-a" = {
      region         = "westus"
      min_node_count = 4
      max_node_count = 8
    },
    "vt-test-b" = {
      region         = "eastus"
      min_node_count = 4
      max_node_count = 8
    }
  }
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

resource "random_string" "if" {

  count = var.enabled ? 1 : 0

  length  = 6
  upper   = false
  special = false
}

module "alpha" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "bravo" {
  source  = "hashicorp/module/random"
  version = "1.0.0"
}

module "charlie" {
  source = "./modules/myrandom"

  length = 8
}

# module "regionA" {
#   source = "./modules/regional-stamp"

#   region         = "westus"
#   name           = "vt-test-a"
#   min_node_count = 4
#   max_node_count = 8
# }

# module "regionB" {
#   source = "./modules/regional-stamp"

#   region         = "eastus"
#   name           = "vt-test-b"
#   min_node_count = 4
#   max_node_count = 8
# }

module "regional_stamps" {
  source = "./modules/regional-stamp"
  count  = length(local.regional_stamps)

  region         = local.regional_stamps[count.index].region
  name           = local.regional_stamps[count.index].name
  min_node_count = local.regional_stamps[count.index].min_node_count
  max_node_count = local.regional_stamps[count.index].max_node_count
}

module "regional_stamps_map" {
  source   = "./modules/regional-stamp"
  for_each = local.regional_stamps_map

  region         = each.value.region
  name           = each.key
  min_node_count = each.value.min_node_count
  max_node_count = each.value.max_node_count
}
