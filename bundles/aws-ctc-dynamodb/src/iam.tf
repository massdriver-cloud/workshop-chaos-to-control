locals {
  write_actions = [
    "dynamodb:BatchWriteItem",
    "dynamodb:DeleteItem",
    "dynamodb:PartiQLDelete",
    "dynamodb:PartiQLInsert",
    "dynamodb:PartiQLUpdate",
    "dynamodb:PutItem",
    "dynamodb:UpdateItem",
  ]
  read_actions = [
    "dynamodb:BatchGetItem",
    "dynamodb:ConditionCheckItem",
    "dynamodb:GetItem",
    "dynamodb:PartiQLSelect",
    "dynamodb:Query",
    "dynamodb:Scan",
  ]

  read_statement = [{
    Action = local.read_actions
    Effect = "Allow"
    Resource = [
      aws_dynamodb_table.main.arn,
      "${aws_dynamodb_table.main.arn}/index/*"
    ]
  }]

  write_statement = [{
    Action   = local.write_actions
    Effect   = "Allow"
    Resource = aws_dynamodb_table.main.arn
  }]

  read_and_write_statement = [{
    Action = concat(local.read_actions, local.write_actions)
    Effect = "Allow"
    Resource = [
      aws_dynamodb_table.main.arn,
      "${aws_dynamodb_table.main.arn}/index/*"
    ]
  }]

  read_stream_statement = [{
    Action = [
      "dynamodb:DescribeStream",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListStreams"
    ]
    Effect   = "Allow"
    Resource = aws_dynamodb_table.main.stream_arn
  }]
}

resource "aws_iam_policy" "read" {
  name        = "${local.name}-read"
  description = "AWS Dynamodb read policy: ${local.name}"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.read_statement
  })
}

resource "aws_iam_policy" "write" {
  name        = "${local.name}-write"
  description = "AWS Dynamodb write policy: ${local.name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.write_statement
  })
}

resource "aws_iam_policy" "read_stream" {
  count       = var.stream.enabled ? 1 : 0
  name        = "${local.name}-read-stream"
  description = "AWS Dynamodb read policy for attached stream: ${local.name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.read_stream_statement
  })
}

resource "aws_iam_policy" "read_and_write" {
  name        = "${local.name}-read-and-write"
  description = "AWS Dynamodb read and write policy: ${local.name}"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.read_and_write_statement
  })
}
