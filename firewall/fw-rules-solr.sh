#!/bin/bash

# Remove all rules
iptables -t filter -F
iptables -t filter -X

# Forbid all traffic
iptables -t filter -P INPUT DROP
iptables -t filter -P FORWARD DROP
iptables -t filter -P OUTPUT DROP

# Allow established connection
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow loopback
iptables -t filter -A INPUT -i lo -j ACCEPT
iptables -t filter -A OUTPUT -o lo -j ACCEPT

# Allow SSH
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -t filter -A INPUT -p tcp -i ens3 --dport 22 -j ACCEPT

# SOLR
iptables -t filter -A OUTPUT -p tcp --dport 8983 -j ACCEPT
iptables -t filter -A INPUT -p tcp -s 10.39.96.4,10.39.96.5 --dport 8983 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 7983 -j ACCEPT
iptables -t filter -A INPUT -p tcp -s 10.39.96.4,10.39.96.5 --dport 7983 -j ACCEPT

# Mysql
iptables -t filter -A OUTPUT -p tcp --dport 3306 -j ACCEPT
iptables -t filter -A INPUT -p tcp -i ens7 --sport 3306 -m state --state ESTABLISHED -j ACCEPT

# https
sudo iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT

#dns
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp -o ens3 --dport 53 -j ACCEPT

# Allow ICMP (ping)
iptables -t filter -A INPUT -p icmp -j ACCEPT
iptables -t filter -A OUTPUT -p icmp -j ACCEPT

# NTP (horloge du serveur)
sudo iptables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

# Prevent Flood or Ddos
iptables -A FORWARD -p tcp --syn -m limit --limit 1/second -j ACCEPT
iptables -A FORWARD -p udp -m limit --limit 1/second -j ACCEPT
iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT

# Limit port scan
iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

echo "*filter" > /etc/iptables.conf
iptables -S >> /etc/iptables.conf
echo "COMMIT" >> /etc/iptables.conf

