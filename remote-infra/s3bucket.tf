resource "aws_s3_bucket" "new_remote_state_bucket" {
  bucket = "my-unique-state-bucket-masoom-2025"
  tags = {
    Name = "My Remote State Bucket"
  }
}