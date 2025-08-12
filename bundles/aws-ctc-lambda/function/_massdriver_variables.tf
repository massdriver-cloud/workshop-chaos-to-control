// Auto-generated variable declarations from massdriver.yaml
variable "budget" {
  type = object({
    email_addresses = optional(list(string))
    limit_amount    = string
  })
  default = null
}
// Auto-generated variable declarations from massdriver.yaml
variable "dynamodb" {
  type = object({
    data = object({
      infrastructure = object({
        arn = string
      })
      security = optional(object({
        iam = optional(map(object({
          policy_arn = string
        })))
        identity = optional(object({
          role_arn = optional(string)
        }))
        network = optional(map(object({
          arn      = string
          port     = number
          protocol = string
        })))
      }))
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
  default = null
}


variable "api_gateway" {
  type = object({
    data = object({
      infrastructure = object({
        arn              = string
        root_resource_id = string
        stage_arn        = string
      })
    })
    specs = object({
      aws = optional(object({
        region = optional(string)
      }))
    })
  })
  default = null
}
variable "aws_authentication" {
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
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "observability" {
  type = object({
    retention_days = number
    x-ray = optional(object({
      enabled = optional(bool)
    }))
  })
  default = null
}
variable "runtime" {
  type = object({
    execution_timeout = number
    image = object({
      tag = string
      uri = string
    })
    memory_size = number
  })
  default = null
}
// Auto-generated variable declarations from massdriver.yaml
variable "api" {
  type = object({
    http_methods = list(string)
    path         = string
  })
  default = null
}
// Auto-generated variable declarations from massdriver.yaml
variable "policy" {
  type    = string
  default = null
}
