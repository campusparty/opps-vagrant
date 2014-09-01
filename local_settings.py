import os
import djcelery

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': os.environ['POSTGRES_DB_NAME'],
        'USER': 'postgres',
        'PASSWORD': '',
        'HOST': os.environ['POSTGRES_PORT_5432_TCP_ADDR'],
        'PORT': '',
    }
}

REDIS_URL = 'redis://' + os.environ['REDIS_PORT_6379_TCP_ADDR'] + ':6379/0'

djcelery.setup_loader()
BROKER_URL = REDIS_URL
CELERY_RESULT_BACKEND = REDIS_URL