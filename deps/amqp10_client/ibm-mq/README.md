# Build docker image 

It downloads artifacts from https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv. 

For ubuntu x86, run this command:
```
docker build -t "ibm-mq" --build-arg ARCH=UbuntuLinuxX64 .
```

For ubuntu ARM, run this command:
```
docker build -t "ibm-mq" --build-arg ARCH=UbuntuLinuxARM .
```


# Run docker image 

 docker run -d ibm-mq

# Display queues 

docker exec -it ibm-mq 

    display channel(*)
    display channel(SYSTEM.DEF.AMQP)
    ALTER CHANNEL(SYSTEM.DEF.AMQP) CHLTYPE(AMQP) MCAUSER(123)


setmqaut -m QMNAME -t qmgr -p 123 -all +connect