
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
sleep 2
echo 开始检测内存占用,请运行244上的YCSB
PID1=$(pidof redis-server)
LAST_MEM_INFO=""
LAST_CHILD_MEM_INFO=""
while PID=$(pidof redis-server)
do
	PID1=$(echo $PID | awk '{print $1}')
	PID2=$(echo $PID | awk '{print $2}')
	MEM_INFO=$(cat /proc/$PID1/statm | awk '{print $1}')
	if [ "$MEM_INFO" != "$LAST_MEM_INFO" ]	
	then
		echo --------------------
		echo time-ns: $(date +%s%N)
		echo main: $(cat /proc/$PID1/statm)
	fi
	if [ $PID2 ] 
	then
		CHILD_MEM_INFO=$(cat /proc/$PID2/statm | awk '{print $1}')
		if [ "$CHILD_MEM_INFO" == "$LAST_CHILD_MEM_INFO" ]
		then
			echo --------------------
			echo time-ns: $(date +%s%N)
			echo child: $(cat /proc/$PID2/statm)
		fi
	fi
	LAST_MEM_INFO=$MEM_INFO
	LAST_CHILD_MEM_INFO=$CHILD_MEM_INFO
	sleep 0.3 
done
echo $TYPE test finish
