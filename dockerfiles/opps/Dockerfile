from debian

maintainer guilhermebr

run apt-get update
run apt-get install -y build-essential openssh-server
run apt-get install -y python python-dev python-setuptools
run easy_install pip

add ./opps/example/ /var/www/example
#add ./siteglobal/ /var/www/siteglobal

#RUN chown -R web:web /var/www

#USER web

WORKDIR /var/www/example

#run python /var/www/setup.py develop


###Install and Run Siteglobal
# cd /var/www/siteglobal/
# python manage.py syncdb --no-input
# python manage.py migrate
# python manage.py runserver 0.0.0.0:8000 &


###Install and Run Example
cd /var/www/example/
python manage.py syncdb --no-input
python manage.py migrate
python manage.py runserver 0.0.0.0:8000


expose 8000
#expose 8001
