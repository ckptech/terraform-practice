output "network" {
  value = module.vpc.network
}


output "subnets" {
  value       = module.vpc.subnets
  description = "The created subnet resources"
}