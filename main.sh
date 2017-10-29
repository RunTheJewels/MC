#!/bin/bash

count=2000
procs=4

c_on_p=$(echo "$count/$procs" | bc)

touch .args

for i in $(seq $procs); do
	echo $c_on_p >> .args
done

if [ -z $1 ]
	then
		res=$(parallel -a .args ./mc.sh)
	else
		scp mc.sh $1:~/
		res=$(parallel -a .args -S $1 ~/mc.sh)
fi

final=$(echo "scale=10; (" $(echo $res | tr ' ' '+') ") / $procs" | bc)

rm .args

echo $final
