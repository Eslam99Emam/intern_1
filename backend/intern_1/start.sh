#!/bin/bash
pwd
tree -L 3
python --version
which python
which pip
python manage.py makemigrations
python manage.py migrate
gunicorn backend.intern_1.wsgi:application --bind 0.0.0.0:$PORT