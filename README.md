Opps Vagrant
================

This repository contains Vagrantfile to run a virtualbox with all needs to opps developer.

 - Postgres database will run in docker container
 - A Opps image is created to be a base for opps projects
 - All steps to run opps containers are in Vagrantfile, you can run $containers steps in your host machine without vagrant.


How to Run Vagrant:

	$ git clone https://github.com/campusparty/opps-vagrant
	$ cd opps-vagrant
	$ vagrant up

	* Access browser in 127.0.0.1:8000 to see opps/example running.


To create and run container for a project:

	$ cp /app/templates/Dockerfile $PROJECT_DIR
	$ cp /app/templates/local_settings.py $PROJECT_FOLDER/$PROJECT_APP
	$ docker build -t PROJECT_NAME $PROJECT_DIR
	$ docker run -d -p 8000:8000 --link opps_postgres:db --name project_name $PROJECT_NAME



Example:

	$ vagrant up
	$ vagrant ssh
	$ docker stop opps_example
	$ cd /app
	$ ./opps/opps/bin/opps-admin.py startproject mytest
	$ cp /app/templates/Dockerfile mytest
	$ cp /app/templates/local_settings.py mytest/mytest/
	$ docker build -t opps/mytest mytest/
	$ docker run -d -p 8000:8000 --link opps_postgres:db --name opps_mytest opps/mytest
