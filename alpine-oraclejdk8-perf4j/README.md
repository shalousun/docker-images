集成MyPerf4J性能分析的基础镜像。1.0.0使用MyPerf4J 2.7.0版本。

# 镜像
```
docker pull registry.cn-shanghai.aliyuncs.com/shalousun/alpine-oraclejdk8-perf4j:1.0.1
```
# k8s jvm监控
首先java应用需要使用该镜像作为应用的基础镜像。部署操作如下：

## 添加config-map
添加一个`config-map`用于覆盖镜像中默认的`MyPerf4J.properties`。`config-map`配置示例如下：
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: springboot-undertow-perf4j-config
  namespace: default
  labels:
    k8s-app: springboot-undertow
data:
  MyPerf4J.properties: |-
    AppName=springboot-undertow
    MetricsProcessorType=1
    MethodMetricsFile=/MyPerf4J/log/method_metrics.log
    ClassMetricsFile=/MyPerf4J/log/class_metrics.log
    GCMetricsFile=/MyPerf4J/log/gc_metrics.log
    MemMetricsFile=/MyPerf4J/log/memory_metrics.log
    BufPoolMetricsFile=/MyPerf4J/log/buf_pool_metrics
    ThreadMetricsFile=/MyPerf4J/log/thread_metrics.log
    # Configure MethodMetrics TimeSlice, time unit: ms, min:1s, max:600s
    MethodMilliTimeSlice=10000
    # Configure JvmMetrics TimeSlice, time unit: ms, min:1s, max:600s
    JvmMilliTimeSlice=1000
    IncludePackages= com.benchmark.springboot
    # Configure show method params type
    ShowMethodParams=false
```
## 挂载MyPerf4J配置
在`kubernates deployments`上配置`volume`。
```
volumes:
- name: springboot-undertow-perf4j-config
  configMap:
    defaultMode: 0600
    name: springboot-undertow-perf4j-config
```
关在`volume`
```
volumeMounts:
- name: springboot-undertow-perf4j-config
  mountPath: /MyPerf4J/MyPerf4J.properties
  readOnly: true
  subPath: MyPerf4J.properties
```

## 修改启动参数
```
env:
  - name: JAVA_OPTS
    value: -javaagent:/MyPerf4J/MyPerf4J-ASM-2.7.0.jar -DMyPerf4JPropFile=/MyPerf4J/MyPerf4J.properties -server -Xmx2g -Xms2g -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -Djava.awt.headless=true
```
## 挂载MyPerf4J日志到本机
可以将MyPerf4J的性能分析日志挂载到宿主机。
```
volumes:
- name: perflog
  hostPath:
      path: /data/MyPerf4J/log # 宿主机挂载点
```
添加volume
```
volumeMounts:
- name: perflog
  mountPath: /MyPerf4J/log # 容器内挂载点
```