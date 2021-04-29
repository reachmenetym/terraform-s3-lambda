resource "aws_lambda_function" "aws_lambda" {
    count = var.create_lambda == "true" ? 1:0
  filename      = var.lambda_zip_file
  function_name = var.lambda_function_name
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"

  
  source_code_hash = filebase64sha256(var.lambda_zip_file)

  runtime = var.lambda_runtime_engine

#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
}

resource "aws_lambda_permission" "allow_s3_bucket" {
    count = var.add_lambda_trigger == "true" && var.trigger_type == "s3" ? 1 : 0
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aws_lambda[0].arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket_arn
}

output "lambda_arn" {
  value = aws_lambda_function.aws_lambda[0].arn
}