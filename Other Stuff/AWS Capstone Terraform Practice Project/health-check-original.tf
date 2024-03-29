resource "aws_route53_health_check" "example" {
  fqdn              = "d2ljrvw6dw918e.cloudfront.net"
  port              = 80
  type              = "HTTP"
  resource_path     = ""
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = "tf-test-health-check"
  }
}

resource "aws_route53_health_check" "http" {
  fqdn              = var.dns_name
  port              = 80
  type              = "HTTP"
  resource_path     = var.health_check_path
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval
  regions           = var.health_check_regions
  measure_latency   = true
  count             = var.disable ? 0 : 1

  tags = {
    Name        = "${var.dns_name}-http"
    Environment = var.environment
    Automation  = "Terraform"
  }
}

# variables.tf
variable "environment" {
  description = "Environment tag (e.g. prod)."
  type        = string
}

variable "dns_name" {
  description = "Fully-qualified domain name (FQDN) to create."
  type        = string
}

variable "health_check_regions" {
  description = "AWS Regions for health check"
  type        = list(string)
  default     = ["us-east-1", "us-west-1", "us-west-2"]
}

variable "health_check_path" {
  description = "Resource Path to check"
  type        = string
  default     = ""
}

variable "failure_threshold" {
  description = "Failure Threshold (must be less than or equal to 10)"
  type        = string
  default     = "3"
}

variable "request_interval" {
  description = "Request Interval (must be 10 or 30)"
  type        = string
  default     = "30"
}

variable "disable" {
  description = "Disable health checks"
  type        = bool
  default     = false
}

