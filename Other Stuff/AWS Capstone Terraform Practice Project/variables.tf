# variables.tf 
# for terraform-healthcheck-and-primary-&-secondary-failover-records-Route53
variable "dns-name" {
  description = "Fully-qualified domain name (FQDN) to create."
  type        = string
}

variable "domain_name" {
description = "Domain name registered for Application"
}

variable "subdomain" {
description = "Sub Domain name to access Application"
}