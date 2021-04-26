output "roles" {
  value = [for r in aws_iam_role.account-roles: {name: r.name, arn: r.arn}]
}