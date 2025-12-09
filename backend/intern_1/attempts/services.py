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
        attempts = (
            AttemptAssessment.objects
            .filter(UserFk_id=user_id)
            .select_related("AssessmentFk", "UserFk")
        )

        final = []

        # Loop on every attempt
        for attempt in attempts:
            # Load questions + options for this attempt
            attempt_questions = (
                AttemptQuestion.objects
                .filter(AttemptFk=attempt)
                .prefetch_related("attemptoption_set")
            )

            attempt_json = {
                "AttemptID": attempt.AttemptID,
                "AssessmentID": attempt.AssessmentFk.AssessmentID,
                "Title": attempt.AssessmentFk.Title,
                "Score": attempt.Score,
                "Total Score": attempt.TotalScore,
                "SubmittedAt": attempt.SubmittedAt,
                "Questions": [],
            }

            for q in attempt_questions:
                q_options = []
                attempt_json["Questions"].append({
                    "AttemptQuestionID": q.AttemptQuestionID,
                    "Question": q.Question,
                    "Options": q_options
                })

                # Add Options
                for opt in q.attemptoption_set.all():
                    q_options.append({
                        "AttemptOptionID": opt.AttemptOptionID,
                        "Option": opt.Option,
                        "isCorrect": opt.isCorrect,
                        "isChosen": opt.isChosen,
                    })

            final.append(attempt_json)

        return final

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
