
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# DoS Attack on Tomcat Server
---

A DoS (Denial of Service) attack on a Tomcat server occurs when attackers flood the server with an overwhelming amount of traffic, causing the server to become unresponsive and unable to handle legitimate requests. This attack results in service disruptions, making the server unavailable to users. The goal of the DoS attack is to make the targeted service unavailable to its users, causing inconvenience or financial losses to the organization that operates the server.

### Parameters
```shell
export TOMCAT_PORT="PLACEHOLDER"

export NETWORK_INTERFACE="PLACEHOLDER"

export IP_ADDRESS="PLACEHOLDER"

export BLOCK_DURATION_SECONDS="PLACEHOLDER"
```

## Debug

### Check if Tomcat service is running
```shell
systemctl status tomcat
```

### Check if Tomcat is listening on the expected port
```shell
netstat -tulnp | grep ${TOMCAT_PORT}
```

### Check the current active connections to Tomcat
```shell
netstat -ant | grep ${TOMCAT_PORT} | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
```

### Check the server's resource utilization (CPU, memory, disk, network)
```shell
top
```

### Check if there are any firewall rules blocking traffic to Tomcat
```shell
iptables -L -n | grep ${TOMCAT_PORT}
```

### Check the server's network traffic
```shell
tcpdump -i ${NETWORK_INTERFACE} port ${TOMCAT_PORT}
```

### Check if there are any other services consuming too much resources
```shell
ps aux | sort -rk 3,3 | head -n 10
```

## Repair

### Identify the source of the DoS attack and block the IP address or range.
```shell
bash

#!/bin/bash

# Define variables

IP_ADDRESS=${IP_ADDRESS}

BLOCK_DURATION=${BLOCK_DURATION_SECONDS}

# Block IP address

iptables -A INPUT -s $IP_ADDRESS -j DROP

# Unblock IP address after specified duration

(sleep $BLOCK_DURATION && iptables -D INPUT -s $IP_ADDRESS -j DROP) &

```