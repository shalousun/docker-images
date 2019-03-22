kibana没有安装xpack插件的镜像.

# 构建镜像
```
docker build -t kibana-xpack-less:5.5.0 .
```

# 部署
```
# Example usage: kubectl create -f <this_file>
# ------------------- kibana Service ---------------------- #
apiVersion: v1
kind: Service
metadata:
 name: kibana-svc
 namespace: default
spec:
 type: NodePort
 ports:
 - port: 5601
   targetPort: 5601
   #nodePort: 30011
 selector:
  app: kibana
  tier: front
---
# ------------------- kibana Deployment ------------------- #
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: kibana-deployment
  namespace: default
spec:
  selector:
      matchLabels:
        app: kibana
        tier: front
  replicas: 1
  template:
    metadata:
      labels:
        app: kibana
        tier: front
    spec:
      containers:
        - name: kibana
          image: docker.elastic.co/kibana/kibana:6.4.0
          imagePullPolicy: Always
#          resources:
#            requests:
#              cpu: 100m
#              memory: 100Mi
#            limits:
#              cpu: 100m
#              memory: 100Mi
          env:
              - name:  ELASTICSEARCH_URL
                value: "http://172.31.205.24:9200"
          ports:
            - containerPort: 5601
      imagePullSecrets:
      - name: harbor-key
---
# ------------------- kibana ingress ---------------------- #
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: kibana-ingress
  namespace: default
spec:
  rules:
  - host: kibana.com
    http:
      #port: 80
      paths:
      - path: /
        backend:
          serviceName: kibana-svc
          servicePort: 5601
```