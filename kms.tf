resource "aws_kms_key" "cf_s3_kms" {
  description             = "KMS key for S3 bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "cf_s3_kms_alias" {
  name          = "alias/cloudfront-s3"
  target_key_id = aws_kms_key.cf_s3_kms.key_id
}

resource "aws_kms_key_policy" "cf_access" {
  key_id = aws_kms_key.cf_s3_kms.id

  policy = jsonencode({
    Id = "CFAccess"
    Statement = [
      {
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey*"
        ],
        Effect = "Allow"
        "Principal" : {
          "Service" : ["cloudfront.amazonaws.com"]
        },
        Resource = "*"
        Sid      = "Enable Cloudfront Permissions"
      },
      {
        "Action" : [
          "kms:*"
        ],
        Effect = "Allow"
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Resource = "*"
        Sid      = "Enable Admin Permissions"
      }
    ]
    Version = "2012-10-17"
  })
}
