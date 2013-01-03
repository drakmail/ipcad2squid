#!/bin/sh
echo '' > output.txt
net="192.168.0"
ttime=`cat input1.txt | grep 'Accounting data saved'|awk '{print ($4)}'`
# netkit-rsh localhost clear ip accounting
cat input2.txt | grep $net | awk -v vtime=$ttime '{print ($2,"TCP_MISS/200",$4,"CONNECT",$1":"$5,"-","DIRECT/"$2,"-")}' | grep ^$net | sed 's/^/'$ttime'.000 1 /' >> output.txt
