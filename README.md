Opps Vagrant
================

This repository contains Vagrantfile to run a virtualbox with all needs to opps developer.

 - Postgres database will run in docker container
 - Redis will run in docker container
 - A Opps image is created to be a base for opps projects
 - All steps to run opps containers are in Vagrantfile, you can run $containers steps in your host machine without vagrant.


How to Run Vagrant:

	$ git clone https://github.com/campusparty/opps-vagrant
	$ cd opps-vagrant
	$ vagrant up

	* Access browser in 127.0.0.1:8000 to see opps/example running.
	* To access admin:  http://127.0.0.1:8000/admin (User: admin, Pass: pass123)
	* Password is set in run.sh script


To create and run container for a project:

 	$ vagrant up
	$ vagrant ssh
	$ docker stop opps_example
	$ cd /app
	$ ./opps/opps/bin/opps-admin.py startproject myproject
	$ docker build -t myproject .
	$ docker run -it --link opps_postgres:postgres --rm postgres sh -c 'createdb -h $POSTGRES_PORT_5432_TCP_ADDR -p 5432 -U postgres myproject'
	$ docker run -d -p 8000:8000 --link opps_postgres:postgres --link opps_redis:redis --name opps_myproject -e POSTGRES_DB_NAME=myproject myproject

