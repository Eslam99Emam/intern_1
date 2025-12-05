from itertools import count
from assessments.models import Assessment
from attempts.models import AttemptAssessment, AttemptOption, AttemptQuestion
from django.db.models.functions import TruncMonth
from django.db.models import Count, Avg, F, FloatField
from django.utils import timezone
from datetime import timedelta

class AttemptService:
    @staticmethod
    def save_attempt(user_id, data):
        output = []

        attempt = AttemptAssessment.objects.create(UserFk_id=user_id, AssessmentFk_id=data["AssessmentID"], TotalScore=data["Total Score"], Score=data["Score"])
        output.append(attempt)
        for question in data["Questions"]:
            attempt_question = AttemptQuestion.objects.create(AttemptFk_id=attempt.AttemptID, Question=question["Question"])
            output.append(question)
            for option in question["Options"]:
                AttemptOption.objects.create(AttemptQuestionFk_id=attempt_question.AttemptQuestionID, Option=option["Option"], isCorrect=option["isCorrect"], isChosen=option["isChosen"])
                output.append(option)
        return output

    @staticmethod
    def get_attempts(user_id):
        return AttemptAssessment.objects.filter(UserFk_id=user_id)

    @staticmethod
    def get_attempts_per_month(user_id):
        six_months_ago = timezone.now() - timedelta(days=180)

        qs = (
            AttemptAssessment.objects
            .filter(UserFk_id=user_id, SubmittedAt__gte=six_months_ago)
            .annotate(month=TruncMonth("SubmittedAt"), percentage=100.0 * F("Score") / F("TotalScore"))
            .values("month")
            .annotate(avg_percentage=Avg("percentage", output_field=FloatField()))
            .order_by("month")
        )

        return qs

    @staticmethod
    def get_attempts_per_Subject(user_id):
        # six_months_ago = timezone.now() - timedelta(days=180)
        qs = (
            AttemptAssessment.objects
            .filter(UserFk_id=user_id, TotalScore__gt=0)
            .annotate(
                percentage=100.0 * F("Score") / F("TotalScore"),
                subject=F("AssessmentFk__Subject")
            )
            .values("subject")
            .annotate(avg_percentage=Avg("percentage", output_field=FloatField()), count=Count("AssessmentFk__Subject"))
            .order_by("subject")
        )

        return qs
