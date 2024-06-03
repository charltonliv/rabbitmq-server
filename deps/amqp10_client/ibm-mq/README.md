# Build docker image 

docker build -t "ibm-mq" --build-arg ARCH=ARM64 .

# Run docker image 

 docker run -d ibm-mq

 # Display queues 

 docker exec -it ibm-mq 

 display queue(*)

 