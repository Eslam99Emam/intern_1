from django.db import models

class Grade(models.enums.TextChoices):
    G13 = 'G13'
    G14 = 'G14'

class Role(models.enums.TextChoices):
    STUDENT = 'Student'
    ADMIN = 'Admin'

class Subject(models.TextChoices):
    MATH = "Math", "Math"
    ARABIC = "Arabic", "Arabic"
    PHYSICS = "Physics", "Physics"
    ENGLISH = "English", "English"
    FLUTTER = "Flutter", "Flutter"
    DATA_SCIENCE = "Data Science", "Data Science"
