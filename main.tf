# =============== REMOTE BACKEND RESOURCES ===========================================
resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = "${var.project_name}-state-bucket-101"

  tags = {
    Name        = "${var.project_name}-terraform-state"
    Environment = var.project_name
  }

  lifecycle {
    prevent_destroy = true
  }


}

resource "aws_s3_bucket_versioning" "remote_state_versioning" {
  bucket = aws_s3_bucket.remote_state_bucket.id

  versioning_configuration {
    status = "Enabled"
  }

}

resource "aws_s3_bucket_server_side_encryption_configuration" "dfault_encryption" {
  bucket = aws_s3_bucket.remote_state_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

}

resource "aws_s3_bucket_public_access_block" "name" {
  bucket                  = aws_s3_bucket.remote_state_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}


resource "aws_dynamodb_table" "remote_state_lock_table" {
  name         = "${var.project_name}-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.project_name}-terraform-state-lock"
    Environment = var.project_name
  }

  lifecycle {
    prevent_destroy = true
  }

}
# =============== MAIN CONFIG RESOURCES ===========================================