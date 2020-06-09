# Separate Configuration

In this step, you will separate your production and development environments
into two configuration files.

First, copy `main.tf` to `dev.tf`.

```
cp main.tf dev.tf
```{{execute}}

Next, rename `main.tf` to `prod.tf`.

```
mv main.tf prod.tf
```{{execute}}

Your configuration only needs one instance of the provider and random_pet
blocks, so comment out or delete these lines from `prod.tf`:

```
# provider "aws" {
#   access_key = "AKI#############IEU"
#   secret_key = "Kg7##################################yGv"
#   region     = "us-west-2"
# }

# resource "random_pet" "petname" {
#   length    = 4
#   separator = "-"
# }
```

Your configuration hasn't changed, however, so applying it will show no
changes.

```
terraform apply
```{{execute}}

Now your production and development environemnts are in separate files, but they
are managed by the same Terraform workspace, and share both configuration and
state. Because of this, a change that you intend to make in one environment can
affect the other.

Update the random_pet resource in `dev.tf`, changing value of the `length` argument to "5".

```
resource "random_pet" "petname" {
  length    = 5
  separator = "-"
}
```

Now, apply these changes, and notice that all five of your resources are
updated.

```
terraform apply
```{{execute}}

Respond with `yes` to apply the changes.

Before moving on, destroy the resources you've created so far.

```
terraform destroy
```{{execute}}

In the next step, you will separate your dev and production environments into
different workspaces, so each can be deployed and managed separately.

