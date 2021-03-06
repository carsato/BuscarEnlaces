#!/bin/bash


#añadir la url que se pasa a los fetched para excluirla
if [ "$#" -eq 1 ]
then
	echo $1 >> db/fetched.lst
fi


cat tmp/* | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 | sed -e 's#"with##g' | sed -e 's#"##g' | sed -e 's#\[.*\]##g' > db/pendientes.lst
cat db/pendientes.lst db/fetched.lst | sort | uniq -c | grep '^      1 ' | cut -d" " -f 8 	> db/pendientes.tmp
cat db/pendientes.tmp | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 > db/pendientes.lst

head -n 1 db/pendientes.lst

