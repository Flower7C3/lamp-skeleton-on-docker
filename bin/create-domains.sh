#!/usr/bin/env bash

cd `dirname ${BASH_SOURCE}`
cd ../domains/

projectsDir='../projects/'
domainsFile='_hosts.list'
proxyLocal='127.0.0.1.xip.io'
proxyIP=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
proxyShared=$proxyIP'.xip.io'

echo "Cleanup ${proxyLocal}"
find *${proxyLocal} -maxdepth 1  -type l -delete

echo "Cleanup ${proxyShared}"
find *${proxyShared} -maxdepth 1  -type l -delete

echo "Proxy default"
ln -sf default ${proxyIP}
ln -sf default ${proxyShared}

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
		git=${row[git]}

		projectDirPath=${projectsDir}${row[dir]}

   		echo "- ${domain} @ ${container} via ${proxyLocal}"
		domainLocal=${domain}'.'${tld}'.'${container}'.'${proxyLocal}
		ln -sf ${projectDirPath} ${domainLocal}

		if [[ "${row[shared]}" == "true" ]]; then
	   		echo "- ${domain} @ ${container} via ${proxyShared}"
			domainShared=${domain}'.'${tld}'.'${container}'.'${proxyShared}
			ln -sf ${projectDirPath} ${domainShared}
		fi

	fi
done;
