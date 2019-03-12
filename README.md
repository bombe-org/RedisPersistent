# RedisPersistent

RedisPersistent is some kind of variants of [Redis](https://redis.io). 

The **motivation** of this repo is to improve the fork performance when redis triggered the *bgsave* function.
We **implement** Hourglass and Piggyback algorithms into Redis, the performance resutls show that RedisPersistent has a very small latency spike when *bgsave* triggered.

The Hourglass and Piggyback algorithms is described in the following paper.

>>> Liang Li, Guoren Wang, Gang Wu, Ye Yuan: Consistent Snapshot Algorithms for In-Memory Database Systems: Experiments and Analysis. 1284-1287

Besides, the performance of those algorithm is studied in [FrequentSnapshot](https://github.com/bombehub/FrequentSnapshot)

# Build
first, install: **autoconf**

`./build.sh`

# Test

The evaluation is based on [YCSB](https://github.com/brianfrankcooper/YCSB)

