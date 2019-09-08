#!/bin/bash

# Get the name of the stage.
task_name=${PWD##*/}

# Determine where we keep iptables
if $IS_ARCH; then
	iptables_conf_loc="/etc/iptables/iptables.rules"
else
	iptables_conf_loc="/etc/sysconfig/iptables.rules"
fi

# SSH rule that will go into iptables using template system.
export iptable_ssh_rules="
# ALLOW SSH
-A INPUT -p tcp --dport 22 -m hashlimit --hashlimit-name ssh_limit_table --hashlimit 3/second --hashlimit-burst 3/second --hashlimit-mode srcip --hashlimit-htable-size 32768 --hashlimit-htable-max 32768 --hashlimit-htable-expire 60000 -j ACCEPT
-A INPUT -p tcp --dport 22 -j DROP
#-A INPUT -p tcp --dport 22 -j ACCEPT
-A OUTPUT -p tcp --sport 22 -j ACCEPT
"

export iptable_ssh_rules_regexp="\-A\sINPUT\s\-p\stcp\s\-\-dport\s22"

# PING rule that will go into iptables using template system.
export iptable_ping_rules="
# ALLOW PING
-A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
-A OUTPUT -p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT
"

export iptable_ping_rules_regexp="\-A\sINPUT\s-p\sicmp\s\-\-icmp\-type\s"
