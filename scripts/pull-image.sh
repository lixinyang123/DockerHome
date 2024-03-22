#!/bin/bash

docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest
docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest lixinyang/corehome.admin:latest
docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.admin:latest

docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:home
docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:home lixinyang/corehome.homepage:latest
docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.homepage:home

docker pull registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest
docker tag registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest lixinyang/corehome.reverseproxy:latest
docker rmi registry.cn-shenzhen.aliyuncs.com/lllxy/corehome.reverseproxy:latest

docker pull mysql
