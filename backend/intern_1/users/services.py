from django.contrib.auth.hashers import make_password, check_password
from django.db import IntegrityError
from django.forms import ValidationError

from utils.exceptions import *
from .exceptions import *
from .models import *
from .serializers import *

class UserService:
    @staticmethod
    def signup(data):
        try:
            print(data)
            return User.objects.create(
                name=data['name'],
                email=data['email'],
                hashed_password=make_password(data['password']),
                phone=data['phone'],
                role=data['role'],
                grade=data['grade'],
            )
        except IntegrityError:
            raise EmailConflictError("Email already exists")
        except Exception:
            raise DBError("Couldn't create user")

    @staticmethod
    def login(email, password):
        try:
            user = User.objects.get(email=email)
            return user
        except:
            raise InvalidCredentials("Invalid credentials")

    @staticmethod
    def verify_token(id):
        try:
            user = User.objects.get(id=id)
            return id
        except:
            raise InvalidToken("Invalid or expired token")

    @staticmethod
    def get_profile(id):
        try:
            user = User.objects.get(id=id)
            return {
                'name': user.name,
                'email': user.email,
                'grade': user.grade,
            }
        except:
            raise InvalidToken("Invalid or expired token")
