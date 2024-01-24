variable "domain_name" {
  type        = string
  description = "Domain name (alias) for CloudFront distribution"

  validation {
    condition     = can(regex("^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]", var.domain_name))
    error_message = "Value must be a valid domain name"
  }
}
variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "route53_zone_name" {
  type        = string
  description = "Name of the Route53 hosted zone (e.g., example.com)"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_200"
  description = "Price class for CloudFront distribution"

  validation {
    condition     = can(regex("PriceClass_All|PriceClass_200|PriceClass_100", var.price_class))
    error_message = "Value must be PriceClass_All, PriceClass_200, PriceClass_100"
  }
}

variable "default_ttl" {
  type        = number
  default     = 86400
  description = "Default TTL for CloudFront distribution"
}

variable "max_ttl" {
  type        = number
  default     = 31536000
  description = "Maximum TTL for CloudFront distribution"
}

variable "error_page" {
  type        = string
  default     = "error.html"
  description = "Name of the default error page"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g., dev, prod)"
}

variable "enable_s3_logging" {
  type        = bool
  default     = false
  description = "Enable S3 logging"
}

variable "s3_logging_bucket" {
  type        = string
  default     = "my-logging-bucket"
  description = "Name of the bucket for S3 logs"
}

variable "s3_logging_prefix" {
  type        = string
  default     = "s3-logs"
  description = "Prefix for S3 logs"
}

variable "enable_cf_logging" {
  type        = bool
  default     = false
  description = "Enable CloudFront logging"
}

variable "cf_logging_bucket" {
  type        = string
  default     = "my-logging-bucket"
  description = "Name of the bucket for CloudFront logs"
}

variable "cf_logging_prefix" {
  type        = string
  default     = "cf-logs"
  description = "Prefix for CloudFront logs"
}

variable "waf_id" {
  type        = string
  default     = ""
  description = "ID of the Web Application Firewall to associate with the CloudFront distribution"
}
