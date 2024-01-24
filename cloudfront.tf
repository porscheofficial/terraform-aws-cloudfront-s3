resource "aws_cloudfront_origin_access_control" "cloudfront_access_control" {
  name                              = "cf-access-control"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_access_control.id
    domain_name              = aws_s3_bucket.origin.bucket_regional_domain_name
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  default_root_object = "index.html"

  dynamic "logging_config" {
    for_each = var.enable_cf_logging ? [1] : []
    content {
      include_cookies = false
      bucket          = "${var.cf_logging_bucket}.s3.amazonaws.com"
      prefix          = var.cf_logging_prefix
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    min_ttl                = 0
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  web_acl_id = var.waf_id != "" ? var.waf_id : null

  custom_error_response {
    error_caching_min_ttl = 3000
    error_code            = 404
    response_code         = 200
    response_page_path    = "/${var.error_page}"
  }

  aliases = [var.domain_name]

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    ssl_support_method             = "sni-only"
  }
}