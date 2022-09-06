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

resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_route53_record" "primary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "A"
#  ttl     = "60"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "primary"
  health_check_id = aws_route53_health_check.primary.id

  alias {
    zone_id                = aws_route53_zone.main.zone_id
    name                   = var.domain_name
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "secondary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.subdomain
  type    = "A"
#  ttl     = "60"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"
  health_check_id = aws_route53_health_check.secondary.id

  alias {
    zone_id                = aws_s3_bucket.sitebucket.hosted_zone_id
    name                   = aws_s3_bucket.sitebucket.domain_name
    evaluate_target_health = false
  }
}

# sources:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check
# https://github.com/trussworks/terraform-aws-route53-health-check
# https://wragg.io/drafts/using-terraform-to-create-failover-records-in-route53/
# https://github.com/shrashthi-agarwal/Route53
# https://groups.google.com/g/terraform-tool/c/LfdV0doUNmI?pli=1
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
