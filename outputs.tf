output "cdn_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "cname_url" {
  value = tolist(aws_cloudfront_distribution.cdn.aliases)
}

output "bucket_arn" {
  value = aws_s3_bucket.origin.arn
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.cdn.arn
}