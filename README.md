# Massdriver Workshop: From Chaos to Control

**Audience:** DevOps Engineers, Platform Engineers, and Infrastructure-minded Developers  
**Duration:** 3-4 hours  
**Format:** Interactive walkthroughs, collaborative exercises (individual or team-based), optional BYO-IaC  
**Project:** Serverless API needs DynamoDB Table

---

## Prerequisites

Before starting this workshop, ensure you have:

- **Massdriver Account**: Register for a [14-day free trial](https://app.massdriver.cloud/register)
- **Massdriver Service Account & CLI Setup**: Follow the [official CLI setup documentation](https://docs.massdriver.cloud/cli/overview) to create a service account and configure CLI authentication
- **AWS Account**: Valid AWS account with appropriate permissions

> **💡 Workshop Tip**: If you get stuck on any module tasks, you can search the codebase for `MODULE_` to find commented-out solutions. For example, `grep -r "MODULE_" .` or use your editor's search to find hints and complete implementations for each workshop exercise.
> 
> **📋 Complete Solution**: The `completed` branch contains the fully implemented workshop with all tasks completed. You can reference it anytime with `git checkout completed` or compare your progress with `git diff completed`.

---

## Repository Structure

This workshop repository contains the following components:

### Bundles

Workshop teams will build these Massdriver bundles during the hands-on sessions:

- **`bundles/aws-ctc-dynamodb/`** - **[Primary Workshop Focus]** Teams will build this production-ready DynamoDB bundle from scratch, learning core Massdriver concepts through iterative development

- **`bundles/aws-ctc-lambda/`** - AWS Lambda function bundle for connecting to and testing the DynamoDB table created in the workshop

- **`bundles/aws-ctc-api-gateway/`** - API Gateway bundle that routes HTTP requests to the Lambda function, completing the serverless stack

- **`bundles/demo-ctc-app/`** - Demonstration application bundle that consumes DynamoDB connection artifacts through Massdriver's visual interface, showing how bundles connect and share data

### Configuration Components
- **`artifact-definitions/`** - Custom schema definitions for Massdriver artifacts specific to this workshop's infrastructure components

- **`components/aws/`** - Reusable JSON schemas that your organization defines once and uses anywhere. Instead of every bundle defining "AWS region" or "budget limits" differently, you create these shared definitions so everything stays consistent across your infrastructure.

---

## Module 1: The DevOps Bottleneck – Scaling Without Burning Out

**Problem:**  
Teams can't scale engineering productivity because DevOps resources are stretched thin — ratios like 1:20 are the norm. Platform work is a bottleneck.

**Focus:**  
Learn how Massdriver eliminates the most tedious parts of infrastructure provisioning. Instead of waiting days for infrastructure tickets or wrestling with complex Terraform syntax, you'll create simple forms with smart defaults that developers actually want to use.

**Workshop Tasks in This Module:**
- ✅ **Presets** (Free Tier & Production) - Create templates so developers can pick "Development" or "Production" instead of figuring out capacity planning
- ✅ **Conditional fields** (billing mode) - Build forms that adapt intelligently, showing capacity settings only when needed
- ✅ **Enum constraints** (region) - Provide controlled choices instead of forcing developers to memorize region codes
- ✅ **Immutable fields** (region) - Prevent costly mistakes from accidental post-deployment changes

**Hands-on Exercise:**  
You'll transform raw DynamoDB Terraform into a developer-friendly bundle. By the end, you'll see how a developer can provision a production-ready database by filling out a simple form instead of wrestling with Terraform syntax.

**Key Outcome:** Developers provision infrastructure in minutes, not days. DevOps bottleneck eliminated.

---

## Module 2: The Infrastructure Mess – Drift, Docs, and Duplication

**Problem:**  
Everyone's infra is a snowflake. Spaghetti Terraform, one-off configurations, copy-pasted Notion docs for runbooks, and duplicating entire codebases just to create a new environment.

**Focus:**  
Discover how Massdriver makes infrastructure management so intuitive that developers won't need to reach for the AWS console. You'll learn to embed operational knowledge directly into infrastructure, eliminating documentation copy-pasta and environment duplication.

**Workshop Tasks in This Module:**
- ✅ **Monitoring integration** - Embed useful alarms directly into your bundle, eliminating separate monitoring setup
- ✅ **Runbooks** - Embed operational knowledge in your infrastructure instead of maintaining scattered Notion docs
- ✅ **Compliance scanning** (Checkov) - Build security and compliance validation directly into deployment
- ✅ **Budget requirements** - Embed cost controls to prevent surprise bills

**Hands-on Exercise:**  
You'll add monitoring, runbooks, and compliance scanning to your DynamoDB bundle. Experience how Massdriver handles environment parity - create new environments with a simple click instead of duplicating Terraform code.

**Key Outcome:** No more Notion runbooks, no more copy-pasted configurations, no more environment inconsistencies.

---

## Module 3: Devs Blocked by Infra – Where's My Self-Service?

**Problem:**  
Developers are constantly blocked by infra needs — but when they're handed tools, there's no guardrails. DevOps teams are stuck between enabling and controlling.

**Focus:**  
Experience the complete Massdriver platform - where infrastructure components connect automatically, developers have safe self-service capabilities, and operational excellence is built-in from day one.

**Workshop Tasks in This Module:**
- ✅ **$md.enum integration** - See how dropdown menus dynamically populate with IAM policies from your connected DynamoDB table
- **Lambda bundle deployment** - Publish a Lambda bundle and watch Massdriver automatically detect dependencies
- **Visual stack assembly** - Connect and deploy your complete serverless stack through the visual canvas
- **Complete self-service experience** - Access presets, monitor alarms, reference runbooks, and manage IAM - all in one platform

**Hands-on Exercise:**  
Deploy the demo app to see dynamic IAM policy selection in action. Then publish and deploy the Lambda bundle, observing how Massdriver automatically establishes the DynamoDB connection. Finally, assemble and deploy your complete API Gateway + Lambda + DynamoDB serverless stack using the visual canvas. Experience how you can monitor alarms, access runbooks, and use presets - achieving true self-service without sacrificing operational excellence.

**Key Outcome:** True developer self-service with built-in guardrails, operational excellence, and zero manual configuration.

### 📝 Testing Your Lambda Function

Once your serverless stack is deployed, you can interact with your Lambda function directly through the API Gateway endpoint:

**1. Get your API Gateway ID:**
```bash
aws apigateway get-rest-apis --query 'items[*].{Name:name,Id:id,CreatedDate:createdDate}' --output table --region us-east-1
```

**2. Test the Lambda function with curl:**

**GET request** (list all hotels):
```bash
curl https://YOUR_API_ID.execute-api.us-east-1.amazonaws.com/live/hotels -X GET
```

**POST request** (add a new hotel):
```bash
curl https://YOUR_API_ID.execute-api.us-east-1.amazonaws.com/live/hotels \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"name": "Grand Plaza Hotel"}'
```

Replace `YOUR_API_ID` with the actual API Gateway ID from step 1. The Lambda function expects a JSON body with a `name` field for POST requests and will automatically generate an ID and timestamp for each hotel entry.

---

## Wrap-Up: From Chaos to Control

**Congratulations!** 🎉 You've successfully transformed from infrastructure chaos to complete control using Massdriver. Whether you followed along during the live workshop or completed this on your own, you've experienced a fundamental shift in how infrastructure can be managed.

### What You've Accomplished

By the end of this workshop, you've built and deployed:

- **Production-ready DynamoDB bundle** with smart defaults, presets, and compliance scanning
- **Complete serverless stack** (API Gateway + Lambda + DynamoDB) deployed through visual composition
- **Operational excellence built-in** with monitoring, runbooks, and cost controls
- **True developer self-service** with guardrails and automatic dependency management

### Key Takeaways

**Before Massdriver:**
- DevOps teams are bottlenecks (1:20 ratios)
- Brittle pipelines are scattered across 10s to 100s of repos
- Developers are blocked or break things
- Documentation lives in scattered docs
- Copy-paste configurations everywhere

**After Massdriver:**
- Developers self-serve safely with smart forms
- Infrastructure is standardized and consistent
- Operational knowledge is embedded in code
- Environment parity is automatic
- True self-service without sacrificing control

### Next Steps

Ready to eliminate infrastructure chaos in your organization? Here's how to get started:

1. **Start Your Free Trial**: [Sign up for 14 days free](https://app.massdriver.cloud/register)
2. **Bring Your Own Infrastructure**: Migrate your existing Terraform modules into Massdriver bundles
3. **Join the Community**: Connect with other platform engineers in our [community Slack](https://join.slack.com/t/massdrivercommunity/shared_invite/zt-1sxbzx8e1-7yNWG8OVVhIQrGF_lXt~nA)
4. **Learn More**: Explore our [documentation](https://docs.massdriver.cloud) and [additional examples](https://github.com/massdriver-cloud/)

### Questions or Need Help?

- **Documentation**: [docs.massdriver.cloud](https://docs.massdriver.cloud)
- **Community Support**: [Massdriver Community Slack](https://join.slack.com/t/massdrivercommunity/shared_invite/zt-1sxbzx8e1-7yNWG8OVVhIQrGF_lXt~nA)
- **Enterprise Support**: [Contact our team](https://www.massdriver.cloud/contact)

Remember: Infrastructure doesn't have to be chaos. With the right tools and approach, you can give developers the self-service they need while maintaining the control and operational excellence your organization requires.

**Welcome to infrastructure control.** 🚀

