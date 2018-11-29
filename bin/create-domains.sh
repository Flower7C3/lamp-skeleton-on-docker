#!/usr/bin/env bash

cd `dirname ${BASH_SOURCE}`

projects_dir='../../projects/'
domains_file_path='../config/_hosts.list'
domains_docker_dir='../docker/domains/'
domains_docksal_dir='../docksal/domains/'
proxy_local='127.0.0.1.xip.io'
proxy_docksal=''
proxy_ips=($(ifconfig | grep "inet" | grep -v Bcast:0.0.0.0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'))

echo "Cleanup proxy_local ${proxy_local}"
(cd ${domains_docker_dir} && find *${proxy_local} -maxdepth 1  -type l -delete)

echo "Cleanup proxy_docksal"
(cd ${domains_docksal_dir} && find *${proxy_docksal} -maxdepth 1  -type l -delete)

echo "Cleanup shared proxies"
for proxy_IP in "${proxy_ips[@]}"; do
	proxy_shared=$proxy_IP'.xip.io'
	(cd ${domains_docker_dir} && find *${proxy_shared} -maxdepth 1  -type l -delete)
done

echo "Proxy default"
for proxy_IP in "${proxy_ips[@]}"; do
	proxy_shared="${proxy_IP}.xip.io"
	(cd ${domains_docker_dir} && ln -snf default ${proxy_IP})
	(cd ${domains_docker_dir} && ln -snf default ${proxy_shared})
done

echo "New domains:"
cat ${domains_file_path} |                      
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

		if [[ ! "${row[docker]}" || "${row[docker]}" != "false" ]]; then
	   		echo "- ${domain} @ ${container} via ${proxy_local}"
			domain_local="${domain}.${tld}.${container}.${proxy_local}"
			(cd ${domains_docker_dir} && ln -snf ${project_dir_path} ${domain_local})
		fi

		if [[ "${row[shared]}" == "true" ]]; then
			for proxy_IP in "${proxy_ips[@]}"; do
				proxy_shared=$proxy_IP'.xip.io'
		   		echo "- ${domain} @ ${container} via ${proxy_shared}"
				domain_shared="${domain}.${tld}.${container}.${proxy_shared}"
				(cd ${domains_docker_dir} && ln -snf ${project_dir_path} ${domain_shared})
			done
		fi

		if [[ "${row[docksal]}" == "true" ]]; then
			domain_docksal="${domain}.${tld}"
			domain_docksal="${domain_docksal//\./_}"
			domain_docksal="${domain_docksal//-/_}"
	   		echo "- ${domain_docksal} via Docksal"
			(cd ${domains_docksal_dir} && ln -snf ${project_dir_path} ${domain_docksal})
		fi

	fi
done;
