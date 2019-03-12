cd cou-redis-3.0/deps/
rm -rf jemalloc
tar xjvf ../../jemalloc-5.1.0.tar.bz2
mv jemalloc-5.1.0/ jemalloc
make jemalloc
cd ..
make
cd ..
cd ll-redis-3.0/deps/
rm -rf jemalloc
tar xjvf ../../jemalloc-5.1.0.tar.bz2
mv jemalloc-5.1.0/ jemalloc
make jemalloc
cd ..
make
cd ..
cd mk-redis-3.0/deps/
rm -rf jemalloc
tar xjvf ../../jemalloc-5.1.0.tar.bz2
mv jemalloc-5.1.0/ jemalloc
make jemalloc
cd ..
make
cd ..
cd zz-redis-3.0/deps/
rm -rf jemalloc
tar xjvf ../../jemalloc-5.1.0.tar.bz2
mv jemalloc-5.1.0/ jemalloc
make jemalloc
cd ..
make
cd ..
