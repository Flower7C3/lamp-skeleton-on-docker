# Usage


## Prepare docker containers

1. Clone this repo to *~/www/* directory.
2. Build `docker-compose.yml` file with `./configure.sh` script.
3. Enjoy *docker-compose* in *./* directory.


## Configure project domains

Just create and edit *./domains/_hosts.list* file. See *./domains/_hosts.list.dist* file for example or *./tools/symlinks.sh* script.


## Create domains

On _proxy_ container run *symlinks.sh* script: `docker exec -t proxy sh -c "exec /var/www/tools/symlinks.sh"`



---

# Docker config review


## Network

Network _webserver_ with gatweway _192.168.33.254_


## Containers

Available WWW containers:

* proxy - nginx proxy host with exposed *80* port to *80* port at [127.0.0.1](http://127.0.0.1:80); in docker network server IP is *192.168.33.254*
* php55 - Apache server with PHP 5.5.x available on localhost via proxy container
* php56 - Apache server with PHP 5.6.x available on localhost via proxy container
* php70 - Apache server with PHP 7.0.x available on localhost via proxy container

Available database containers:

* mysql55 - mySQL server with exposed *3306* port to *3306* port at 127.0.0.1; in docker network server IP is *192.168.33.155*
* elastic1 - ElasticSearch version 1 with exposed *9200* port to *9201* port at 127.0.0.1 (stopped by default)

Available node containers:

* node4 - Node 4 and npm with exposed *8080* port to *9004* port at [127.0.0.1](http://127.0.0.1:9004) (stopped by default)
* node5 - Node 5 and npm with exposed *8080* port to *9005* port at [127.0.0.1](http://127.0.0.1:9005) (stopped by default)
* node5 - Node 6 and npm with exposed *8080* port to *9006* port at [127.0.0.1](http://127.0.0.1:9006) (stopped by default)
* yarn - Node 6 and yarn with exposed *8080* port to *9011* port at [127.0.0.1](http://127.0.0.1:9011) (stopped by default)

## Connection

1. Master domain in *~/www/domains/default/* with address [127.0.0.1](http://127.0.0.1)
2. Other as *~/www/domains/\*.127.0.0.1.xip.io/* with address as symlink name, eg. [test.php55.127.0.0.1.xip.io](http://test.php55.127.0.0.1.xip.io)
3. MySQL on *127.0.0.1:3306*

---
