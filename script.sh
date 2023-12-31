# script inspired from the following repository:
# https://github.com/markbekhet/DB-TP3-LOG8430E/tree/main

#install Pre-requirements
sudo apt-get install git -y
sudo apt-get install python2 -y
sudo apt-get install python3-virtualenv -y
sudo apt-get install default-jre -y
sudo apt-get install maven -y
sudo apt-get -y install python2-pip-whl
sudo apt-get -y install python2-setuptools-whl

# create virtual environment and activate the virtual environment
virtualenv -p /usr/bin/python2 venv
source venv/bin/activate

# clone the repo for benchmarking
git clone http://github.com/brianfrankcooper/YCSB.git
cd YCSB
mvn -pl site.ycsb:redis-binding -am clean package

cd ..

## Run the container for redis DB and run the tests
printf "\nRunning Benchmarks on redis DB, results can be found in the redis folder \n\n"

# The script does not provide a way to measure in real time the CPU usage. However
# it is instead possible to use the command : docker stats --all
# during the execution of the various workloads.
# Every time that a workload is started, the new instance of Docker will be launch so
# that we can make the memory free again.

cd YCSB
for i in {1..3}
do
printf "\n##################################################################################\n" >> ../redis/outputLoadRedis.csv
printf "Loading data worload 1 try $i \n" >> ../redis/outputLoadRedis.csv 
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb load redis -s -P workloads/workload1 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputLoadRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v


printf "\n##################################################################################\n" >> ../redis/outputRunRedis.csv
printf "Running test workoad 1 try $i\n" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb run redis -s -P workloads/workload1 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v


printf "\n##################################################################################\n" >> ../redis/outputLoadRedis.csv 
printf " Loading data worload 2 try $i \n" >> ../redis/outputLoadRedis.csv
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb load redis -s -P workloads/workload2 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputLoadRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v

printf "\n##################################################################################\n" >> ../redis/outputRunRedis.csv
printf "Running test workoad 2 try $i\n" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb run redis -s -P workloads/workload2 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v

printf "\n##################################################################################\n" >> ../redis/outputLoadRedis.csv 
printf "Loading data worload 3 try $i\n" >> ../redis/outputLoadRedis.csv
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb load redis -s -P workloads/workload3 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputLoadRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v

printf "\n##################################################################################\n" >> ../redis/outputRunRedis.csv
printf "Running test workoad 3 try $i\n" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml up --scale redis-master=1 --scale redis-replica=3 -d
./bin/ycsb run redis -s -P workloads/workload3 -target 1000 -p "redis.host=127.0.0.1" -p "redis.port=6379" -p "redis.clustert=true" >> ../redis/outputRunRedis.csv
docker-compose -f ../redis/docker-compose.yml down -v

done
cd ..

printf "\nFinished benchmarking redis DB \n\n"

