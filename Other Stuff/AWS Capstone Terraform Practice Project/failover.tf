variable "primary_example_com" {}
variable "secndry_example_com" {}

resource "aws_route53_zone" "hosted-zone-name" {
    name = "capstone.mafu.link"
}

resource "aws_route53_record" "hosted-zone-primary" {
    zone_id = "${aws_route53_zone.hosted-zone-name.zone_id}"
    name    = "${aws_route53_zone.hosted-zone-name.name}"
    type    = "A"
    ttl     = "60"
    records = ["${var.primary_example_com}"]
  
    failover_routing_policy {
        type = "PRIMARY"
    }
  
    set_identifier  = "example_com_primary"
    health_check_id = "${aws_route53_health_check.example_com_primary.id}"
}
  
resource "aws_route53_record" "hosted-zone-secondary" {
    zone_id = "${aws_route53_zone.example_com.zone_id}"
    name    = "${aws_route53_zone.example_com.name}"
    type    = "A"
    ttl     = "60"
    records = ["${var.secndry_example_com}"]
  
    failover_routing_policy {
        type = "SECONDARY"
    }
  
    set_identifier  = "example_com_secondary"
    health_check_id = "${aws_route53_health_check.example_com_secondary.id}"
}
  
#################

resource "aws_route53_zone" "main" {
  name = "${var.domain_name}"
}

resource "aws_route53_record" "primary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "60"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "primary"
  records        = ["${var.primaryip}"]
  health_check_id = "${aws_route53_health_check.primary.id}"
}

resource "aws_route53_record" "secondary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "60"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"
  records        = ["${var.secondaryip}"]
  health_check_id = "${aws_route53_health_check.secondary.id}"
}

# variables.tf
variable "domain_name" {
description = "Domain name registered for Application"
}

variable "subdomain" {
description = "Sub Domain name to access Application"
}

variable "primaryip" {
}

variable "secondaryip" {
}