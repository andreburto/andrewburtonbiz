resource "aws_s3_bucket" "cftest_logs" {
  bucket = local.cf_logs_bucket
}

resource "aws_s3_bucket_ownership_controls" "cftest_logs" {
  bucket = aws_s3_bucket.cftest_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "cftest_logs" {
  bucket = aws_s3_bucket.cftest_logs.id

  rule {
    id = "rule-1"

    expiration {
      days = 7
    }

    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "cftest_logs" {
  bucket = aws_s3_bucket.cftest_logs.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}