# Benchmark of Kafka frameworks for Ruby

## Results

Each test is batch of 100k records, at least 10 batches per test.

| Implementation   | Mean    | Std. Deviaton  | Ops/s  | Slower |
| ---------------- | ------- | :------------: | :----: | :----: |
| Kafka (Batch)    | 1.7135s | 0.1072 (6.26%) | 58 360 | 1.00x  |
| Kafka (Single)   | 2.4647s | 0.1449 (5.88%) | 40 573 | 1.44x  |
| Phobos           | 2.6068s | 0.1234 (4.73%) | 38 361 | 1.52x  |
| Racecar          | 3.2057s | 0.1306 (4.07%) | 31 194 | 1.82x  |
| Karafka (Batch)  | 5.6628s | 0.3167 (5.59%) | 17 659 | 3.30x  |
| Karafka (Single) | 7.9192s | 0.2359 (2.98%) | 12 627 | 4.62x  |

Benchmark of JSON vs AVRO, size 1 of JSON used for benchmarks above. If using AVRO or large messages just adjust above results by difference.

|                                  | user      | system   | total     | real      |
| -------------------------------- | --------: | -------: | --------: | --------: |
| JSON size 1:                     |  0.280000 | 0.000000 |  0.280000 |  0.285331 |
| MultiJSON size 1:                |  0.530000 | 0.000000 |  0.530000 |  0.531967 |
| AVRO explicit schema size 1:     |  5.410000 | 0.010000 |  5.420000 |  5.467514 |
| AVRO implicit schema size 1:     |  5.240000 | 0.000000 |  5.240000 |  5.246887 |
| JSON size 10:                    |  0.260000 | 0.000000 |  0.260000 |  0.259881 |
| MultiJSON size 10:               |  0.560000 | 0.000000 |  0.560000 |  0.560616 |
| AVRO explicit schema size 10:    |  5.340000 | 0.010000 |  5.350000 |  5.345877 |
| AVRO implicit schema size 10:    |  5.460000 | 0.000000 |  5.460000 |  5.481632 |
| JSON size 100:                   |  0.520000 | 0.010000 |  0.530000 |  0.529220 |
| MultiJSON size 100:              |  0.790000 | 0.010000 |  0.790000 |  0.791814 |
| AVRO explicit schema size 100:   |  5.410000 | 0.000000 |  5.410000 |  5.413890 |
| AVRO implicit schema size 100:   |  5.440000 | 0.000000 |  5.440000 |  5.447352 |
| JSON size 1000:                  |  2.450000 | 0.110000 |  2.560000 |  2.562496 |
| MultiJSON size 1000:             |  2.900000 | 0.110000 |  3.010000 |  3.039967 |
| AVRO explicit schema size 1000:  |  5.650000 | 0.010000 |  5.660000 |  5.663500 |
| AVRO implicit schema size 1000:  |  5.710000 | 0.000000 |  5.710000 |  5.715120 |
| JSON size 10000:                 | 22.660000 | 1.850000 | 24.510000 | 24.578918 |
| MultiJSON size 10000:            | 25.010000 | 2.140000 | 27.150000 | 27.899754 |
| AVRO explicit schema size 10000: |  7.470000 | 0.210000 |  7.680000 |  7.689758 |
| AVRO implicit schema size 10000: |  7.660000 | 0.200000 |  7.860000 |  7.890285 |

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

## Running Karafka Single

```
cd karafka_single
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
