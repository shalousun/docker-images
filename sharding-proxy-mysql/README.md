docker build -t sharding-proxy-mysql:4.0.0-RC3 .

docker run -d -v /data/sharding/conf:/opt/sharding-proxy/conf --env PORT=3308 -p13308:3308 sharding-proxy-mysql:4.0.0-RC3