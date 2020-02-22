# kafka-eagle-docker
## Install kafka-eagle with Docker

### Pulling the image

```sh
docker pull registry.cn-hangzhou.aliyuncs.com/shalousun/kafka-eagle:1.4.4
```

### Start

```sh
sudo docker run --name kafka-eagle --net host \
-v /conf/system-config.properties:/app/kafka-eagle/conf/system-config.properties \
registry.cn-hangzhou.aliyuncs.com/shalousun/kafka-eagle:1.4.4
```

### Start use docker-compose

```
version: '3'
services:
  kafka-eagle:
    container_name: kafka-eagle
    image: registry.cn-hangzhou.aliyuncs.com/shalousun/kafka-eagle:1.4.4
    ports:
      - "8048:8048"
```

### Using custom Docker images

```sh
FROM registry.cn-hangzhou.aliyuncs.com/shalousun/kafka-eagle:1.4.4
COPY log4j.properties /app/kafka-eagle/conf
COPY system-config.properties /app/kafka-eagle/conf
```
