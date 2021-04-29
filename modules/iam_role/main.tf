resource "aws_iam_role" "aws_role" {
  count = var.create_lambda_role == "true" ? 1 : 0
  name = var.role_name
  assume_role_policy = var.role_policy_json
}


output "iam_rolename" {
  value = aws_iam_role.aws_role[0].name
}

output "role_arn" {
  value = aws_iam_role.aws_role[0].arn
}

output "role_id" {
  value = aws_iam_role.aws_role[0].id
}