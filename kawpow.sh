#!/bin/bash
# we wrap the call to kawpowminer in a while loop in case it exits on a CUDA error
while [ true ]; 
    do 
        kawpowminer --exit --cuda --pool $SCHEME://$WALLET.$RIGNAME@$POOL:$PORT; 
        echo "Miner stopped, restarting in 1 second..."
        sleep 1
    done