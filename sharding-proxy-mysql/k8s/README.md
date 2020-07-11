在`k8s`上部署`sharding-proxy`的模板。该模板使用于官方的`docker`镜像和自定义的`sharding-proxy`镜像。
官方`docker`镜像只能用于`PostgreSQL`数据库。对接mysql数据库的镜像需要自己制作。
下面来介绍在k8s上部署sharding-proxy组件的方法。

**注意：** 下面的版本仅仅针对apache sharding-sphere 4.1.1以后的版本。更低的版本配置可能不同。

# 创建configmap
## 创建server.yaml
在物理化部署sharding-proxy时，在解压sharding-proxy部署包后需要到conf目录中修改`server.yaml`文件,
在`server.yaml`至少需要启动认证配置。`server.yaml`的认证配置片段如下
```
authentication:
  users:
    root: # 自定义用户名
      password: root # 自定义用户名密码
    sharding: # 自定义用户名
      password: sharding # 自定义用户名
      authorizedSchemas: sharding_db, masterslave_db # 该用户授权可访问的数据库，多个用逗号分隔。缺省将拥有root权限，可访问全部数据库。
```
在k8s中部署sharding-proxy，则需要将server.yaml放入configmap中维护，最后将configmap挂载到容器中。
配置请参考`sharding-proxy-configmap.yaml`。

## 创建逻辑数据源配置
自定义配置主要是根据业务创建分库分表、读写分离、数据脱敏配置。根据实际情况参考官方的配置文档来配置。
Sharding-Proxy支持多逻辑数据源，每个以config-前缀命名的yaml配置文件，即为一个逻辑数据源。
这里以配置一个分表的配置为例。对于物理部署的直接参考官方的配置，按照规则创建配置文件并把配置文件放到`conf`目录下。

```
schemaName: sharding_db
dataSources:
  ds:
    url: jdbc:mysql://localhost:3306/test?autoReconnect=true&useUnicode=true&characterEncoding=utf-8
    username: root
    password: root
    connectionTimeoutMilliseconds: 30000
    idleTimeoutMilliseconds: 60000
    maxLifetimeMilliseconds: 1800000
    maxPoolSize: 50
shardingRule:
  tables:
    t_order:
      actualDataNodes: ds.t_order_$->{0..1}
      tableStrategy:
        inline:
          shardingColumn: order_id
          algorithmExpression: t_order_$->{order_id % 2}
      keyGenerator:
          type: SNOWFLAKE
          column: order_id
```
在k8s中部署sharding-proxy，则需要创建自定义的逻辑数据源，最后将configmap挂载到容器中。
配置请参考`sharding-proxy-configmap.yaml`。

# 容器化部署sharding-proxy
如果只是单纯在docker中部署，可以直接参考官方的部署方式。这里主要是介绍在k8s上部署sharding-proxy。

根据上面的说明和结合官方文档参考`sharding-proxy-configmap.yaml`修改配置。修改在k8s上创建sharding-proxy-configmap。
```
kubectl apply -f sharding-proxy-configmap.yaml
```
记下来是部署pod, 部署pod直接参考`sharding-proxy-deployment.yaml`。通常只需要修改namespace和镜像名。
在`sharding-proxy-deployment.yaml`部署模板中已经将`sharding-proxy-configmap.yaml`所有配置直接挂在到
容器中sharding-proxy的conf目录下，因此修改和添加配置只需要在`sharding-proxy-configmap.yaml`中操作。
```
kubectl apply -f sharding-proxy-deployment.yaml
```
# 访问sharding-proxy
在`sharding-proxy-deployment.yaml`模板中设置了使用NodePort方式来暴露了sharding-proxy service。暴露的端口号为`30016`.
可以通过程序或者是navicat等工具直接连接sharding-proxy服务。如果其他服务有在集群中占用`30016`端口。则修改部署模板中的
端口设置。