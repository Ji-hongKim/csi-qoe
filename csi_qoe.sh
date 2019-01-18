#!/bin/bash
#filename="site_list.txt"
filename=""
framerate=30
iter=20

url_list=()
host_list=()
url_file=($(cat $filename | \
while read line
do
	echo $line
done))

for ((i=0; i<${#url_file[@]}; i++)); do
	item=${url_file[$i]}
	proto="$(echo $item | grep :// | sed -e's,^\(.*://\).*,\1,g')"
	url="$(echo $item | sed -e s,$proto,,g)"
	host="$(echo $url | grep / | cut -d/ -f1)"
	url_one="http://"$host"/"
	url_list+=("$url_one")
	host_list+=("$host")
done

# Test each URL one by one
for ((i=0; i<${#url_list[@]}; i++))
do
	for ((j=0; j<$iter; j++))
	do
		url=${url_list[$i]}
		host=${host_list[$i]}
		output=$host
		echo -e $j": ***" $url ">>>" $output "***"
		sudo ./csi_parser res.bin res.csv 0 & export pid=$!

	#	datapath=$(sudo docker run --shm-size=1g --rm -v "$(pwd)":/browsertime sitespeedio/browsertime \
	#	--videoRaw --videoParams.framerate=$framerate --speedIndex -b chrome -n $iter \
	#    --cacheClearRaw true --viewPort=1366x768 --chrome.collectPerfLog false \
	#    -o $output --skipHar true \
	#	$url | grep "Wrote data to" | sed 's#\[.*Wrote data to ##')

		datapath=$(sudo docker run --shm-size=1g --rm -v "$(pwd)":/browsertime sitespeedio/browsertime \
		--speedIndex -b chrome --video false \
	    --cacheClearRaw true --viewPort=1366x768 --chrome.collectPerfLog false \
	 	-o $output --skipHar true \
		$url | grep "Wrote data to" | sed 's#\[.*Wrote data to ##')
		echo $datapath
		sudo kill -2 $pid
		sudo mv $(pwd)"/"res.csv $(pwd)"/"$datapath
		sudo rm $(pwd)"/"res.bin
done
done
