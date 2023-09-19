sudo docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest
sudo docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest lixinyang/corehome.admin:latest

sudo docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:latest
sudo docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:latest lixinyang/corehome.homepage:latest

sudo docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest
sudo docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest lixinyang/corehome.reverseproxy:latest

sudo docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest
sudo docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:latest
sudo docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest

sudo docker pull mysql

docker images  | grep none | awk '{print $3}' | xargs docker rmi
