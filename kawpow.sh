#!/bin/bash
# we wrap the call to kawpowminer in a while loop in case it exits on a CUDA error
while [ true ]; do kawpowminer --exit --cuda --pool stratum+tcp://$WALLET.worker@$POOL:$PORT; done