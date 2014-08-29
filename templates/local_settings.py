import dj_database_url
DATABASES = {
    'default': dj_database_url.config(
        default='sqlite:////{0}/myblog.sqlite'.format(BASE_DIR)
    )
}