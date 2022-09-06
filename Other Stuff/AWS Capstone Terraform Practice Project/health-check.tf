# main.tf
resource "aws_route53_health_check" "tf-health-check" {
  fqdn              = var.dns-name
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "3"
  request_interval  = "30"
  regions           = "us-east-1"

  tags = {
    Name        = "${var.dns-name}-tf-health-check"
  }
}

# variables.tf
variable "dns-name" {
  description = "Fully-qualified domain name (FQDN) to create."
  type        = string
}
