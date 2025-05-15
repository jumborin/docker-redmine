# docker-redmine for Windows
docker-compose settings for docker-redmine

## Instruction
    $ git clone https://github.com/jumborin/docker-redmine.git
    $ cd docker-redmine
    $ cp .env.example .env
    $ docker-compose build
    $ docker-compose up -d

## System Configuration
* Redmine Container
  * Base OS：Debian GNU/Linux 12 (bookworm)
  * Redmine：6.0.5
  * MySQL：8.0.39
* MySQL Container
  * Base OS：Ubuntu 24.04 LTS
  * MySQL：8.0.41
  
## Reference
* sameersbn/docker-redmine(github)
  https://github.com/sameersbn/docker-redmine
* sameersbn/docker-redmine(dockerhub)
  https://hub.docker.com/r/sameersbn/redmine
* sameersbn/docker-mysql(github)
  https://github.com/sameersbn/docker-mysql
* Ubuntu(dockerhub)
  https://hub.docker.com/_/ubuntu
* ogis-ito/docker-redmine(github)
  https://github.com/ogis-ito/docker-redmine
* MySQL Download Site
  https://dev.mysql.com/downloads/mysql/

## Reference(For Windows)
* standard_init_linux.go:211: exec user process caused "no such file or directory" の直し方
  https://qiita.com/kabik/items/5591f62c0ef6ddef5db2