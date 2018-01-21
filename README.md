# Benchmark for Kafka frameworks for Ruby

## Running Kafka

This Docker image will expose Kafka on port `9092` and Zookeeper on port `2181`.

```
docker run -d \
  --name kafka \
  -p 2181:2181 \
  -p 9092:9092 \
  --env ADVERTISED_HOST=127.0.0.1 \
  --env ADVERTISED_PORT=9092 \
  spotify/kafka
```
