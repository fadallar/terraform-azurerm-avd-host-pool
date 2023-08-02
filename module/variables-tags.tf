variable "default_tags" {
  description = "Default Base tagging"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Extra tags to add."
  type        = map(string)
  default     = {}
}
