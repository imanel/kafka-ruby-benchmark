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

## Inserting data for benchmark

```
bundle install
bundle exec rake bench:fill_kafka
```

## Running Karafka JSON

```
cd karafka_json
bundle exec karafka server
```

## Results

Each test is batch of 100k records, 10 batches per test.

| Implementation | Mean    | Std. Deviaton  | Records/s |
| -------------- | :-----: | :------------: | :-------: |
| Karafka JSON   | 6.5013s | 0.0885 (1.36%) | 15 382    |
