resource "aws_s3_bucket" "bucket" {
  bucket = "${var.env}-sahil-saykar-infra-bucket"

  tags = {
    Name        = "${var.env}-sahil-saykar-infra-bucket"
    Environment = var.env
  }
}
