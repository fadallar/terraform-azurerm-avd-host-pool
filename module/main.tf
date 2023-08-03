# Add Checkov skips here, if required.

resource "azurerm_virtual_desktop_host_pool" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  description                      = var.description
  friendly_name                    = var.friendly_name
  validate_environment             = var.validate_environment
  start_vm_on_connect              = var.start_vm_on_connect
  custom_rdp_properties            = var.custom_rdp_properties
  type                             = var.type
  maximum_sessions_allowed         = var.maximum_sessions_allowed
  load_balancer_type               = var.load_balancer_type
  personal_desktop_assignment_type = var.personal_desktop_assignment_type
  preferred_app_group_type         = var.preferred_app_group_type

  tags = merge(var.default_tags, var.extra_tags)

  scheduled_agent_updates {
    enabled                   = var.scheduled_agent_updates_enabled
    timezone                  = var.scheduled_agent_updates_timezone
    use_session_host_timezone = var.scheduled_agent_updates_use_session_host_time_zone

    dynamic "schedule" {
      for_each = var.schedule_agent_updates_schedules
      content {
        day_of_week = schedule.value.day_of_week
        hour_of_day = schedule.value.hour_of_day
      }
    }
  }
}

resource "azurerm_virtual_desktop_host_pool_registration_info" "this" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.this.id
  expiration_date = var.registration_expiration_date
}


resource "azapi_update_resource" "this" {
  type        = "Microsoft.DesktopVirtualization/hostpools@2022-10-14-preview"
  resource_id = azurerm_virtual_desktop_host_pool.this.id

  body = jsonencode({
    properties = {
      publicNetworkAccess: var.public_network_access,
    }
  })

  depends_on = [
    azurerm_virtual_desktop_host_pool.this,
  ]
}