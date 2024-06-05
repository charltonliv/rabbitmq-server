https://developer.ibm.com/tutorials/mq-setting-up-amqp-with-mq/

# Build docker image 


# Run docker image 

docker run  --name mq --env LICENSE=accept --env MQ_QMGR_NAME=QM1 --env MQ_APP_PASSWORD=passw0rd --env MQ_ADMIN_PASSWORD=passw0rd --publish 1414:1414 --publish 9443:9443 --publish 5677:5672 --detach ibm-mqadvanced-server-dev:9.3.5.1-arm64  
  
# Display queues 

docker exec -it ibm-mq 

    display channel(*)
    display channel(SYSTEM.DEF.AMQP)
    ALTER CHANNEL(SYSTEM.DEF.AMQP) CHLTYPE(AMQP) MCAUSER(123)


setmqaut -m QMNAME -t qmgr -p 123 -all +connect