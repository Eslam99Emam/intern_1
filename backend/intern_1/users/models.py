from django.db import models
from utils.models import Role, Grade
from users.validators import validate_email, validate_phone

# Create your models here.
class User(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    email = models.CharField(unique=True, validators=[validate_email])
    hashed_password = models.CharField(max_length=255)
    phone = models.CharField(max_length=16, validators=[validate_phone])
    role = models.CharField(choices=Role.choices, default=Role.STUDENT)
    grade = models.CharField(choices=Grade.choices, default=Grade.G14)

    def __str__(self):
        return f"{self.id}. {self.name}"