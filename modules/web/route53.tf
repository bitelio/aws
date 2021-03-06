resource "aws_route53_zone" "primary" {
  name = var.domain
}

resource "aws_route53_record" "A-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = ""
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-A-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.redirect_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.redirect_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "caa" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = ""
  type    = "CAA"
  ttl     = 3600
  records = [
    "0 issue \"amazon.com\"",
    "0 issuewild \"amazon.com\"",
  ]
}

resource "aws_route53_record" "MX-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = [
    "10 mx1.privateemail.com",
    "10 mx2.privateemail.com",
  ]
}

resource "aws_route53_record" "TXT-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 include:spf.privateemail.com ~all",
    "google-site-verification=aiNQ7-uaNqQKW-hUdEO4m5mL0EpBHKaPh2XD-MZZYYU",
  ]
}

resource "aws_route53_record" "mail-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "mail"
  type    = "CNAME"
  ttl     = 3600
  records = ["privateemail.com"]
}

resource "aws_route53_record" "autodiscover-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["privateemail.com"]
}

resource "aws_route53_record" "autoconfig-record" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "autoconfig"
  type    = "CNAME"
  ttl     = 3600
  records = ["privateemail.com"]
}

resource "aws_route53_record" "certificate_validation" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = aws_acm_certificate.certificate.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.certificate.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.certificate.domain_validation_options[0].resource_record_value]
  ttl     = 300
}
