#!/usr/bin/env bash

cd `dirname ${BASH_SOURCE}`

domains_dir='../domains/'
projects_dir='../projects/'
domains_file='_hosts.list'
proxy_ocal='127.0.0.1.xip.io'
proxy_ips=($(ifconfig | grep "inet" | grep -v Bcast:0.0.0.0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'))

cd $domains_dir
echo "Cleanup ${proxy_ocal}"
find *${proxy_ocal} -maxdepth 1  -type l -delete

echo "Cleanup shared proxies"
for proxy_IP in "${proxy_ips[@]}"; do
	proxy_shared=$proxy_IP'.xip.io'
	find *${proxy_shared} -maxdepth 1  -type l -delete
done

echo "Proxy default"
for proxy_IP in "${proxy_ips[@]}"; do
	proxy_shared=$proxy_IP'.xip.io'
	ln -sf default ${proxy_IP}
	ln -sf default ${proxy_shared}
done

echo "New domains:"
cat $domains_file |                      
while read -r line;
do
	if [[ $line == \(* ]];
	then

   		declare -A row="$line"

   		domain=${row[domain]}
		tld=${row[tld]}
   		container='php'${row[php]}
		git=${row[git]}

		project_dir_path=${projects_dir}${row[dir]}

   		echo "- ${domain} @ ${container} via ${proxy_ocal}"
		domain_local=${domain}'.'${tld}'.'${container}'.'${proxy_ocal}
		ln -sf ${project_dir_path} ${domain_local}

		if [[ "${row[shared]}" == "true" ]]; then
			for proxy_IP in "${proxy_ips[@]}"; do
				proxy_shared=$proxy_IP'.xip.io'
		   		echo "- ${domain} @ ${container} via ${proxy_shared}"
				domain_shared=${domain}'.'${tld}'.'${container}'.'${proxy_shared}
				ln -sf ${project_dir_path} ${domain_shared}
			done
		fi

	fi
done;
