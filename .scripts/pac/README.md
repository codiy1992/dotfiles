# Proxy Auto-Configuration

* Use [genpac](https://github.com/JinnLynn/genpac) to generate pac file
* Simple Generating Code

```
LOCAL_IP=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'`
genpac --pac-proxy="SOCKS5 ${LOCAL_IP}:7890" \
    --gfwlist-url="https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt" \
    --user-rule-from user_rules.txt \
    -o proxy.pac
```

* Usage: `https://raw.githubusercontent.com/codiy1992/dotfiles/master/.scripts/pac/proxy.pac`
* Short Url `https://git.io/JiOLU`

