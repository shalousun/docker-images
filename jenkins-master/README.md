docker build -t jenkins/jenkins:2.89.3-maven .
docker login 192.237.1.1 -u admin -p Harbor12345
docker tag jenkins/jenkins:2.89.3-maven  192.237.1.1/develop/jenkins/jenkins:2.89.3-maven
docker push 192.237.1.1/develop/jenkins/jenkins:2.89.3-maven
