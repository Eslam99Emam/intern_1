from django.db import models
from utils.models import Subject, Grade
from assessments.models import Assessment
from users.models import User

class AttemptAssessment(models.Model):
    AttemptID = models.AutoField(primary_key=True)
    UserFk = models.ForeignKey(User, on_delete=models.CASCADE)
    AssessmentFk = models.ForeignKey(Assessment, on_delete=models.CASCADE)
    Score = models.IntegerField(default=0)
    TotalScore = models.IntegerField(default=0)
    SubmittedAt = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.UserFk.id}. {self.AssessmentFk.Title}"

class AttemptQuestion(models.Model):
    AttemptQuestionID = models.AutoField(primary_key=True)
    AttemptFk = models.ForeignKey(AttemptAssessment, on_delete=models.CASCADE)
    Question = models.CharField()

    def __str__(self):
        return f"{self.AttemptQuestionID}. {self.Question}"

class AttemptOption(models.Model):
    AttemptOptionID = models.AutoField(primary_key=True)
    AttemptQuestionFk = models.ForeignKey(AttemptQuestion, on_delete=models.CASCADE)
    Option = models.CharField()
    isCorrect = models.BooleanField()
    isChosen = models.BooleanField()

    def __str__(self):
        return f"{self.AttemptOptionID}. {self.Option}"
