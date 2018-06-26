# Overview

Thanks to [OpenXDAGPool](https://github.com/kbs1/openxdagpool)

# Get Started

Please make sure the `docker` & `docker-compose` are ready on your machine. 

> Docker CE 17.xx is recommended.

```
$ docker --version
Docker version 17.09.0-ce, build afdb6d4
```

```
$ docker-compose --version
docker-compose version 1.16.1, build 6d1ac21
```

## First Time

> If it's the first time that you get the xdag, you need to migrate artisan database.

* 1.startup by docker-compose

```
docker-compose up -d
```

* 2.do artisan migrate

```
docker exec -it xdag-pool bash
php artisan migrate
```

* 3.shutdown 

```
docker-compose stop
```

## Normally

> no need to do artisan migrate again

* startup by docker-compose

```
docker-compose up -d
```

* shutdown 

```
docker-compose stop
```



# RoadMap

> Something wrong with the OpenXDAGPool's website RoadMap. So please visit it refer to the below table.

URL | description
---|---
http://127.0.0.1/index.php | home page
http://127.0.0.1/index.php/login | login
http://127.0.0.1/index.php/register | register ( setup the admin at the first time)
 
# Upgrade 
 
Here is the way to make an upgrade.

* shutdown the server
* pull the latest images
* startup the server 
 
> Please make sure you run the commands under the project root path. 
 
```
docker-compose down
docker-compose pull
docker-compose up -d
``` 

# Database
 
> Now we don't support to customize the db name ,db user, db pwd in current release.

Here is the default username & password

key | value
---|---
DB_DATABASE | xdag
DB_USERNAME | xdagmgr
DB_PASSWORD | Xdag@2018


# Backup

By default the MYSQL db is stored under `${USER_HOME}/var/xdag/mysql`.
You can customize the volumes mapping in docker-compose.yml as follow.

```
  xdag-mysql:
    container_name: xdag-mysql
    image: mariadb:10.3.7
    ports:
      - "3306:3306"
    volumes:
      - ~/var/xdag/mysql:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_USER: ${DB_USERNAME}
      MYSQL_PASSWORD: ${DB_PASSWORD}
```