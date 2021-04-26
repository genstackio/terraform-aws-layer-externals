resource "aws_iam_role" "account-roles" {
  for_each = var.accounts
  name_prefix = "externals-${each.value.type}-"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "AWS" : "arn:aws:iam::${each.value.id}:root" }
        Condition = (each.value.external_id != null) ? {
          StringEquals = {
            "sts:ExternalId" = each.value.external_id
          }
        } : null
      }]
  })
}

resource "aws_iam_role_policy_attachment" "account-roles" {
  for_each = var.accounts
  role       = aws_iam_role.account-roles[each.key].name
  policy_arn = each.value.policy
}