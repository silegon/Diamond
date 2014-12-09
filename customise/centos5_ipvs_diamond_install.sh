#!/bin/bash

rpm -i http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
rpm -i http://dl.iuscommunity.org/pub/ius/stable/Redhat/5/x86_64/ius-release-1.0-13.ius.el5.noarch.rpm
yum install -y  python27 python27-pip python27-psutil
pip install diamond

mkdir -p /usr/share/diamond/collectors/hpcc_ipvs

wget --no-check-certificate -O  /usr/share/diamond/collectors/hpcc_ipvs/hpcc_ipvs.py https://raw.githubusercontent.com/silegon/Diamond/master/src/collectors/hpcc_ipvs/hpcc_ipvs.py

rm -rf /etc/diamond/handlers/*
rm -rf /etc/diamond/collectors/*

wget --no-check-certificate -O  /etc/diamond/handlers/GraphitePickleHandler.conf https://raw.githubusercontent.com/silegon/Diamond/master/customise/GraphitePickleHandler.conf

wget --no-check-certificate -O  /etc/diamond/collectors/HPCCIPVSCollector.conf https://raw.githubusercontent.com/silegon/Diamond/master/customise/HPCCIPVSCollector.conf

wget --no-check-certificate -O  /etc/diamond/diamond.conf.bak https://raw.githubusercontent.com/silegon/Diamond/master/customise/diamond.conf.bak
sed "s/__hostname__/`hostname`/g" /etc/diamond/diamond.conf.bak > /etc/diamond/diamond.conf

service diamond restart
