output "network" {
  value = module.vpc.network_name
}

output "subnets" {
  value = values(module.vpc.subnets)[*].name
  description = "The created subnet resources"
}