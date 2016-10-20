#!/usr/bin/env bash

cd `dirname $0`

if [[ `pwd` == "${HOME}/www/tools" ]];
then

	echo "Redirect it to run on docker container"
	docker exec -t proxy sh -c "exec /var/www/tools/symlinks.sh"

else

	cd /var/www/

	srcDir='projects/'
	dstDir='domains/'
	domainsFile='/var/www/domains/_hosts.list'
	proxy='127.0.0.1.xip.io'

	(cd ${dstDir} && find *${proxy} -maxdepth 1  -type l -delete)

	echo "New domains:"

	cat $domainsFile |                      
	while read -r line;
	do
		if [[ $line == \(* ]];
		then

	   		declare -A row="$line"

	   		domain=${row[domain]}
			tld=${row[tld]}
	   		container='php'${row[php]}
			dest=${dstDir}${domain}'.'${tld}'.'${container}'.'${proxy}
			git=${row[git]}

	   		directory=${row[dir]}
			src=${srcDir}${directory}

	   		echo "- ${tld}: ${domain} @ ${container}"
	   		if [ ! -d "${src}" ]; then
	   			mkdir -p ${src}
	   			if [[ -n "${git/[ ]*\n/}" ]]; then
					git clone ${git} ${src}
	   			fi
			fi
			ln -srf ${src} ${dest}

		    # HTTPDUSER=`ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`

		    # cacheDir=${d}/app/cache/
		    # if [ -d "$DIRECTORY" ]; then
			   #  #rm -rf ${cacheDir}*
			   #  #chmod 775 ${cacheDir}
			   #  setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX ${cacheDir}
			   #  setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX ${cacheDir}
		    # fi

		    # logsDir=${d}/app/logs/
		    # if [ -d "$DIRECTORY" ]; then
			   #  #rm -rf ${logsDir}*
			   #  #chmod 775 ${logsDir}
			   #  setfacl -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX ${logsDir}
			   #  setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX ${logsDir}
		    # fi

		fi
	done;

fi