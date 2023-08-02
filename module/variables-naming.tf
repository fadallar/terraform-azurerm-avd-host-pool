# Generic naming variables

variable "custom_name" {
  description = "Custom resource name, it will overide the generated name if set"
  type        = string
  default     = ""
}

variable "workload_info" {
  description = "Workload additional info to be used in the resource name"
  type        = string
  default     = ""
}

variable "landing_zone_slug" {
  description = "Landing zone acronym,it will be used to generate the resource name"
  type        = string
}
