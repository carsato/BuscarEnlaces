#!/bin/bash

url=$1
clean_url=`
echo $url | 
	sed -e 's#"with##g' | 
	sed -e 's#"##g' | 
	sed -e 's#"with##g' | 
	sed -e 's#"##g' | 
	sed -e 's#\[.*\]##g' | 
	sed -e 's#(.*)##g' | 
	sed -e 's#\[##g' | 
	sed -e 's#\]##g' | 
	sed -e 's#(##g' | 
	sed -e 's#)##g'
`

printf '%s\n' "$clean_url"
