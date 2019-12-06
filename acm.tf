resource "aws_acm_certificate" "certificate" {
  provider                  = aws.us-east-1
  domain_name               = "*.bitelio.com"
  subject_alternative_names = ["bitelio.com"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "certificate" {
  provider                = aws.us-east-1
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.certificate_validation.fqdn]
}
