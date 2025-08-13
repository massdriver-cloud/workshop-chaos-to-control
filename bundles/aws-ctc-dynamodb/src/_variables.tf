variable "authentication" {
  type = object({
    data = object({
      arn         = string
      external_id = optional(string)
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
}
variable "capacity" {
  type = object({
    billing_mode   = optional(string)
    read_capacity  = optional(number)
    write_capacity = optional(number)
  })
}
variable "global_secondary_indexes" {
  type = list(object({
    attributes = optional(object({
      type               = optional(string)
      partition_key      = optional(string)
      partition_key_type = optional(string)
      sort_key           = optional(string)
      sort_key_type      = optional(string)
    }))
    name            = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
}
variable "pitr" {
  type = object({
    enabled = bool
  })
}
variable "primary_index" {
  type = object({
    type               = optional(string)
    partition_key      = optional(string)
    partition_key_type = optional(string)
    sort_key           = optional(string)
    sort_key_type      = optional(string)
  })
}
variable "region" {
  type = string
}
variable "stream" {
  type = object({
    enabled   = bool
    view_type = optional(string)
  })
}
variable "ttl" {
  type = object({
    enabled = bool
  })
}
