locals {
  accounts = {for v in var.accounts: "${lookup(v, "type")}-${lookup(v, "id")}" => v}
}