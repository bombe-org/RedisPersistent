# RedisPersistent
RedisPersistent is some kind of variants of [Redis](https://redis.io). 

The **motivation** of this repo is to improve the fork performance when redis triggered the *bgsave* function.
We **implement** Hourglass and Piggyback algorithms into Redis, the performance resutls show that RedisPersistent has a very small latency spike when *bgsave* triggered.

The Hourglass and Piggyback algorithms is described in the following paper.

>>> Li, Liang, Guoren Wang, Gang Wu, and Ye Yuan. "Consistent Snapshot Algorithms for In-Memory Database Systems: Experiments and Analysis." In 2018 IEEE 34th International Conference on Data Engineering (ICDE), pp. 1284-1287. IEEE, 2018.

Besides, the performance of those algorithm is studied in [FrequentSnapshot](https://github.com/bombehub/FrequentSnapshot).

# Build
first, you must install **autoconf**, and run the following command.

`./build.sh`

# Run YCSB benchmark

The evaluation is based on [YCSB](https://github.com/brianfrankcooper/YCSB)

First, you need to run the redis server, like:

`./run.sh cou`   // cou, could be replaced by zz,mk,ll

Then, you should install java-jre, and download the ycsb package for redis, the quick link is [here](https://github.com/brianfrankcooper/YCSB/releases/download/0.15.0/ycsb-redis-binding-0.15.0.tar.gz)

Finally, run the following command in the path of **ycsb-redis** to begin the benchmark:

`bin/ycsb load redis -P workloads/workloada -p redis.host=localhost -p redis.port=6380`

`bin/ycsb run redis -P workloads/workloada -p redis.host=localhost -p redis.port=6380`
