#!/bin/bash

# Remove all rules
ip6tables -t filter -F
ip6tables -t filter -X

# Forbid all traffic
ip6tables -t filter -P INPUT DROP
ip6tables -t filter -P FORWARD DROP
ip6tables -t filter -P OUTPUT DROP

# Allow established connection
ip6tables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
ip6tables -A OUTPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow loopback
ip6tables -t filter -A INPUT -i lo -j ACCEPT
ip6tables -t filter -A OUTPUT -o lo -j ACCEPT

# PSQL
# ip6tables -t filter -A OUTPUT -p tcp --dport 5433 -j ACCEPT

# Allow HTTP
ip6tables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
ip6tables -t filter -A INPUT -p tcp -i ens3 --dport 80 -j ACCEPT

# Allow HTTPS
ip6tables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
ip6tables -t filter -A INPUT -p tcp -i ens3 --dport 443 -j ACCEPT

# Allow SSH
ip6tables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT
ip6tables -t filter -A INPUT -p tcp -i ens3 --dport 22 -j ACCEPT

# Mysql
ip6tables -t filter -A OUTPUT -p tcp --dport 3306 -j ACCEPT
ip6tables -t filter -A INPUT -p tcp -i ens7 --sport 3306 -m state --state ESTABLISHED -j ACCEPT

# Allow FTP
# ip6tables -t filter -A OUTPUT -p tcp --dport 20:21 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 20:21 -j ACCEPT

# Allow SMTP
# ip6tables -t filter -A OUTPUT -p tcp --dport 25 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 25 -j ACCEPT
# ip6tables -t filter -A OUTPUT -p tcp --dport 587 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 587 -j ACCEPT

# Allow POP3
# ip6tables -t filter -A OUTPUT -p tcp --dport 110 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 110 -j ACCEPT

# Allow POPS
# ip6tables -t filter -A OUTPUT -p tcp --dport 995 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 995 -j ACCEPT

# Allow IMAP
# ip6tables -t filter -A OUTPUT -p tcp --dport 143 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 143 -j ACCEPT

# Allow IMAPS
# ip6tables -t filter -A OUTPUT -p tcp --dport 993 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --dport 993 -j ACCEPT

ip6tables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
# ip6tables -t filter -A INPUT -p tcp --sport 53 -j ACCEPT
ip6tables -t filter -A OUTPUT -p udp -o ens3 --dport 53 -j ACCEPT
# ip6tables -t filter -A INPUT -p udp --sport 53 -j ACCEPT

# Allow ICMP (ping)
ip6tables -t filter -A INPUT -p icmp -j ACCEPT
ip6tables -t filter -A OUTPUT -p icmp -j ACCEPT

# NTP (horloge du serveur)
sudo ip6tables -t filter -A OUTPUT -p udp --dport 123 -j ACCEPT

# Prevent Flood or Ddos
ip6tables -A FORWARD -p tcp --syn -m limit --limit 1/second -j ACCEPT
ip6tables -A FORWARD -p udp -m limit --limit 1/second -j ACCEPT
#ip6tables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT

# Limit port scan
ip6tables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

echo "*filter" > /etc/ip6tables.conf
ip6tables -S >> /etc/ip6tables.conf
echo "COMMIT" >> /etc/ip6tables.conf

