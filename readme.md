### 1、nginx   

```sh
docker pull nginx
```

```sh
docker run -p 80:80 -d --name nginx -v ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf -v ./docker/nginx/www:/docker/www  --privileged=true nginx
```

### 2、php

```sh
docker pull php:8.2-fpm
```

```sh
docker run -it -p 9000:9000 -d --name php -v ./docker/nginx/www:/docker/www -v ./docker/php/php.ini:/usr/local/etc/php/php.ini --privileged=true php:8.2-fpm
```

```sh
docker inspect php | grep "IPAddress"
```

### 3、mysql

```sh
docker pull mysql
```

```sh
docker run -p 3306:3306 -d --name mysql -v ./docker/etc/my.cnf:/etc/mysql/my.cnf --privileged=true -e MYSQL_ROOT_PASSWORD=root mysql
```

-p 3306:3306 :将容器的3306端口映射到主机的3306端口   
-d 后台运行(守护进程)   
--name mysql：将容器命名为mysql   
-v 将主机中的mysql配置挂载到容器的/etc/mysql/my.cnf   

#### 设置mysql连接权限
create user `starsky`@`%` identified by "root";   
grant all on *.* to `starsky`@`%` with grant option;   
