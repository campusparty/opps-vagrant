FROM opps

maintainer Guilherme Rezende <guilhermebr@gmail.com>

ADD . /var/www

WORKDIR /var/www

###Install and Run Example
RUN python manage.py syncdb --noinput
RUN python manage.py migrate --noinput
RUN python manage.py collectstatic --noinput

EXPOSE 8000

CMD (python manage.py runserver 0.0.0.0:8000)
