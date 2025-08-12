locals {
  read_capacity                = var.capacity.billing_mode == "PROVISIONED" ? var.capacity.read_capacity : null
  write_capacity               = var.capacity.billing_mode == "PROVISIONED" ? var.capacity.write_capacity : null
  range_key                    = var.primary_index.type == "compound" ? var.primary_index.sort_key : null
  stream_view_type             = var.stream.enabled ? var.stream.view_type : null
  name                         = var.md_metadata.name_prefix
  has_global_secondary_indexes = var.global_secondary_indexes != null && try((length(var.global_secondary_indexes) > 0), false)
  global_secondary_indexes     = local.has_global_secondary_indexes ? { for index in var.global_secondary_indexes : index.name => index } : {}
  # All indexed attributes must be declared. Generating this list is _rough_. All indexes will have a partition key but the sort key is optional.
  # We are creating an array of arrays of arrays, emptying any lists where the sort_key values are null, flattening the list so we have an array of
  # [key_name, key_type, key_name1, key_type1] then chunking the list to become [[key_name, key_type], [key_name1, key_type1]] and using that in a dynamic block
  global_secondary_index_attribute_list = local.has_global_secondary_indexes ? chunklist(flatten([for index in var.global_secondary_indexes : [[index.attributes.partition_key, index.attributes.partition_key_type], compact([lookup(index.attributes, "sort_key", null), lookup(index.attributes, "sort_key_type", null)])]]), 2) : []
}

resource "aws_dynamodb_table" "main" {
  name             = local.name
  billing_mode     = var.capacity.billing_mode
  read_capacity    = local.read_capacity
  write_capacity   = local.write_capacity
  hash_key         = var.primary_index.partition_key
  range_key        = local.range_key
  stream_enabled   = var.stream.enabled
  stream_view_type = local.stream_view_type

  point_in_time_recovery {
    enabled = var.pitr.enabled
  }

  attribute {
    name = var.primary_index.partition_key
    type = var.primary_index.partition_key_type
  }

  dynamic "attribute" {
    for_each = var.primary_index.type == "compound" ? [1] : []
    content {
      name = var.primary_index.sort_key
      type = var.primary_index.sort_key_type
    }
  }

  dynamic "attribute" {
    for_each = local.global_secondary_index_attribute_list
    content {
      name = attribute.value[0]
      type = attribute.value[1]
    }
  }

  dynamic "global_secondary_index" {
    for_each = local.global_secondary_indexes

    content {
      name            = global_secondary_index.key
      hash_key        = global_secondary_index.value["attributes"]["partition_key"]
      range_key       = try(global_secondary_index.value["attributes"]["sort_key"], null)
      write_capacity  = global_secondary_index.value["write_capacity"]
      read_capacity   = global_secondary_index.value["read_capacity"]
      projection_type = global_secondary_index.value["projection_type"]
    }
  }

  dynamic "ttl" {
    for_each = var.ttl.enabled ? [1] : []
    content {
      attribute_name = "TTL"
      enabled        = true
    }
  }
}

## MODULE_2.4
# module "budget" {
#   source       = "github.com/massdriver-cloud/terraform-modules//aws/forecasted-monthly-cost-budget"
#   limit_amount = var.budget.limit_amount
#   md_metadata  = var.md_metadata

#   subscriber_email_addresses = var.budget.email_addresses
#   # [
#   #  var.md_metadata.target.contact_email
#   # ]
# }
