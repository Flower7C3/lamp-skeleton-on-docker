# Usage

## Create containers

1. Clone this repo to *~/www/* direcoty.
2. Instead command `docker-compose` use *docker-compose-prepare.sh* with proper arguments, eg.: `./bin/docker-compose-prepare.sh up -d`


## Configure project domains

Just create and edit *./domains/_hosts.list* file. See *./domains/_hosts.list.dist* file for example or *./tools/symlinks.sh* script.


## Create domains

On _proxy_ container run *symlinks.sh* script: `docker exec -t proxy sh -c "exec /var/www/tools/symlinks.sh"`



---

# Docker config review

## Network

Network _webserver_ with gatweway _192.168.33.254_


## Containers

Available containers:
* proxy - nginx proxy host with exposed port *80* to [localhost](http://127.0.0.1:80), docker ip *192.168.33.254*
* mysql55 - mySQL server with exposed port *3306* to localhost, docker ip *192.168.33.155*
* php55 - Apache server with PHP 5.5.x available on localhost via proxy, docker ip: *192.168.33.55*
* php56 - Apache server with PHP 5.6.x available on localhost via proxy, docker ip: *192.168.33.56*
* php70 - Apache server with PHP 7.0.x available on localhost via proxy, docker ip: *192.168.33.70*
* node4 - Apache server with node 4 with exposed to port *9004* to [localhost](http://127.0.0.1:9004), docker ip *192.168.33.104*
* node5 - Apache server with node 4 with exposed to port *9005* to [localhost](http://127.0.0.1:9005), docker ip *192.168.33.105*

# Connection

1. Master domain in *~/www/domains/default/* with address [127.0.0.1](http://127.0.0.1)
2. Other as *~/www/domains/\*.127.0.0.1.xip.io/* with address as symlink name, eg. [test.php55.127.0.0.1.xip.io](http://test.php55.127.0.0.1.xip.io)
3. mySQL on *127.0.0.1:3306*

---
