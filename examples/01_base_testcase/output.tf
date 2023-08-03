# TODO: Add all outputs from outputs.tf file inside module folder

output "avdhostpool" {
  description = "avdhostpool outputs"
  value       = module.avdhostpool
  sensitive   = true
}