es镜像已经集成了opendistro_sql。

# docker单机版es集群状态修改
docker 部署的单机版的 ES 状态为 Yellow，在 Kibana 的管理界面看到的 index 的状态也是 Yellow，这样看起来很不舒服，如何让 Yellow 变成 Green 呢

这个问题在于单机版的 ES，是没有备份的，没有副本，设置 index 副本的数量为 0 即可

## 解决办法
- curl

```
curl -XPUT 'http://localhost:9200/_settings' -d '
{
    "index" : {
        "number_of_replicas" : 0
    }
}'
```

- kibana console

```
PUT _settings
{
    "index" : {
        "number_of_replicas" : 0
    }
}
```