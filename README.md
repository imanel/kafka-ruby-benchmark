# Benchmark of Kafka frameworks for Ruby

## Results

Each test is batch of 100k records, at least 10 batches per test.

| Implementation   | Mean    | Std. Deviaton  | Ops/s  | Slower |
| ---------------- | ------- | :------------: | :----: | :----: |
| Kafka (Batch)    | 1.7135s | 0.1072 (6.26%) | 58 360 | 1.00x  |
| Karafka (Batch)  | 2.2169s | 0.2456 (11.1%) | 45 108 | 1.29x  |
| Kafka (Single)   | 2.4647s | 0.1449 (5.88%) | 40 573 | 1.44x  |
| Phobos           | 2.6068s | 0.1234 (4.73%) | 38 361 | 1.52x  |
| Karafka (Single) | 2.6166s | 0.2098 (8.02%) | 39 217 | 1.53x  |
| Racecar          | 3.2057s | 0.1306 (4.07%) | 31 194 | 1.82x  |

Benchmark of JSON vs AVRO, size 1 of JSON used for benchmarks above. If using AVRO or large messages just adjust above results by difference.

|                       | Size 1   | Size 10  | Size 100 | Size 1000 | size 10000 |
| ----------------------| -------: | -------: | -------: | --------: | ---------: |
| JSON:                 | 0.285331 | 0.259881 | 0.529220 | 2.562496  | 24.578918  |
| MultiJSON:            | 0.531967 | 0.560616 | 0.791814 | 3.039967  | 27.899754  |
| AVRO explicit schema: | 5.467514 | 5.345877 | 5.413890 | 5.663500  |  7.689758  |
| AVRO implicit schema: | 5.246887 | 5.481632 | 5.447352 | 5.715120  |  7.890285  |

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

## Running Kafka Single

```
cd kafka
bundle exec ruby single.rb
```

## Running Kafka Batch

```
cd kafka
bundle exec ruby batch.rb
```

## Running Karafka Batch

```
cd karafka/batch
bundle exec karafka server
```

## Running Karafka Single

```
cd karafka/single
bundle exec karafka server
```

## Running Phobos

```
cd phobos
bundle exec phobos start -c config/json.yml -b json.rb
```

## Running Racecar

```
cd racecar
bundle exec racecar --require json_consumer JsonConsumer
```
