#!/bin/bash

sudo grep "session opened" /var/log/auth.log | grep -v "CRON" | grep -v miguel
echo ""
sudo netstat -a | grep ssh
echo ""
echo sudo grep "222.186.173.183" /var/log/auth.log

