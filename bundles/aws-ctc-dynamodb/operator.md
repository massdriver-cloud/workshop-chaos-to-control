## TODO: Add Runbook

<!-- MODULE_2.2 
## AWS DynamoDB Table

Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability. DynamoDB lets you offload the administrative burdens of operating and scaling a distributed database, so you don't have to worry about hardware provisioning, setup and configuration, replication, software patching, or cluster scaling.

### Design Decisions

- **Billing Mode**: Depending on use-case, the billing mode can be set to either `PROVISIONED` or `PAY_PER_REQUEST`.
- **Capacity Management**: Auto-scaling policies and CloudWatch alarms are set up to monitor the read and write capacity usage.
- **Key Schema**: The table supports both simple and composite primary keys.
- **Global Secondary Indexes**: Allowed for faster retrieval of data based on alternate key definitions.
- **TTL**: Time-to-Live (TTL) attributes can be enabled for automated data expiry.
- **Streams**: If enabled, DynamoDB Streams capture data modification events in the table.

### Runbook

#### Checking Table Details

To view details of a specific DynamoDB table:

```sh
aws dynamodb describe-table --table-name <table_name>
```

This command provides detailed information about the table, including its status, primary key schema, throughput settings, and more.

#### Monitoring Capacity Usage

For monitoring the read and write capacity units consumed and provisioned:

```sh
aws cloudwatch get-metric-data --metric-data-queries file://metric-queries.json
```

Save the following in `metric-queries.json` to query CloudWatch:

```json
{
    "MetricDataQueries": [
        {
            "Id": "readCapacity",
            "MetricStat": {
                "Metric": {
                    "Namespace": "AWS/DynamoDB",
                    "MetricName": "ConsumedReadCapacityUnits",
                    "Dimensions": [
                        {
                            "Name": "TableName",
                            "Value": "<table_name>"
                        }
                    ]
                },
                "Period": 60,
                "Stat": "Sum"
            }
        },
        {
            "Id": "writeCapacity",
            "MetricStat": {
                "Metric": {
                    "Namespace": "AWS/DynamoDB",
                    "MetricName": "ConsumedWriteCapacityUnits",
                    "Dimensions": [
                        {
                            "Name": "TableName",
                            "Value": "<table_name>"
                        }
                    ]
                },
                "Period": 60,
                "Stat": "Sum"
            }
        }
    ]
}
```

This will provide you with recent usage statistics of the specified DynamoDB table.

#### Alarming on Capacity Issues

If you have alarms set up for read or write capacity, you can describe them using:

```sh
aws cloudwatch describe-alarms --alarm-names <alarm_name>
```

This will provide the state and details of a given CloudWatch alarm.

#### Investigating Throttling

To investigate throttling issues, check the CloudWatch metrics for `ThrottledRequests`. Use the following command:

```sh
aws cloudwatch get-metric-statistics --namespace AWS/DynamoDB --metric-name ThrottledRequests --dimensions Name=TableName,Value=<table_name> --start-time <start_time> --end-time <end_time> --period 60 --statistics Sum
```

Set the `<start_time>` and `<end_time>` accordingly to get the data for the desired period.

#### Enabling TTL

To enable TTL on a DynamoDB table:

```sh
aws dynamodb update-time-to-live --table-name <table_name> --time-to-live-specification "Enabled=true, AttributeName=TTL"
```

This will automatically delete items based on the TTL attribute once the attribute’s value is older than the current UNIX timestamp.

These commands will help you monitor and troubleshoot your AWS DynamoDB tables, ensuring they are running optimally and cost-efficiently.
-->
