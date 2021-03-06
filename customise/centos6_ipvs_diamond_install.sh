#!/bin/bash

pip install diamond

#sed -i "s/^nameserver\ .*/nameserver 114.114.114.114/g" /etc/resolv.conf
mkdir -p /usr/share/diamond/collectors/hpcc_ipvs

wget --no-check-certificate -O  /usr/share/diamond/collectors/hpcc_ipvs/hpcc_ipvs.py https://raw.githubusercontent.com/silegon/Diamond/master/src/collectors/hpcc_ipvs/hpcc_ipvs.py

rm -rf /etc/diamond/handlers/*
rm -rf /etc/diamond/collectors/*

wget --no-check-certificate -O  /etc/diamond/handlers/GraphitePickleHandler.conf https://raw.githubusercontent.com/silegon/Diamond/master/customise/GraphitePickleHandler.conf

wget --no-check-certificate -O  /etc/diamond/collectors/HPCCIPVSCollector.conf https://raw.githubusercontent.com/silegon/Diamond/master/customise/HPCCIPVSCollector.conf

wget --no-check-certificate -O  /etc/diamond/diamond.conf.bak https://raw.githubusercontent.com/silegon/Diamond/master/customise/diamond.conf.bak

sed "s/__hostname__/`hostname`/g" /etc/diamond/diamond.conf.bak > /etc/diamond/diamond.conf

ntpdate cn.pool.ntp.org

service diamond restart

sed -i "s/^nameserver\ .*/nameserver 127.0.0.1/g" /etc/resolv.conf
