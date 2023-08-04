output "avd_host_pool_id" {
  description = "Virtual Desktop Host pool resource id"
  value       = azurerm_virtual_desktop_host_pool.this.id
}

output "avd_host_pool_name" {
  description = "Virtual Desktop Host pool name"
  value       = azurerm_virtual_desktop_host_pool.this.name
}

output "avd_host_pool_private_endpoint_id" {
  description = "AVD Host Pool Private endpoint Id"
  value = {
    for k, v in azurerm_private_endpoint.this : k => v.id
  }
}