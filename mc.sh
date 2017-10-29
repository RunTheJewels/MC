#!/bin/bash

n=0
count=$1

f() {
	echo "scale=10; $1^3" | bc
}

counting() {
	export n
	x=$RANDOM
	y=$RANDOM
	x_norm=$(echo "scale=10; ($x/32767.0)" | bc)
	y_norm=$(echo "scale=10; ($y/32767.0)" | bc)
	res_y=$(f $x_norm)
	i=$(echo "scale=10; $res_y >= $y_norm" | bc)
	((n=n+i))
}

# export -f counting
for i in $(seq 1 $count); do counting; done
# ; do echo $n; done | parallel counting
# parallel --jobs 1000 counting
echo "scale=10; $n/$count" | bc
