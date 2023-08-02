variable "is_manual_connection" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "Whether the AVD host pool is using a private endpoint."
  type        = bool
  default     = true
}

variable "private_dns_zone_id" {
  description = "Id of the private DNS Zone to be used by AVD Host private endpoint."
  type        = string
  default     = null
}

variable "private_endpoint_subnet_id" {
  description = "Id for the subnet used by AVD Host private endpoint"
  type        = string
  default     = null
}


