FROM ubuntu:latest

ARG ARCH

RUN apt-get update \
    && apt-get install -y wget gzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget -c https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/9.3.5.0-IBM-MQ-Advanced-for-Developers-${ARCH}.tar.gz \
    && gunzip 9.3.5.0-IBM-MQ-Advanced-for-Developers-${ARCH}.tar.gz \
    && mkdir /var/MQServer \    
    && tar -xf 9.3.5.0-IBM-MQ-Advanced-for-Developers-${ARCH}.tar -C /var/MQServer 
    
WORKDIR /var/MQServer 

RUN bin/mqlicense -accept

RUN echo "Checking MQ version" \
    && bin/dspmqver 

RUN groupadd mqm 
RUN useradd -g mqm app
RUN /bin/bash -c "source /var/MQServer/bin/setmqenv -s" \
    && bin/crtmqm QM1 \
    && echo "Created Queue Manager ( $? )" 
    
COPY start.sh /var/MQServer/start.sh 
RUN chmod 777 /var/MQServer/start.sh
EXPOSE 1414/tcp 
EXPOSE 5672/tcp 

#ENV MQ_OVERRIDE_DATA_PATH=/mnt/mqm/data MQ_OVERRIDE_INSTALLATION_NAME=Installation1 MQ_USER_NAME="mqm" 
ENTRYPOINT /var/MQServer/start.sh

#RUN wget https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/mqsc/mq-dev-config.mqsc 
    
#RUN cat /var/MQServer/mq-dev-config.mqsc \
#    && bin/runmqsc QM1 < /var/MQServer/mq-dev-config.mqsc

