# aws_api_gw


api gateway module

Usage Example

```hcl
module "ec2_instance" {
  source = "VahagnMian/api-gw/aws"

  source = "../aws_api_gw"
  info_title = "api_gw"
  info_version = "1.0"
  name = "api_gw"
  endpoint_config_type = "REGIONAL"
  stage_name = "api-stage"
}
```
