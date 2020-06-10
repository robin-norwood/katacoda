## Remove when using hashicorp image:

TF_VER=0.12.26

# apt-get --assume-yes install unzip

curl -O "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip"
unzip "terraform_${TF_VER}_linux_amd64.zip" -d /usr/local/bin/

mkdir -p learn-terraform/assets
#cp /root/index.html /root/learn-terraform/assets/
cd learn-terraform
touch {main.tf,variables.tf,outputs.tf}

## End

# useradd terraform --create-home
# chown -R terraform /home/terraform

# echo '127.0.0.1 localhost' >> /etc/hosts
