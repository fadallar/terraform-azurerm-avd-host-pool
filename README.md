<!-- BEGIN_AUTOMATED_TF_DOCS_BLOCK -->
# Azure Virtual Desktop Host Pool
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE)

This module helps configuring an Azure Virtual Desktop Host pool.  

It also automate the creation of the diagnostics settings and AVD Host pool private endpoint is private connectivity is selected.  

> Note:  The module currently use the AZAPI provider to configure the publicNetworkAccess attribute as this was not supported by the azurerm provider. When supported the code will be updated.  

## Examples

[01\_base\_testcase](./examples/01\_base\_testcase/README.md)  
[02\_private\_endpoint\_testcase](./examples/02\_private\_endpoint\_testcase/README.md)
## Usage
Basic usage of this module is as follows:
```hcl
module "example" {
   source  = "<module-path>"

   # Required variables
   description =
   diag_log_analytics_workspace_id =
   friendly_name =
   landing_zone_slug =
   location =
   location_short =
   resource_group_name =
   stack =

   # Optional variables
   custom_name = ""
   custom_rdp_properties = null
   default_tags = {}
   diag_default_setting_name = "default"
   diag_log_categories = [
  "Checkpoint",
  "Error",
  "Management",
  "Connection",
  "HostRegistration",
  "AgentHealthStatus",
  "NetworkData",
  "SessionHostManagement",
  "ConnectionGraphicsData",
  "AutoscaleEvaluationPooled"
]
   diag_metric_categories = []
   diag_retention_days = 30
   diag_storage_account_id = null
   enable_private_endpoint = true
   extra_tags = {}
   is_manual_connection = false
   load_balancer_type = "BreadthFirst"
   log_analytics_destination_type = "Dedicated"
   maximum_sessions_allowed = 999999
   personal_desktop_assignment_type = null
   preferred_app_group_type = "Desktop"
   private_dns_zone_id = null
   private_endpoint_subnet_id = null
   public_network_access = "Enabled"
   schedule_agent_updates_schedules = []
   scheduled_agent_updates_enabled = false
   scheduled_agent_updates_timezone = "UTC"
   scheduled_agent_updates_use_session_host_time_zone = false
   start_vm_on_connect = false
   type = "Pooled"
   validate_environment = false
   workload_info = ""
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | >=1.8.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.61.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.3 |
## Resources

| Name | Type |
|------|------|
| [azapi_update_resource.this](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/update_resource) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_virtual_desktop_host_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_desktop_host_pool) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | A description for the Virtual Desktop Host Pool. | `string` | n/a | yes |
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_friendly_name"></a> [friendly\_name](#input\_friendly\_name) | A friendly name for the Virtual Desktop Host Pool. | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will be used to generate the resource name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name. | `string` | n/a | yes |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generated name if set | `string` | `""` | no |
| <a name="input_custom_rdp_properties"></a> [custom\_rdp\_properties](#input\_custom\_rdp\_properties) | A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be found at https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/rdp-files | `string` | `null` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "Checkpoint",<br>  "Error",<br>  "Management",<br>  "Connection",<br>  "HostRegistration",<br>  "AgentHealthStatus",<br>  "NetworkData",<br>  "SessionHostManagement",<br>  "ConnectionGraphicsData",<br>  "AutoscaleEvaluationPooled"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | `[]` | no |
| <a name="input_diag_retention_days"></a> [diag\_retention\_days](#input\_diag\_retention\_days) | The number of days for which the Retention Policy should apply | `number` | `30` | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Whether the AVD host pool is using a private endpoint. | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_is_manual_connection"></a> [is\_manual\_connection](#input\_is\_manual\_connection) | Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created. | `bool` | `false` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | BreadthFirst load balancing distributes new user sessions across all available session hosts in the host pool. Possible values are BreadthFirst, DepthFirst and Persistent. DepthFirst load balancing distributes new user sessions to an available session host with the highest number of connections but has not reached its maximum session limit threshold. Persistent should be used if the host pool type is Personal | `string` | `"BreadthFirst"` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_maximum_sessions_allowed"></a> [maximum\_sessions\_allowed](#input\_maximum\_sessions\_allowed) | A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled. | `number` | `999999` | no |
| <a name="input_personal_desktop_assignment_type"></a> [personal\_desktop\_assignment\_type](#input\_personal\_desktop\_assignment\_type) | Possible values are Automatic and Direct. Automatic assignment – The service will select an available host and assign it to an user. Direct Assignment – Admin selects a specific host to assign to an user. Changing this forces a new resource to be created. personal\_desktop\_assignment\_type is required if the type of your Virtual Desktop Host Pool is Personal | `string` | `null` | no |
| <a name="input_preferred_app_group_type"></a> [preferred\_app\_group\_type](#input\_preferred\_app\_group\_type) | Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications. Changing this forces a new resource to be created. | `string` | `"Desktop"` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Id of the private DNS Zone to be used by AVD Host private endpoint. | `string` | `null` | no |
| <a name="input_private_endpoint_subnet_id"></a> [private\_endpoint\_subnet\_id](#input\_private\_endpoint\_subnet\_id) | Id for the subnet used by AVD Host private endpoint | `string` | `null` | no |
| <a name="input_public_network_access"></a> [public\_network\_access](#input\_public\_network\_access) | Define the public network access behaviour. Possible values are Enabled, EnabledForClientsOnly ,Disabled | `string` | `"Enabled"` | no |
| <a name="input_schedule_agent_updates_schedules"></a> [schedule\_agent\_updates\_schedules](#input\_schedule\_agent\_updates\_schedules) | schedule - A maximum of two blocks can be added.<br>      day\_of\_week The day of the week on which agent updates should be performed. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, and Sunday<br>      hour\_of\_day The hour of day the update window should start. The update is a 2 hour period following the hour provided. The value should be provided as a number between 0 and 23, with 0 being midnight and 23 being 11pm. A leading zero should not be used. | <pre>list(object({<br>    day_of_week = string<br>    hour_of_day = number<br>  }))</pre> | `[]` | no |
| <a name="input_scheduled_agent_updates_enabled"></a> [scheduled\_agent\_updates\_enabled](#input\_scheduled\_agent\_updates\_enabled) | Enables or disables scheduled updates of the AVD agent components (RDAgent, Geneva Monitoring agent, and side-by-side stack) on session hosts. <br>  If enabled is set to true then at least one and a maximum of two schedule blocks must be provided. | `bool` | `false` | no |
| <a name="input_scheduled_agent_updates_timezone"></a> [scheduled\_agent\_updates\_timezone](#input\_scheduled\_agent\_updates\_timezone) | Specifies the time zone in which the agent update schedule will apply.<br>  The possible values are defined here: https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/<br>  If use\_session\_host\_timezone is enabled then it will override this setting. | `string` | `"UTC"` | no |
| <a name="input_scheduled_agent_updates_use_session_host_time_zone"></a> [scheduled\_agent\_updates\_use\_session\_host\_time\_zone](#input\_scheduled\_agent\_updates\_use\_session\_host\_time\_zone) | Specifies whether scheduled agent updates should be applied based on the timezone of the affected session host. If configured then this setting overrides timezone. | `bool` | `false` | no |
| <a name="input_start_vm_on_connect"></a> [start\_vm\_on\_connect](#input\_start\_vm\_on\_connect) | Enables or disables the Start VM on Connection Feature | `bool` | `false` | no |
| <a name="input_type"></a> [type](#input\_type) | The type of the Virtual Desktop Host Pool. Valid options are Personal or Pooled. Changing the type forces a new resource to be created. | `string` | `"Pooled"` | no |
| <a name="input_validate_environment"></a> [validate\_environment](#input\_validate\_environment) | Allows you to test service changes before they are deployed to production | `bool` | `false` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_avd_host_pool_id"></a> [avd\_host\_pool\_id](#output\_avd\_host\_pool\_id) | Virtual Desktop Host pool resource id |
| <a name="output_avd_host_pool_name"></a> [avd\_host\_pool\_name](#output\_avd\_host\_pool\_name) | Virtual Desktop Host pool name |
| <a name="output_avd_host_pool_private_endpoint_id"></a> [avd\_host\_pool\_private\_endpoint\_id](#output\_avd\_host\_pool\_private\_endpoint\_id) | AVD Host Pool Private endpoint Id |
## Contact

Atos

to regenerate this `README.md` file run in pwsh, in current directory:

`docker run --rm -v "$($pwd.path):/data" cytopia/terraform-docs terraform-docs-012 -c tfdocs-config.yml ./module`

`docker run --rm --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`

`docker stop pre; docker rm pre; docker run --name pre -v "$($pwd.path):/lint" -w /lint ghcr.io/antonbabenko/pre-commit-terraform run -a`
<!-- END_AUTOMATED_TF_DOCS_BLOCK -->