# TODO: Please modify main.ft file. 
# All inputs for modules must be defined in locals or referenced from related module outputs. 
# Try to avoid to use shared resources and add modules which are mandatory for test.

# Please specify local values
locals {
  custom_name         = ""
  stack               = ""
  landing_zone_slug   = ""
  location            = ""
  resource_group_name = ""

  # specify extra tags value if needed
  extra_tags = {
    tag1 = "",
    a    = ""
  }

  # specify shared resources
  diag_log_analytics_workspace_id = ""

  # specify base tagging values
  environment     = ""
  application     = ""
  cost_center     = ""
  change          = ""
  owner           = ""
  spoc            = ""
  tlp_colour      = ""
  cia_rating      = ""
  technical_owner = ""
}

module "regions" {
  source       = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-regions//module?ref=master"
  azure_region = local.location
}

module "base_tagging" {
  source          = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-basetagging//module?ref=master"
  environment     = local.environment
  application     = local.application
  cost_center     = local.cost_center
  change          = local.change
  owner           = local.owner
  spoc            = local.spoc
  tlp_colour      = local.tlp_colour
  cia_rating      = local.cia_rating
  technical_owner = local.technical_owner
}

module "resource_group" {
  source            = "git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/terraform-azurerm-resourcegroup//module?ref=master"
  stack             = local.stack
  custom_name       = local.resource_group_name
  landing_zone_slug = local.landing_zone_slug
  default_tags      = module.base_tagging.base_tags
  location          = module.regions.location
  location_short    = module.regions.location_short
}

# Please specify source as git::ssh://git@ssh.dev.azure.com/v3/ECTL-AZURE/ECTL-Terraform-Modules/<<ADD_MODULE_NAME>>//module?ref=master or with specific tag
module "" {
  source              = "../../module"
  custom_name         = local.custom_name
  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name
  # Default Tags
  default_tags = module.base_tagging.base_tags
  # Extra Tags
  extra_tags = local.extra_tags
  # TODO: Add module parameters

}
