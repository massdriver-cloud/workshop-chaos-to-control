## MODULE_2.1
# locals {
#   period = "60"
# }

# module "alarm_channel" {
#   source      = "github.com/massdriver-cloud/terraform-modules//aws/alarm-channel?ref=b3f3449"
#   md_metadata = var.md_metadata
# }

# resource "aws_cloudwatch_metric_alarm" "write_capacity" {
#   count               = var.capacity.billing_mode == "PROVISIONED" ? 1 : 0
#   depends_on          = [aws_dynamodb_table.main]
#   alarm_name          = "${local.name}: Write Capacity Usage"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   threshold           = "80"
#   alarm_description   = "Total Write capacity consumption of Dynamodb table ${local.name} is above 80%. Increase the capacity to avoid throttling."
#   actions_enabled     = "true"
#   alarm_actions       = [module.alarm_channel.arn]
#   ok_actions          = [module.alarm_channel.arn]

#   metric_query {
#     id          = "m3"
#     expression  = "(m1 / (m2 * ${local.period})) * 100"
#     label       = "Write Capacity Consumed"
#     return_data = true
#   }

#   metric_query {
#     id = "m1"

#     metric {
#       metric_name = "ConsumedWriteCapacityUnits"
#       namespace   = "AWS/DynamoDB"
#       period      = local.period
#       stat        = "Sum"

#       dimensions = {
#         TableName = local.name
#       }
#     }
#   }

#   metric_query {
#     id = "m2"

#     metric {
#       metric_name = "ProvisionedWriteCapacityUnits"
#       namespace   = "AWS/DynamoDB"
#       period      = local.period
#       stat        = "Sum"

#       dimensions = {
#         TableName = local.name
#       }
#     }
#   }
# }

# resource "massdriver_package_alarm" "write_capacity" {
#   count             = var.capacity.billing_mode == "PROVISIONED" ? 1 : 0
#   cloud_resource_id = aws_cloudwatch_metric_alarm.write_capacity[count.index].arn
#   display_name      = "DynamoDB Write Capacity Utilization"
# }
