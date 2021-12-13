#!/bin/bash
#
find /proc/sys/net/ -iname forwarding | while read i ; do echo "1" > ${i} ; done