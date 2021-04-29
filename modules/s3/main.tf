resource "aws_s3_bucket" "aws_s3_bucket" {
  count  = var.create_bucket == "true" ? 1 : 0
  bucket = var.bucket_name
  acl    = "private"

  tags = var.bucket_tag
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  count = var.enable_bucket_notification == "true" && var.s3_trigger_lambda == "true" ? 1:0
  bucket = aws_s3_bucket.aws_s3_bucket[0].id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
  }
  # depends_on = [
    
  # ]
}

output "bucket_name" {
  value = aws_s3_bucket.aws_s3_bucket[0].bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.aws_s3_bucket[0].arn
}
# resource "aws_s3_bucket_notification" "bucket_notification" {
#   count  = var.create_s3_event == "true" ? 1 : 0
#   bucket = aws_s3_bucket.aws_s3_bucket.id

#   lambda_function {
#     lambda_function_arn = aws_lambda_function.func.arn
#     events              = ["s3:ObjectCreated:*"]
#   }

#   depends_on = [aws_s3_bucket.aws_s3_bucket]
# }