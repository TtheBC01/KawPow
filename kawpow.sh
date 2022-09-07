#!/bin/bash
# we wrap the call to kawpowminer in a while loop in case it exits on a CUDA error
while [ true ]; 
    do 
        kawpowminer --exit --cuda -R --HWMON 2 --pool $SCHEME://$WALLET.$RIGNAME@$POOL:$PORT; 
        echo "Miner stopped, restarting in 1 second..."
        sleep 1
    done