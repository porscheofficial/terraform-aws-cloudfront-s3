# terraform-aws-cloudfront-s3

Terraform module for creating a CloudFront distribution with an S3 origin.
S3 bucket is encrypted with a KMS key and access is restricted to CloudFront Origin Access Control.
Certificate for the domain is issued by ACM and validated via DNS.

[![Terraform Security Check](https://github.com/porscheofficial/terraform-aws-cloudfront-s3/actions/workflows/main.yml/badge.svg)](https://github.com/porscheofficial/terraform-aws-cloudfront-s3/actions/workflows/main.yml)

## Usage

### Module call for terraform-aws-cloudfront-s3

* Call the module as follows

```hcl
module "cloudfront-s3" {
    source            = "github.com/porscheofficial/terraform-aws-cloudfront-s3"
    bucket_name       = "my-project-demo-cf"
    domain_name       = "demo.example.com"
    route53_zone_name = "example.com"
    enable_s3_logging = true
    s3_logging_bucket = "s3-logging-bucket"
    enable_cf_logging = true
    cf_logging_bucket = "cf-logging-bucket"
}
```

### To perform security scan:
Please install [tfsec](https://github.com/aquasecurity/tfsec)

```bash
tfsec --format=default
```
NOTE: Scans for CloudFront and S3 logging are excluded as these functionalities are configurable.

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | ~> 1.6.5 |

## Providers

| Name                                                                | Version   |
|---------------------------------------------------------------------|-----------|
| [aws](https://registry.terraform.io/providers/hashicorp/aws/latest) | ~> 5.19.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert_validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_cloudfront_distribution.cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.cloudfront_access_control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_kms_alias.cf_s3_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.cf_s3_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.cf_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_route53_record.dns_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.dvo_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.origin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_logging.logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_ownership_controls.ownership_control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.block_public_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.encryption](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket | `string` | n/a | yes |
| <a name="input_cf_logging_bucket"></a> [cf\_logging\_bucket](#input\_cf\_logging\_bucket) | Name of the bucket for CloudFront logs | `string` | `"my-logging-bucket"` | no |
| <a name="input_cf_logging_prefix"></a> [cf\_logging\_prefix](#input\_cf\_logging\_prefix) | Prefix for CloudFront logs | `string` | `"cf-logs"` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default TTL for CloudFront distribution | `number` | `86400` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name (alias) for CloudFront distribution | `string` | n/a | yes |
| <a name="input_enable_cf_logging"></a> [enable\_cf\_logging](#input\_enable\_cf\_logging) | Enable CloudFront logging | `bool` | `false` | no |
| <a name="input_enable_s3_logging"></a> [enable\_s3\_logging](#input\_enable\_s3\_logging) | Enable S3 logging | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g., dev, prod) | `string` | `"dev"` | no |
| <a name="input_error_page"></a> [error\_page](#input\_error\_page) | Name of the default error page | `string` | `"error.html"` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum TTL for CloudFront distribution | `number` | `31536000` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | Price class for CloudFront distribution | `string` | `"PriceClass_200"` | no |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Name of the Route53 hosted zone (e.g., example.com) | `string` | n/a | yes |
| <a name="input_s3_logging_bucket"></a> [s3\_logging\_bucket](#input\_s3\_logging\_bucket) | Name of the bucket for S3 logs | `string` | `"my-logging-bucket"` | no |
| <a name="input_s3_logging_prefix"></a> [s3\_logging\_prefix](#input\_s3\_logging\_prefix) | Prefix for S3 logs | `string` | `"s3-logs"` | no |
| <a name="input_waf_id"></a> [waf\_id](#input\_waf\_id) | ID of the Web Application Firewall to associate with the CloudFront distribution | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | n/a |
| <a name="output_cdn_url"></a> [cdn\_url](#output\_cdn\_url) | n/a |
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | n/a |
| <a name="output_cname_url"></a> [cname\_url](#output\_cname\_url) | n/a |