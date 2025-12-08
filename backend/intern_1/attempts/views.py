import jwt

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from config import settings
from attempts.services import AttemptService


class PeriodScoresAnalysis(APIView):
    def get(self, request):
        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        attempts = AttemptService.get_attempts_per_month(token["id"])
        data = {row["month"].strftime("%b-%Y"): round(row["avg_percentage"], 1) for row in attempts}
        return Response({"success": True, "message": "Assessment Loaded", "data": data}, status=status.HTTP_200_OK)

class SubjectScoresAnalysis(APIView):
    def get(self, request):

        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        attempts = AttemptService.get_attempts_per_Subject(token["id"])
        return Response({"success": True, "message": "Assessment Loaded", "data": attempts}, status=status.HTTP_200_OK)

class AttemptsHistory(APIView):
    def get(self, request):
        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        attempts = AttemptService.get_attempts(token["id"])
        return Response({"success": True, "message": "Assessment Loaded", "data": [{
            "id": a.AttemptID,
            "title": a.AssessmentFk.Title,
            "score": a.Score,
            "Total Score": a.TotalScore,
            "SubmittedAt": a.SubmittedAt
        } for a in attempts]}, status=status.HTTP_200_OK)

