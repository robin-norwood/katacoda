# Separate Workspaces

In the last step, you separated your configuration into two different files.
While this can help you organize configuration within a single project, it
doesn't help prevent accidental changes to parts of your infrastructure.

In this step, you will learn to use Terraform workspaces to manage two separate
environments with the same set of configuration.

Remove the `prod.tf` file you created in the last step, and rename `dev.tf` back
to `main.tf`:

```
rm prod.tf
mv dev.tf main.tf
```{{execute}}

The original configuration included references to the environment - dev or prod
- in several places. To make the configuration more generic, you will need to
remove and replace these references.

Replace the contents of `variables.tf` with:

```
variable "prefix" {
  description = "Prefix for buckets in this environment."
  default     = "dev"
}
```

Also replace `outputs.tf` with:

```
output "website_endpoint" {
  description = "Website endpoint for this environment"
  value       = "http://${aws_s3_bucket.web.website_endpoint}/index.html"
}
```

Now, update `main.tf` to reflect these changes.

First, update the resource name and bucket argument:

```
- resource "aws_s3_bucket" "dev" {
+ resource "aws_s3_bucket" "web" {
- bucket = "${var.dev_prefix}-${random_pet.petname.id}"
+ bucket = "${var.prefix}-${random_pet.petname.id}"
```

Also update the bucket resource name in the policy document:

```
        "Resource": [
-           "arn:aws:s3:::${var.dev_prefix}-${random_pet.petname.id}/*"
+           "arn:aws:s3:::${var.prefix}-${random_pet.petname.id}/*"
        ]
```

And finally update the object resource:

```
- resource "aws_s3_bucket_object" "dev" {
+ resource "aws_s3_bucket_object" "webapp" {

  acl          = "public-read"
  key          = "index.html"
- bucket       = aws_s3_bucket.dev.id
+ bucket       = aws_s3_bucket.bucket.id
  content      = file("${path.module}/assets/index.html")
  content_type = "text/html"
}
```

Create a new file called `dev.tfvars` to store variable definitions for your
development environment:

```
region = "us-west-2"
prefix = "dev"
```

Create another file called `prod.tfvars`:

```
region = "us-west-2"
prefix = "prod"
```

Now that your configuration is refactored to support either a dev or prod
environment, initialize your workspace again to ensure your Terraform
configuration is valid:

```
terraform init
```{{execute}}

Terraform commands operate in a default workspace, but you can create and manage
other workspaces as well.

```
terraform workspace new dev
```{{execute}}

Apply your configuration to the dev workspace:

```
terraform apply -var-file=dev.tfvars
```{{exceute}}

Enter "yes" at the prompt, and open the website endpoint in your web browser to
verify that your infrastructure was deployed successfully.

Now create and switch to a production workspace:

```
terraform workspace new prod
```{{execute}}

```
terraform apply -var-file=prod.tfvars
```{{execute}}

Again, respond to the prompt with "yes", and check the new production website
endpoint.

Now your environments can be managed independantly. This works well when the
configuration is identical betwen environments (aside from variable
definitions), but can be inflexible if you need different configuration between
environments, or need to manage the resources seperately. You also need to
ensure that all commands are run in the correct workspace.

Before moving on, destroy the resources you've created so far.

```
terraform destroy -var-file=prod.tfvars
```{{execute}}

Be sure to answer "yes" at the prompt.

```
terraform workspace select dev
terraform destroy -var-file=dev.tfvars
```{{execute}}

In the next step, you will manage your configuration in seperate directories.



