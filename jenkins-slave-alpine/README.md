# jnlp-slave-maven
jenkins slave镜像，本镜像包含java构建的maven工具、kubectl、docker。用于在kubernetes上做k8s的集成。
目前全部只能使用root用户进行docker in docker.
# pull
```
docker pull registry.cn-hangzhou.aliyuncs.com/jenkins-cicd/jenkins-slave-alpine:3.35-2
```
# build
```youtrack
docker build -t registry.cn-hangzhou.aliyuncs.com/jenkins-cicd/jenkins-slave-alpine:3.35-2 .
```
# delete
```youtrack
docker rmi $(docker images | grep "jenkins-slave-alpine" | awk '{position=$1":"$2;print position}')
```