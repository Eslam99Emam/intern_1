from django.contrib.auth.hashers import make_password
from rest_framework import serializers
from users.validators import validate_password, validate_email
from . import models

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(validators=[validate_password])

    class Meta:
        model = models.User
        fields = ['id', 'name', 'email', 'phone', 'role', 'grade', 'password']
