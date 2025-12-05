import json
import jwt
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

from users.services import UserService
from .serializers import UserAssessmentSerializer
from .services import AssessmentService
from config import settings
from attempts.services import AttemptService

class GetAssessment(APIView):
    '''
        Getter
    '''

    def get(self, request, id):
        '''
            Getter
        '''
        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        print(token)
        UserService.verify_token(token["id"])
        assessment = AssessmentService.get_assessment(id)
        return Response({"success": True, "message": "Assessment Loaded", "data": assessment}, status=status.HTTP_200_OK)

# Create your views here.
class CheckAssessment(APIView):
    '''
        Checker
    '''
    def post(self, request):
        '''
            Checker
        '''
        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        print(token)
        print(token["id"])
        user_id = UserService.verify_token(token["id"])
        data = AssessmentService.check_assessment(request.data)
        attempt = AttemptService.save_attempt(user_id, data)
        print(attempt)
        return Response({"success": True, "message": "Assessment Loaded", "data": data}, status=status.HTTP_201_CREATED)
