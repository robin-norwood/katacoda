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
blocks, so comment or delete these lines from `prod.tf`:

```
#provider "aws" {
#  access_key = "AKI#############IEU"
#  secret_key = "Kg7##################################yGv"
#  region     = "us-west-2"
#}

#resource "random_pet" "petname" {
#  length    = 4
#  separator = "-"
#}
```

