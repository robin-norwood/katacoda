# Using Terraform modules

First, configure AWS for this scenario:

```
aws configure
```{{execute}}

You will be prompted to enter the AWS Key ID and Secret Key provided for this
lab. Use the `us-west-2` region.

```
$ aws configure
AWS Access Key ID [None]:  AKIA#########OIEU
AWS Secret Access Key [None]: Kg7W#################RMIyGv
Default region name [None]: us-west-2
Default output format [None]:
```

The configuration for this scenario is found in
`learn-terraform-modules/main.tf`. Open that file now.

This configuration includes three blocks:

- provider "aws": defines your provider. We'll be using AWS for this scenario.
- module "vpc": defines a Virtual Private Cloud (VPC), which will provide networking services for the rest of your infrastructure.
- module "ec2_instances": defines two EC2 instances within your VPC.

