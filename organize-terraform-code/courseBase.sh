## Remove when using hashicorp image:

TF_VER=0.12.26

apt-get --assume-yes install unzip
apt-get --assume-yes install awscli

curl -O "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip"
unzip "terraform_${TF_VER}_linux_amd64.zip" -d /usr/local/bin/

git clone https://github.com/hashicorp/learn-terraform-modules.git
cd learn-terraform-modules
git checkout tags/ec2-instances -b ec2-instances

## End

# useradd terraform --create-home
# chown -R terraform /home/terraform

# echo '127.0.0.1 localhost' >> /etc/hosts
