#!/bin/sh
# Note: I've written this using sh so it works in the busybox container too

# USE the trap if you need to also do manual cleanup after the service is stopped,
#     or need to start multiple services in the one container

# start service in background here
/var/MQServer/bin/strmqm QM1
/var/MQServer/bin/dspmq -m QM1
tail -f /dev/null