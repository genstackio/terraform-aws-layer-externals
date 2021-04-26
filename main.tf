resource "aws_iam_role" "account-roles" {
  for_each           = local.accounts
  name_prefix        = "externals-${lookup(each.value, "type")}-"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { "AWS" : "arn:aws:iam::${lookup(each.value, "id")}:root" }
        Condition = (lookup(each.value, "external_id", null) != null) ? {
          StringEquals = {
            "sts:ExternalId" = lookup(each.value, "external_id")
          }
        } : null
      }]
  })
}

resource "aws_iam_role_policy_attachment" "account-roles" {
  for_each   = local.accounts
  role       = aws_iam_role.account-roles[each.key].name
  policy_arn = lookup(each.value, "policy")
}