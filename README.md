# LOG8430E_TP3
The repository contains all the data used for the LOG8430E TP3.

It also contains a script heavily inspired by the following repository:

https://github.com/markbekhet/DB-TP3-LOG8430E/tree/main

The modifications made are nevertheless significant since this script did not take memory and CPU usage into consideration.

# Hyperledger caliper setup
To setup the Hyperladger caliper from scratch execute the following commands
- ```chmod +x start_caliper.sh```
- ```sh start_caliper.sh```

Replace the file at ```caliper-benchmarks/benchmarks/samples/fabric/marbles/config.yaml``` through the ```config.yaml``` file provided in the root of this repository.
For the different workloads modify the txNumber of the query round for modifying the number of reads and the txNumber of the int round for modifying the number of writes.
