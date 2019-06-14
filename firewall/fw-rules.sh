#!/bin/sh

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

# SOLR
# iptables -t filter -A INPUT -p tcp --src 104.156.245.195 --dport 8983 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 8983 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 8983 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 7983 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 7983 -j ACCEPT

# PSQL
iptables -t filter -A OUTPUT -p tcp --dport 5433 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 5433 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --dport 5432 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 5432 -j ACCEPT

# Allow HTTP
iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow HTTPS
iptables -t filter -A OUTPUT -p tcp --dport 443 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow SSH
iptables -t filter -A OUTPUT -p tcp --dport 22 -j ACCEPT 
iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT

# Mysql
iptables -t filter -A OUTPUT -p tcp --dport 3306 -j ACCEPT
iptables -t filter -A INPUT -p tcp --src 104.156.245.195 --dport 3306 -j ACCEPT  
#iptables -t filter -A INPUT -p tcp --dport 3306 -j DROP

# Allow DNS
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
# iptables -t filter -A INPUT -p tcp --sport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
# iptables -t filter -A INPUT -p udp --sport 53 -j ACCEPT

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

# save rules
echo "*filter" > iptables.conf
sudo iptables -S >> iptables.conf
echo "COMMIT" >> iptables.conf
sudo mv iptables.conf /etc

