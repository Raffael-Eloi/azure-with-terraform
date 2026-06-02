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
  environment_prefix = "raffablog"
}
