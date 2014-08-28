FROM opps

maintainer Guilherme Rezende <guilhermebr@gmail.com>

ADD /app/opps/example/ /var/www

WORKDIR /var/www

###Install and Run Example
RUN python manage.py migrate --noinput
RUN python manage.py collectstatic --noinput

python manage.py runserver 0.0.0.0:8000


EXPOSE 8000

CMD (python manage.py runserver 0.0.0.0:8000)
