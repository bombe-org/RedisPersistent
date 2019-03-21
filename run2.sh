
TYPE=$1
if [ -z "$TYPE" ];
then
	echo input error:请输入以下参数 : pp zz ll cou mk
	exit 1
fi

if [  "$TYPE" != "pp"  -a  "$TYPE" != "zz"  -a "$TYPE" != "ll" -a "$TYPE" != "cou" -a "$TYPE" != "mk" ];
then
	echo input error:$TYPE 
	exit 1
fi
echo start $TYPE test
echo 杀死所有名为redis-server的进程
killall -9 redis-server

cd ./$TYPE-redis-3.0/
echo 删除rdb文件
rm *.rdb
echo 后台运行redis-server，保准输出重定向到log文件中
./src/redis-server ../redis.conf 1>log &
cd ../
