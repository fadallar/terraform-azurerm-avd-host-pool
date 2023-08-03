## Before using Private endpoint please check the following link
## https://learn.microsoft.com/en-us/azure/virtual-desktop/private-link-setup?tabs=portal%2Cportal-2

resource "azapi_update_resource" "this" {
  type        = "Microsoft.DesktopVirtualization/hostpools@2022-10-14-preview"
  resource_id = azurerm_virtual_desktop_host_pool.this.id

  body = jsonencode({
    properties = {
      publicNetworkAccess : var.public_network_access,
    }
  })

  depends_on = [
    azurerm_virtual_desktop_host_pool.this,
  ]
}

resource "azurerm_private_endpoint" "this" {
  for_each = toset(var.enable_private_endpoint ? ["enabled"] : [])

  name                = format("pe-%s", local.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = merge(var.default_tags, var.extra_tags)
  private_dns_zone_group {
    name                 = format("%s-group", "storage")
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = format("%s-privatelink", "avdhost")
    is_manual_connection           = var.is_manual_connection
    private_connection_resource_id = azurerm_virtual_desktop_host_pool.this.id
    subresource_names              = ["connection"]
  }
}