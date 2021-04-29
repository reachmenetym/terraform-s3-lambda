resource "aws_iam_policy" "aws_iam_policy" {
  count = var.create_iam_policy == "true" ? 1 : 0
  path        = "/"
  description = "My test policy"
  name = var.policy_name
  policy = var.policy_json
}


resource "aws_iam_role_policy_attachment" "attach_policy" {
  count = var.attach_policy == "true" ? 1:0
  role       = var.iam_role_name
  policy_arn = aws_iam_policy.aws_iam_policy[0].arn
}

output "policy_arn" {
  value = aws_iam_policy.aws_iam_policy[0].arn
}
# resource "aws_iam_policy" "policy" {
#   name        = var.policy_name
#   path        = "/"
#   description = var.policy_description

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "ec2:Describe*",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }


