# Modularize Terraform Configuration

In this step, you will refactor the configuration from the last step to use a
module to define buckets used to host static websites.

Ensure that you are still working in the `learn-terraform` directory before moving on.

```
cd ~/learn-terraform
```{{execute}}

Now create a directory with empty files to define your module.

```
mkdir -p modules/aws-s3-static-website-bucket
cd modules/aws-s3-static-website-bucket
touch {README.md,main.tf,variables.tf,outputs.tf}
```{{execute}}

The file `README.md` isn't used by Terraform, but can be used to document your
module if you host it in a public or private Terraform Registry, or in a version
control system such as GitHub.

Add the following to `modules/aws-s3-static-website-bucket/README.md`{{open}}:

```
# AWS S3 static website bucket

This module provisions AWS S3 buckets configured for static website hosting.
```{{copy}}

Add configuration to `modules/aws-s3-static-website-bucket/main.tf`{{open}}:

```
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

  }

  force_destroy = true
}
```{{copy}}

Notice that you did not configure a provider for this module. Modules inherit
the provider configuration from the Terraform configuration that uses them be
default.

Like any Terraform configuration, modules can have variables and outputs.

Add the following to `modules/aws-s3-static-website-bucket/variables.tf`{{open}}:

```
variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type        = string
}
```{{copy}}

And add the following to `modules/aws-s3-static-website-bucket/outputs.tf`{{open}}:

```
output "arn" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "name" {
  description = "Name (id) of the bucket"
  value       = aws_s3_bucket.s3_bucket.id
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = aws_s3_bucket.s3_bucket.website_endpoint
}
```{{copy}}

Now refactor your `prod` and `dev` configuration to use this module.

Update `dev/main.tf`{{open}} to remove the entire `resource "aws_s3_bucket_object"
"webapp"` block, and replace it with the following:

```
module "website_s3_bucket" {
  source = "../modules/aws-s3-static-website-bucket"

  bucket_name = "${var.prefix}-${random_pet.petname.id}"
}
```{{copy}}

And update the bucket object resource to use the new 

resource "aws_s3_bucket_object" "webapp" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = website_s3_bucket.name
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```{{copy}}

You will also need to update `dev/outputs.tf`{{open}} to refer to the module instead of
the resource name:

```
output "website_endpoint" {
  description = "Website endpoint for this environment"
  value       = "http://${website_s3_bucket.website_endpoint}/index.html"
}
```{{copy}}

Change into the dev directory and re-initialize it.

```
cd dev/
terraform init
```{{execute}}

**Note**: Whenever you add or update a module, you will need to re-run
`terraform init` or `terraform get` to install it, even if it is located on the
same filesystem as your Terraform configuration.

Now you can provision the bucket:

```
terraform apply -var-file=dev.tfvars
```{{execute}}

Respond "yes" to the prompt, and once again visit the website endpoint in your
web browser to verify the website was deployed correctly.

The steps to update and apply your production configuration are nearly identical
to the ones for your dev environment. Be sure to apply your configuration with
the `-var-file=prod.tfvars` flag.

