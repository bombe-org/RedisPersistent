rm *$1*.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=1000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 256 
ycsb/bin/ycsb run  redis -P workload -p recordcount=1000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 1   > zipf_$1_0.1_1M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=2000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 256 
ycsb/bin/ycsb run  redis -P workload -p recordcount=2000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 1   > zipf_$1_0.1_2M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=4000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 256
ycsb/bin/ycsb run  redis -P workload -p recordcount=4000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 1   > zipf_$1_0.1_4M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 256 
ycsb/bin/ycsb run  redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 1   > zipf_$1_0.1_8M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=16000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 256
ycsb/bin/ycsb run  redis -P workload -p recordcount=16000000 -p operationcount=4000000 -p readproportion=0.9 -p updateproportion=0.1 -threads 1   > zipf_$1_0.1_16M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.8 -p updateproportion=0.2 -threads 256 
ycsb/bin/ycsb run  redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.8 -p updateproportion=0.2 -threads 1   > zipf_$1_0.2_8M.dat

./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.7 -p updateproportion=0.3 -threads 256  
ycsb/bin/ycsb run  redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.7 -p updateproportion=0.3 -threads 1   > zipf_$1_0.3_8M.dat


./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.6 -p updateproportion=0.4 -threads 256 
ycsb/bin/ycsb run  redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.6 -p updateproportion=0.4 -threads 1   > zipf_$1_0.4_8M.dat


./run2.sh $1
./run2.sh $1
sleep 10
ycsb/bin/ycsb load redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.5 -p updateproportion=0.5 -threads 256
ycsb/bin/ycsb run  redis -P workload -p recordcount=8000000 -p operationcount=4000000 -p readproportion=0.5 -p updateproportion=0.5 -threads 1   > zipf_$1_0.5_8M.dat


