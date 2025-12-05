#!/bin/bash
pwd
source venv/Scripts/activate
python manage.py makemigrations
python manage.py migrate
python manage.py runserver