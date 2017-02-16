Dockerized XAMP
=========================== 


## 1. Usage


### 1.1. Prepare containers

1. Clone this repo to *~/www/* directory.
2. Write custom configuration in *./docker/_config.local.sh* file.
3. Build *docker-compose.yml* file with `./configure.sh` script (on Windows with GIT bash).
4. Enjoy *docker-compose* in *./* directory.


### 1.2. Configure domains with symlink

> This option works only on Unix (Linux/OS X)

1. Create or edit *./domains/_hosts.list* file. See *./domains/_hosts.list.dist* file for example or *./bin/create-domains.sh* script.
2. Run *create-domains.sh* script on *proxy* container: `docker exec -t proxy sh -c "exec /var/www/bin/create-domains.sh"`


### 1.3. Configure domains without symlink

Just create proper domain directory in *./domains/* directory. See below the domains in **[WWW containers](#www-containers)** section.


### 1.4. Connection

* Some containers has exposed ports to localhost. See below in **[Config review](#2-config-review)** section for more info.
* In applications instead docker container IP use container name as host address.
* You can connect to container command line with docker: `docker exec -ti $CONTAINER_NAME bash`

---



## 2. Config review


### WWW containers

* proxy - nginx proxy host with exposed *80* port to *80* port at 127.0.0.1, it has configured master domain in `./domains/default/web/` with address [127.0.0.1](http://127.0.0.1)
* php55 - Apache server with PHP 5.5.x available on localhost via proxy container (domains __*.php55.127.0.0.1.xip.io__ from `./domains/*.php55.127.0.0.1.xip.io/web/` path)
* php56 - Apache server with PHP 5.6.x available on localhost via proxy container (domains __*.php56.127.0.0.1.xip.io__ from `./domains/*.php56.127.0.0.1.xip.io/web/` path)
* php70 - Apache server with PHP 7.0.x available on localhost via proxy container (domains __*.php70.127.0.0.1.xip.io__ from `./domains/*.php70.127.0.0.1.xip.io/web/` path)

All Apache servers will have 192.168.33.1 IP in `$_SERVER['REMOTE_ADDR']` variable.


### Database containers

* mysql55 - mySQL server with exposed *3306* port to *3306* port and *3355* port at 127.0.0.1
* mysql56 - mySQL server with exposed *3306* port to *3356* port at 127.0.0.1
* elastic1 - ElasticSearch version 1 with exposed *9200* port to *9201* port at 127.0.0.1


### node containers

* node4 - Node 4 and npm with exposed *8080* port to *9004* port at [127.0.0.1](http://127.0.0.1:9004)
* node5 - Node 5 and npm with exposed *8080* port to *9005* port at [127.0.0.1](http://127.0.0.1:9005)
* node6 - Node 6 and npm with exposed *8080* port to *9006* port at [127.0.0.1](http://127.0.0.1:9006)
* yarn - Node 6 and yarn with exposed *8080* port to *9011* port at [127.0.0.1](http://127.0.0.1:9011)

---



## 3. Known errors


3.1. xdebug not works. Check Your IP (command `ifconfig` on host) and compare it to *xdebug.remote_host* PHP env (command `php -i | grep xdebug.remote_host` on docker container). If is not same just rebuild *docker-compose.yml* file with `./configure.sh` script and run `docker-compose up -d`.


---
