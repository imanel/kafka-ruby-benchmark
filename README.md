# Benchmark of Kafka frameworks for Ruby

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

## Running Kafka JSON

```
cd kafka
bundle exec ruby json.rb
```

## Running Kafka AVRO

```
cd kafka
bundle exec ruby avro.rb
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

| Implementation | Mean    | Std. Deviaton  | Ops/s  | Slower (Base) | Slower (Framework) |
| -------------- | :-----: | :------------: | :----: | :-----------: | :----------------: |
| Kafka JSON     | 2.4647s | 0.1449 (5.88%) | 40 573 | 1.00x         | 1.00x              |
| Kafka AVRO     | 8.2047s | 0.1313 (1.60%) | 12 188 | 3.33x         | 3.33x              |
| Karafka JSON   | 6.5457s | 0.1285 (1.96%) | 15 277 | 2.65x         | 1.00x              |
| Karafka AVRO   | 7.1797s | 0.1029 (1.43%) | 13 928 | 2.91x         | 1.10x              |

## TODO

- [ ] Add results for [Phobos](https://github.com/klarna/phobos)
- [ ] Add results for [Racecar](https://github.com/zendesk/racecar)
