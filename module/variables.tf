
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "friendly_name" {
  type        = string
  description = "A friendly name for the Virtual Desktop Host Pool."
  ### TO-DO add Validation Block
}

variable "validate_environment" {
  type        = bool
  description = "Allows you to test service changes before they are deployed to production"
  default     = false
}

variable "start_vm_on_connect" {
  type        = bool
  description = "Enables or disables the Start VM on Connection Feature"
  default     = false
}

variable "description" {
  type        = string
  description = "A description for the Virtual Desktop Host Pool."
  ### TO-DO add Validation Block
}

variable "type" {
  type        = string
  description = "The type of the Virtual Desktop Host Pool. Valid options are Personal or Pooled. Changing the type forces a new resource to be created."
  validation {
    condition     = contains(["Personal", "Pooled"], var.type)
    error_message = "Invalid variable: type = ${var.type}. Select valid option from list: ${join(",", ["Personal", "Pooled"])}."
  }
  default = "Pooled"
}

variable "maximum_sessions_allowed" {
  type        = number
  description = "A valid integer value from 0 to 999999 for the maximum number of users that have concurrent sessions on a session host. Should only be set if the type of your Virtual Desktop Host Pool is Pooled."
  default     = 999999
  validation {
    condition     = (var.maximum_sessions_allowed >= 0 && var.maximum_sessions_allowed <= 999999)
    error_message = "Invalid variable: maximum_sessions_allowed. The variable should be Scomprised between 0 and 999999."
  }
}

variable "load_balancer_type" {
  type        = string
  description = "BreadthFirst load balancing distributes new user sessions across all available session hosts in the host pool. Possible values are BreadthFirst, DepthFirst and Persistent. DepthFirst load balancing distributes new user sessions to an available session host with the highest number of connections but has not reached its maximum session limit threshold. Persistent should be used if the host pool type is Personal"
  validation {
    condition     = contains(["BreadthFirst", "DepthFirst", "Persistent"], var.load_balancer_type)
    error_message = "Invalid variable: load_balancer_type = ${var.load_balancer_type}. Select valid option from list: ${join(",", ["BreadthFirst", "DepthFirst", "Persistent"])}."
  }
  default = "BreadthFirst"
}

variable "personal_desktop_assignment_type" {
  type        = string
  description = "Possible values are Automatic and Direct. Automatic assignment – The service will select an available host and assign it to an user. Direct Assignment – Admin selects a specific host to assign to an user. Changing this forces a new resource to be created. personal_desktop_assignment_type is required if the type of your Virtual Desktop Host Pool is Personal"
  default     = null
  validation {
    condition = (
      var.personal_desktop_assignment_type == null ? true : (
        contains(["Automatic", "Direct"], var.personal_desktop_assignment_type)
      )
    )
    error_message = "Invalid variable: personal_desktop_assignment_type. Valid options are null or : ${join(",", ["Automatic", "Direct"])}."
  }
}

variable "preferred_app_group_type" {
  type        = string
  description = "Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications. Changing this forces a new resource to be created."
  default     = "Desktop"
  validation {
    condition     = contains(["None", "Desktop", "RailApplications"], var.preferred_app_group_type)
    error_message = "Invalid variable: preferred_app_group_type = ${var.preferred_app_group_type}. Select valid option from list: ${join(",", ["None", "Desktop", "RailApplications"])}."
  }
}

variable "custom_rdp_properties" {
  type        = string
  description = "A valid custom RDP properties string for the Virtual Desktop Host Pool, available properties can be found at https://learn.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/rdp-files"
  default     = null
}


variable "scheduled_agent_updates_enabled" {
  type        = bool
  default     = false
  description = <<DESC
  Enables or disables scheduled updates of the AVD agent components (RDAgent, Geneva Monitoring agent, and side-by-side stack) on session hosts. 
  If enabled is set to true then at least one and a maximum of two schedule blocks must be provided.
  DESC
}

variable "scheduled_agent_updates_timezone" {
  type        = string
  description = <<DESC
  Specifies the time zone in which the agent update schedule will apply.
  The possible values are defined here: https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
  If use_session_host_timezone is enabled then it will override this setting.
  DESC
  default     = "UTC"
}

variable "scheduled_agent_updates_use_session_host_time_zone" {
  type        = bool
  default     = false
  description = "Specifies whether scheduled agent updates should be applied based on the timezone of the affected session host. If configured then this setting overrides timezone."
}

variable "schedule_agent_updates_schedules" {
  default     = []
  description = <<DESC
   schedule - A maximum of two blocks can be added.
      day_of_week The day of the week on which agent updates should be performed. Possible values are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, and Sunday
      hour_of_day The hour of day the update window should start. The update is a 2 hour period following the hour provided. The value should be provided as a number between 0 and 23, with 0 being midnight and 23 being 11pm. A leading zero should not be used.
  DESC
  type = list(object({
    day_of_week = string
    hour_of_day = number
  }))
}