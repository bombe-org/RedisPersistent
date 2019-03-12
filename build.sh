cd cou-redis-3.0/deps/
rm -rf jemalloc
git clone https://github.com/jemalloc/jemalloc.git
cd jemalloc
./autogen.sh
cd ..
make jemalloc
cd ..
make
cd ..
cd ll-redis-3.0/deps/
rm -rf jemalloc
git clone https://github.com/jemalloc/jemalloc.git
cd jemalloc
./autogen.sh
cd ..
make jemalloc
cd ..
make
cd ..
cd mk-redis-3.0/deps/
rm -rf jemalloc
git clone https://github.com/jemalloc/jemalloc.git
cd jemalloc
./autogen.sh
cd ..
make jemalloc
cd ..
make
cd ..
cd zz-redis-3.0/deps/
rm -rf jemalloc
git clone https://github.com/jemalloc/jemalloc.git
cd jemalloc
./autogen.sh
cd ..
make jemalloc
cd ..
make
cd ..
