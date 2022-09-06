variable "primary_example_com" {}
variable "secndry_example_com" {}

resource "aws_route53_zone" "example_com" {
    name = "example.com"
}
  
# example.com
  
resource "aws_route53_record" "example_com_primary" {
    zone_id = "${aws_route53_zone.example_com.zone_id}"
    name    = "${aws_route53_zone.example_com.name}"
    type    = "A"
    ttl     = "60"
    records = ["${var.primary_example_com}"]
  
    failover_routing_policy {
        type = "PRIMARY"
    }
  
    set_identifier  = "example_com_primary"
    health_check_id = "${aws_route53_health_check.example_com_primary.id}"
}
  
resource "aws_route53_record" "example_com_secondary" {
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
  comment = "${var.comment}"
}

resource "aws_route53_record" "primary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "${var.ttl}"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier = "${var.identifier1}"
  records        = ["${var.primaryip}"]
  health_check_id = "${aws_route53_health_check.primary.id}"
}

resource "aws_route53_record" "secondary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "${var.subdomain}"
  type    = "A"
  ttl     = "${var.ttl}"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "${var.identifier2}"
  records        = ["${var.secondaryip}"]
  health_check_id = "${aws_route53_health_check.secondary.id}"
}

