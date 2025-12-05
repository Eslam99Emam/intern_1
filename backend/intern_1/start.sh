#!/bin/bash
pwd
tree -L 3
python --version
where python
where pip
python manage.py makemigrations
python manage.py migrate
python manage.py runserver