#!/bin/bash


#añadir la url que se pasa a los visitados para excluirla
if [ "$#" -eq 1 ]
then
	echo $1 >> db/visitados.lst
fi

#sort visitados
cat db/visitados.lst | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 | sed -e 's#"with##g' | sed -e 's#"##g' | sed -e 's#\[.*\]##g' > db/visitados.tmp
rm db/visitados.lst
mv db/visitados.tmp db/visitados.lst

#sort pendientes
cat tmp/* | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 | sed -e 's#"with##g' | sed -e 's#"##g' | sed -e 's#\[.*\]##g' > db/pendientes.tmp
mv db/pendientes.tmp db/pendientes.lst


#filter #get only non visited
cat db/pendientes.lst db/visitados.lst | sort | uniq -c | grep '^      1 ' | cut -d" " -f 8 	> db/pendientes.tmp
cat db/pendientes.tmp | sort | uniq | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f 2 > db/pendientes.lst
if [ -f "db/pendientes.tmp" ]
then
	rm db/pendientes.tmp
fi

head -n 1 db/pendientes.lst
