#!/bin/bash


#$1 url

url_in=$1

if [ "$#" -ne 1 ]
then
	url_check=`./siguiente-url.sh`
else
	url_check=$url_in
fi

#clean url
clean_url=`./clean_url.sh $url_check`
url_check=$clean_url


printf "$url_check "
nombre=`echo "$url_check" | sed -e 's#/#_#g' | sed -e 's#:#_#g' | sed -e 's#&#_#g' | sed -e 's#=#_#g'`


if [ ! -f "tmp/$nombre" ]
then
	lynx -connect_timeout 3 -dump $url_check  | grep -i http | cut -d" " -f 4 | grep -i http | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 > tmp/$nombre
fi


for url in `cat tmp/$nombre`
do
	printf "."
done
printf "\n"

printf "$url_check "
for url in `cat tmp/$nombre`
do
	clean_url=`./clean_url.sh $url`
	valid=1
	code=`curl -L --connect-timeout 3 --write-out "%{http_code}" --output /dev/null --silent --head --fail "$clean_url"`
	if [ "$code" -eq "404" ]
	then
		echo $clean_url >> db/404.txt
		valid=0
	fi
	if [ "$code" -eq "000" ]
	then
		echo $clean_url >> db/000.txt
		valid=0
	fi

	if [ "$valid" -eq "1" ]
	then
		printf "."
	else
		printf `echo $code | cut -c 1`
		echo "$code $clean_url $url_check" >> log/tmp.log
		echo "$code $clean_url $url_check" >> log/log.log
	fi
done
printf "\n"
echo $url_check >> db/visitados.lst

if [ -f "log/tmp.log" ]
then
	cat log/tmp.log
	rm log/tmp.log
fi
