FROM ubuntu:latest

ARG ARCH

RUN apt-get update \
    && apt-get install -y wget gzip \
    && rm -rf /var/lib/apt/lists/*

RUN wget -c https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/9.3.5.0-IBM-MQ-Advanced-for-Developers-Non-Install-Linux${ARCH}.tar.gz \
    && gunzip 9.3.5.0-IBM-MQ-Advanced-for-Developers-Non-Install-Linux${ARCH}.tar.gz \
    && mkdir /var/MQServer \    
    && tar -xf 9.3.5.0-IBM-MQ-Advanced-for-Developers-Non-Install-Linux${ARCH}.tar -C /var/MQServer 
    
WORKDIR /var/MQServer 

RUN  bin/mqlicense -accept

RUN echo "Checking MQ version" \
    && bin/dspmqver 

RUN groupadd mqm 
RUN useradd -g mqm app
RUN /bin/bash -c "source /var/MQServer/bin/setmqenv -s" \
    && bin/crtmqm QM1 \
    && bin/strmqm QM1 

RUN wget https://raw.githubusercontent.com/ibm-messaging/mq-dev-samples/master/gettingStarted/mqsc/mq-dev-config.mqsc 
    
RUN cat /var/MQServer/mq-dev-config.mqsc \
    && bin/runmqsc QM1 < /var/MQServer/mq-dev-config.mqsc

