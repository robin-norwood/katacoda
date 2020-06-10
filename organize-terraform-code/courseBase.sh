## Remove when using hashicorp image:

TF_VER=0.12.26

curl -O "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip"
unzip "terraform_${TF_VER}_linux_amd64.zip" -d /usr/local/bin/

## End remove

mkdir -p learn-terraform/assets
cd learn-terraform
touch {main.tf,variables.tf,outputs.tf}

# Include current dir in prompt
PS1='\W$ '

# Prevent `yes` command from accidentally being run
alias yes=""

clear
