variable "accounts" {
  type = list(object({
    type        = string
    id          = string
    external_id = string
    policy      = string
  }))
  default = []
}