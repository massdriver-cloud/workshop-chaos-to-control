resource "massdriver_artifact" "table" {
  field = "table"
  name  = "DynamoDb table: ${local.name}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          arn = aws_dynamodb_table.main.arn
        }
        security = {
          iam = {
            read = {
              policy_arn = aws_iam_policy.read.arn
            }
            write = {
              policy_arn = aws_iam_policy.write.arn
            }
            read_write = {
              policy_arn = aws_iam_policy.read_and_write.arn
            }
          }
        }
      }
      specs = {
        aws = {
          region = var.region
        }
      }
    }
  )
}

resource "massdriver_artifact" "stream" {
  count = var.stream.enabled ? 1 : 0
  field = "stream"
  name  = "DynamoDb stream: ${local.name}"
  artifact = jsonencode(
    {
      data = {
        infrastructure = {
          arn = aws_dynamodb_table.main.stream_arn
        }
        security = {
          iam = {
            read = {
              policy_arn = aws_iam_policy.read_stream[count.index].arn
            }
          }
        }
      }
      specs = {
        aws = {
          region = var.region
        }
      }
    }
  )
}
