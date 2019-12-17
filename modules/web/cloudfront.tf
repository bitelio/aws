resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true
  aliases             = [var.domain]
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  origin {
    domain_name = aws_s3_bucket.web-bucket.bucket_regional_domain_name
    origin_id   = "S3-${var.domain}"
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3-${var.domain}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "viewer-response"
      lambda_arn   = aws_lambda_function.http_headers.qualified_arn
      include_body = false
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.1_2016"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = 404
    response_code      = 404
    response_page_path = "/404.html"
  }
}
