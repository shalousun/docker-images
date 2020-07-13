使用docker-compose部署sharding-proxy

# 环境要求
- docker 1.8+
- docker-compose 1.12+
- mysql 5.7+

其他要求，安装的docker需要能够从自建的harbor上下载sharding-proxy的镜像。
# docker-compose安装
由于docker-compose运行在k8s不太稳定，因此目前使用docker-compose来部署sharding-proxy。
下面介绍docker-compose的安装。

## 下载docker-compose
```
https://github-production-release-asset-2e65be.s3.amazonaws.com/15045751/6e19c880-7b13-11ea-97d7-bec401ece2d4?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20200527%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200527T140431Z&X-Amz-Expires=300&X-Amz-Signature=6fa6e2efd7f3e53f608b28e70c0e756274e6439cb28b491b9f0aaf269429054d&X-Amz-SignedHeaders=host&actor_id=9592228&repo_id=15045751&response-content-disposition=attachment%3B%20filename%3Ddocker-compose-Linux-x86_64&response-content-type=application%2Foctet-stream
```
上面的连接可能会失效，如失效则请直接访问github找到对应的版本。
```
https://github.com/docker/compose/releases
```
下载后重名为docker-compose。如果你在windows上下载也可以重命名后传到linux服务器上。
然后将docker-compose放到`/usr/local/bin/`目录下。然后执行下列命令完成安装。
```
sudo chmod +x /usr/local/bin/docker-compose
```
安装完成后可以执行下面命令检查
```
docker-compose --version
```
# 部署sharding-proxy
在部署sharding-proxy可以创建一个sharding-proxy的目录用于放置部署配置。
## 创建docker-compose.yaml编排文件

编排文件内容参考如下：
```
version: '3'
services:
  sharding-proxy:
    image: 172.31.1.165/library/sharding-proxy-mysql:4.0.1
    container_name: sharding-proxy
    ports:
      - 3307:3307
    volumes:
     - ./config-ctei.yaml:/opt/sharding-proxy/conf/config-ctei.yaml
     - ./config-iot-smart-home.yaml:/opt/sharding-proxy/conf/config-iot-smart-home.yaml
     - ./server.yaml:/opt/sharding-proxy/conf/server.yaml
    networks:
      - esnet
networks:
  esnet:
```
volumes中的配置表示把本地的配置挂载到sharding-proxy容器中。可以挂载多个文件。
容器中挂载的配置路径为`/opt/sharding-proxy/conf`。上面配置中暴露的端口是3307。
## 创建server.yaml
内容配置参考如下
```
authentication:
  users:
    root:
      password: Znjj@Box2017
    sharding:
      authorizedSchemas: iot_ctei_db,iot_smarthome_platform
      password: Znjj@Box2017
props:
  executor.size: 16
  sql.show: true
```
给配置文件主要用于配置连接sharding-proxy的用户名密码
- authorizedSchemas改配置项可以配置多个数据库，多个之间用逗号分隔。
- sql.show配置为true方便查sql执行情况，毕竟代理目前只是作为工具使用。
## 创建数据库分表分库配置
当前主要是分表。Sharding-Proxy支持多逻辑数据源，每个以config-前缀命名的yaml配置文件，即为一个逻辑数据源。
因为根据数据情况来创建响应的配置。下面以iot平台的数据库分表使用为例，目前主要涉及到两个库，一个ctei存储库，一个是
iot主业务库iot-smart-home，因此根据规则来创建两个库的配置文件。

为iot主业务库创建config-iot-smart-home.yaml，下面只是介绍，更多表配置请参照规则自行添加。
```
schemaName: iot_smarthome_platform
dataSources:
  ds:
    connectionTimeoutMilliseconds: 30000
    idleTimeoutMilliseconds: 60000
    maxLifetimeMilliseconds: 1800000
    maxPoolSize: 50
    password: pwd
    url: jdbc:mysql://172.31.131.124:3306/iot_smarthome_platform?autoReconnect=true&useUnicode=true&characterEncoding=utf-8
    username: root
shardingRule:
  tables:
    t_room_info:
      actualDataNodes: ds.t_room_info_$->{0..31}
      tableStrategy:
        standard:
          shardingColumn: iot_account
          preciseAlgorithmClassName: com.iflytek.iot.sharding.algorithm.CommonPreciseShardingAlgorithm
    t_house_info:
      actualDataNodes: ds.t_house_info_$->{0..15}
      tableStrategy:
        standard:
          shardingColumn: iot_account
          preciseAlgorithmClassName: com.iflytek.iot.sharding.algorithm.CommonPreciseShardingAlgorithm
```
为ctei创建config-ctei.yaml
```
schemaName: iot_ctei_db
dataSources:
  ds:
    connectionTimeoutMilliseconds: 30000
    idleTimeoutMilliseconds: 60000
    maxLifetimeMilliseconds: 1800000
    maxPoolSize: 50
    password: pwd
    url: jdbc:mysql://172.31.131.124:3306/iot_ctei_db?autoReconnect=true&useUnicode=true&characterEncoding=utf-8
    username: root
shardingRule:
  tables:
    t_report_device_info:
      actualDataNodes: ds.t_report_device_info_$->{0..15}
      tableStrategy:
        standard:
          shardingColumn: ctei
          preciseAlgorithmClassName: com.iflytek.iot.sharding.algorithm.CommonPreciseShardingAlgorithm
```
## 启动和停止容器
完成上面的配置后，就可以启动sharding-proxy。

启动
```
docker-compose up -d
```
停止
```
docker-compose down
```
**注意：** 执行启动或者是停止命令都需要进入到sharding-proxy目录，
即必须是在docker-compose.yaml所在目录下执行。

## 登陆sharding-proxy
sharding-proxy可以像登陆真正mysql服务器一样通过命令含登陆，命令和mysql操作完全一致，
用户名密码则为自己在上面的配置文件中配置。整个操作完全一致，这里就不在介绍。

## 查看日志
如果你需要观察sql语句在sharding-proxy中的执行情况。通过docker logs来查看。

```
# 查询出sharding-proxy容器的id
docker ps|grep sharding-proxy
# 根据容器id查看日志
docker logs -f [容器id]
```
# 完整部署参考
可以参考172.31.131.146服务上sharding-proxy部署例子完成，
部署目录参考`/data/thirdsoft/sharding-proxy-ctei`。
