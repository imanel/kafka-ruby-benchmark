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

## Running Karafka AVRO

```
cd karafka_avro
bundle exec karafka server
```

## Results

Each test is batch of 100k records, 10 batches per test.

| Implementation | Mean    | Std. Deviaton  | Records/s | Slower |
| -------------- | :-----: | :------------: | :-------: | :----: |
| Karafka JSON   | 6.5457s | 0.1285 (1.96%) | 15 277    | 1.00x  |
| Karafka AVRO   | 7.1797s | 0.1029 (1.43%) | 13 928    | 1.10x  |
