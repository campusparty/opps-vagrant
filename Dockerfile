FROM opps

maintainer Guilherme Rezende <guilhermebr@gmail.com>

# ADD your project created by opps-admin.py startproject example

ADD example /var/www
ADD local_settings.py /var/www/example/

WORKDIR /var/www

EXPOSE 8000


ADD run.sh /root/
RUN chmod +x /root/run.sh

CMD /root/run.sh

#CMD (python manage.py runserver 0.0.0.0:8000)
