from django.db import models
from utils.models import Subject as Sub, Grade as Gr

class Assessment(models.Model):
    AssessmentID = models.AutoField(primary_key=True)

    Title = models.CharField(max_length=200)
    Duration = models.DurationField()
    Subject = models.CharField(max_length=20, choices=Sub.choices)
    Grade = models.CharField(max_length=20, choices=Gr.choices)

    def __str__(self):
        return f"{self.AssessmentID}. {self.Title}"

class Question(models.Model):
    QuestionID = models.AutoField(primary_key=True)
    AssessmentFk = models.ForeignKey(Assessment, on_delete=models.CASCADE)
    Question = models.CharField(max_length=200)

    def __str__(self):
        return f"{self.QuestionID}. {self.Question}"

class Option(models.Model):
    OptionID = models.AutoField(primary_key=True)
    QuestionFk = models.ForeignKey(Question, on_delete=models.CASCADE)
    Option = models.CharField()
    isCorrect = models.BooleanField()

    def __str__(self):
        return f"{self.OptionID}. {self.Option}"