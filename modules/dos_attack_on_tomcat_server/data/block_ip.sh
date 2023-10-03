bash

#!/bin/bash

# Define variables

IP_ADDRESS=${IP_ADDRESS}

BLOCK_DURATION=${BLOCK_DURATION_SECONDS}

# Block IP address

iptables -A INPUT -s $IP_ADDRESS -j DROP

# Unblock IP address after specified duration

(sleep $BLOCK_DURATION && iptables -D INPUT -s $IP_ADDRESS -j DROP) &