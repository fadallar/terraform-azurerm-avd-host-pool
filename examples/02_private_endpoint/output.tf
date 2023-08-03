# TODO: Add all outputs from outputs.tf file inside module folder

output "avdhostpool" {
  description = "Description"
  value       = module.avdhostpool
  sensitive   = true
}
