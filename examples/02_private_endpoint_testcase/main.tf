# Test case local inputs
locals {
  stack             = "avdhost"
  landing_zone_slug = "sbx"
  location          = "westeurope"

  # extra tags value if needed
  extra_tags = {
    tag1 = "FirstTag",
    tag2 = "SecondTag"
  }

  # Base tagging values
  environment     = "sbx"
  application     = "terra-module"
  cost_center     = "CCT"
  change          = "CHG666"
  owner           = "Fabrice"
  spoc            = "Fabrice"
  tlp_colour      = "WHITE"
  cia_rating      = "C1I1A3"
  technical_owner = "Fabrice"

  ### Networking

  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_private_endpoint       = ["10.0.2.0/24"]


  # AVD Host Pool
  registration_expiration_date = "2023-08-05T23:40:52Z"

  avd_host_friendly_name                   = "my friendly name"
  avd_host_description                     = "my description"
  avd_host_public_access                   = "Disabled"
  avd_host_custom_rdp_properties           = "enablerdsaadauth:i:1;audiocapturemode:i:1"
  avd_host_scheduled_agent_updates_enabled = true
  avd_host_schedule_agent_updates_schedules = [
    {
      "day_of_week" : "Monday"
      "hour_of_day" : 23
    },
    {
      "day_of_week" : "Friday"
      "hour_of_day" : 21

    }
  ]
}

module "regions" {
  source       = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-regions//module?ref=master"
  azure_region = local.location
}

module "base_tagging" {
  source          = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-basetagging//module?ref=master"
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
  source            = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-resourcegroup//module?ref=master"
  stack             = local.stack
  landing_zone_slug = local.landing_zone_slug
  default_tags      = module.base_tagging.base_tags
  location          = module.regions.location
  location_short    = module.regions.location_short
}

module "diag_log_analytics_workspace" {
  source = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-loganalyticsworkspace//module?ref=feature/use-tf-lock-file"

  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location            = module.regions.location
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name
  default_tags        = module.base_tagging.base_tags

}

module "vnet" {
  source = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-vnet//module?ref=develop"

  landing_zone_slug               = local.landing_zone_slug
  stack                           = local.stack
  location                        = module.regions.location
  location_short                  = module.regions.location_short
  resource_group_name             = module.resource_group.resource_group_name
  default_tags                    = module.base_tagging.base_tags
  diag_log_analytics_workspace_id = module.diag_log_analytics_workspace.log_analytics_workspace_id

  virtual_network_address_space           = local.virtual_network_address_space
  virtual_network_flow_timeout_in_minutes = 4


}

module "subnet-private-endpoint" {
  source = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-subnet//module?ref=develop"

  landing_zone_slug   = local.landing_zone_slug
  stack               = local.stack
  location_short      = module.regions.location_short
  resource_group_name = module.resource_group.resource_group_name

  virtual_network_name = module.vnet.virtual_network_name
  address_prefixes     = local.subnet_private_endpoint
  //route_table_id       = module.route_table.route_table_id
  enable_delegation = false

  //network_security_group_id               = 
}

module "private_dns_zone_avd_host_pool" {
  source = "git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git/terraform-azurerm-privatednszone//module?ref=release/1.0.0"

  domain_name         = "privatelink.wvd.microsoft.com"
  resource_group_name = module.resource_group.resource_group_name
  default_tags        = module.base_tagging.base_tags

}

# Please specify source as git::https://ECTL-AZURE@dev.azure.com/ECTL-AZURE/ECTL-Terraform-Modules/_git<<ADD_MODULE_NAME>>//module?ref=master or with specific tag
module "avdhostpool" {
  source                          = "../../module"
  landing_zone_slug               = local.landing_zone_slug
  stack                           = local.stack
  location                        = module.regions.location
  location_short                  = module.regions.location_short
  resource_group_name             = module.resource_group.resource_group_name
  default_tags                    = module.base_tagging.base_tags
  extra_tags                      = local.extra_tags
  diag_log_analytics_workspace_id = module.diag_log_analytics_workspace.log_analytics_workspace_id

  # Module Parameters

  private_dns_zone_id        = module.private_dns_zone_avd_host_pool.id
  private_endpoint_subnet_id = module.subnet-private-endpoint.subnet_id
  public_network_access      = local.avd_host_public_access

  registration_expiration_date = local.registration_expiration_date

  friendly_name                    = local.avd_host_friendly_name
  description                      = local.avd_host_description
  custom_rdp_properties            = local.avd_host_custom_rdp_properties
  scheduled_agent_updates_enabled  = local.avd_host_scheduled_agent_updates_enabled
  schedule_agent_updates_schedules = local.avd_host_schedule_agent_updates_schedules
}