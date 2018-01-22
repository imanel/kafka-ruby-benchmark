# Benchmark of Kafka frameworks for Ruby

## Results

Each test is batch of 100k records, at least 10 batches per test.

| Implementation | Mean     | Std. Deviaton  | Ops/s  | Slower (Base) | Slower (Framework) |
| -------------- | -------- | :------------: | :----: | :-----------: | :----------------: |
| Kafka JSON     |  2.4647s | 0.1449 (5.88%) | 40 573 | 1.00x         | 1.00x              |
| Kafka AVRO     |  8.2047s | 0.1313 (1.60%) | 12 188 | 3.33x         | 3.33x              |
| Karafka JSON   |  8.5558s | 0.1241 (1.45%) | 11 688 | 3.47x         | 1.00x              |
| Karafka AVRO   | 15.3608s | 0.2132 (1.39%) |  6 510 | 6.23x         | 1.79x              |
| Phobos JSON    |  2.6068s | 0.1234 (4.73%) | 38 361 | 1.06x         | 1.00x              |
| Phobos AVRO    |  8.2769s | 0.1474 (1.78%) | 12 082 | 3.36x         | 3.17x              |
| Racecar JSON   |  3.2057s | 0.1306 (4.07%) | 31 194 | 1.30x         | 1.00x              |
| Racecar AVRO   |  9.0419s | 0.1430 (1.58%) | 11 060 | 3.67x         | 2.82x              |

Benchmark of JSON vs AVRO, size 1 used for benchmarks above.

|                                  | user      | system   | total     | real      |
| -------------------------------- | --------: | -------: | --------: | --------: |
| JSON size 1:                     |  0.280000 | 0.000000 |  0.280000 |  0.285331 |
| AVRO explicit schema size 1:     |  5.410000 | 0.010000 |  5.420000 |  5.467514 |
| JSON implicit schema size 1:     |  5.240000 | 0.000000 |  5.240000 |  5.246887 |
| JSON size 10:                    |  0.260000 | 0.000000 |  0.260000 |  0.259881 |
| AVRO explicit schema size 10:    |  5.340000 | 0.010000 |  5.350000 |  5.345877 |
| JSON implicit schema size 10:    |  5.460000 | 0.000000 |  5.460000 |  5.481632 |
| JSON size 100:                   |  0.520000 | 0.010000 |  0.530000 |  0.529220 |
| AVRO explicit schema size 100:   |  5.410000 | 0.000000 |  5.410000 |  5.413890 |
| JSON implicit schema size 100:   |  5.440000 | 0.000000 |  5.440000 |  5.447352 |
| JSON size 1000:                  |  2.450000 | 0.110000 |  2.560000 |  2.562496 |
| AVRO explicit schema size 1000:  |  5.650000 | 0.010000 |  5.660000 |  5.663500 |
| JSON implicit schema size 1000:  |  5.710000 | 0.000000 |  5.710000 |  5.715120 |
| JSON size 10_000:                | 22.660000 | 1.850000 | 24.510000 | 24.578918 |
| AVRO explicit schema size 10000: |  7.470000 | 0.210000 |  7.680000 |  7.689758 |
| JSON implicit schema size 10000: |  7.660000 | 0.200000 |  7.860000 |  7.890285 |

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

## Running Phobos JSON

```
cd phobos
bundle exec phobos start -c config/json.yml -b json.rb
```

## Running Phobos AVRO

```
cd phobos
bundle exec phobos start -c config/avro.yml -b avro.rb
```

## Running Racecar JSON

```
cd racecar
bundle exec racecar --require json_consumer JsonConsumer
```

## Running Racecar AVRO

```
cd racecar
bundle exec racecar --require avro_consumer AvroConsumer
```
