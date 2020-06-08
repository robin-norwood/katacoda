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

The `variables.tf` file defines a number of variables for this configuration.
Notice that most of these variables are passed to the module blocks.

Now, initialize your Terraform directory:

```
terraform init
```{{execute}}

Notice that in addition to the provider, Terraform initializes the two modules
defined in `main.tf`, one for the VPC, and one for the ec2 instances.

Terraform will install modules as needed. In this case, the EC2 module block has
a `source` argument:

```
  source  = "terraform-aws-modules/ec2-instance/aws"
```

Terraform will load the module from the public Terraform module registry based
on this. You can find each module's [documentation in the
registry](https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/2.12.0)
as well.

Another import argument for module blocks is the `version`. This configuration
specifies the version `2.12.0`.

The rest of the arguments are defined in the module documentation.

Now, apply this configuration:

```
terraform apply
```{{execute}}

You will need to answer `yes` to apply the plan. Notice that 

Now, update the module version in `main.tf` to a newer release: `2.13.0`.

```
  version = "2.13.0"
```{{copy}}

Terraform will only install new versions of modules when `terraform init` or
`terraform get` is run. After changing the module version, if you attempt to
plan or apply this configuration, Terraform will show an error. Update the
module configuration now:

```
terraform get
```{{execute}}

With the new version installed, apply the changes - in this case, updating the
module version won't change your infrastructure.

```
terraform apply
```{{execute}}

Terraform modules are stored in your local system, within the `.terraform`
directory for each workspace. Terraform modules are themselves just Terraform
configuration. You can inspect them as you would any other files.

```
tree -L 2 .terraform/modules
```{{execute}}

Before moving on, destroy the infrastructure you configured in this step:

```
terraform destroy
```{{execute}}

