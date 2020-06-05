TF_VER = 0.12.26

#mkdir -p ~/src

apt-get install unzip
#cd ..
curl -O "https://releases.hashicorp.com/terraform/${TF_VER}/terraform_${TF_VER}_linux_amd64.zip"
unzip "terraform_${TF_VER}_linux_amd64.zip" -d /usr/local/bin/


# cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/counting-service -O
# mv ~/src/counting-service /usr/local/bin
# cd ~/src && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/bin/dashboard-service -O
# mv ~/src/dashboard-service /usr/local/bin
# chmod +x /usr/local/bin/*-service

# useradd consul --create-home
# mkdir -p /etc/consul.d
# cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/counting.json -O
# cd /etc/consul.d && curl -L https://github.com/hashicorp/katakoda/raw/master/consul-connect/assets/config/dashboard.json -O
# mkdir -p /home/consul/log
# chown -R consul /home/consul
# echo '127.0.0.1 localhost' >> /etc/hosts
# runuser -l consul -c "consul agent -dev -client 0.0.0.0 -config-dir=/etc/consul.d >/home/consul/log/consul.log 2>&1 &"
