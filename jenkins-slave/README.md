docker build -t jenkins/jnlp-slave-maven .
docker login http://192.168.85.61 -u admin -p Harbor12345
docker tag jenkins/jnlp-slave-maven  192.168.85.61/develop/jenkins/jnlp-slave-maven:v1.0
docker push 192.168.85.61/develop/jenkins/jnlp-slave-maven:v1.0
