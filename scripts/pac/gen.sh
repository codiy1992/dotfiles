#!/bin/bash

LOCAL_IP=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'`
genpac --pac-proxy="HTTP ${LOCAL_IP}:7890; HTTPS ${LOCAL_IP}:7890; SOCKS5 ${LOCAL_IP}:7891; DIRECT" \
    --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt" \
    --output proxy.pac
