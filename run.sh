#!/bin/bash
#export DJANGO_SETTINGS_MODULE=settings_local

cd /var/www

python manage.py syncdb --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput

echo "[run] create superuser"
echo "from django.contrib.auth.models import User
if not User.objects.filter(username='admin').count():
    User.objects.create_superuser('admin', 'admin@example.com', 'pass123')
" | python manage.py shell

echo "[run] runserver"
python manage.py runserver 0.0.0.0:8000