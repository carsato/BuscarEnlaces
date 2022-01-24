#!/bin/bash


#$1 url

url_in=$1

if [ "$#" -ne 1 ]
then
	url_check=`./siguiente-url-fetch.sh`
else
	url_check=$url_in
fi

#clean url
clean_url=`./clean_url.sh $url_check`
url_check=$clean_url

printf "$url_check\n"
nombre=`echo "$url_check" | sed -e 's#/#_#g' | sed -e 's#:#_#g' | sed -e 's#&#_#g' | sed -e 's#=#_#g'`


if [ ! -f "tmp/$nombre" ]
then
	lynx -connect_timeout 3 -dump $url_check  | grep -i http | cut -d" " -f 4 | grep -i http | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 > tmp/$nombre
fi

echo $url_check >> db/fetched.lst
