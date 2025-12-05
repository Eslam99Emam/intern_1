from os import access
import re

import jwt
from datetime import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import AccessToken
from attempts.services import AttemptService
from config import settings
from users.serializers import UserSerializer
from .services import *


# Create your views here.
class SignupView(APIView):
    '''
        Signup
    '''

    def post(self, request):
        '''
            Signup
            payload:
                {
                    "name": "Eslam Emam",
                    "email": "eslam.emam.hussien@gmail.com",
                    "phone": "+201119684549",
                    "grade": "G14",
                    "password": "ESLAMOM.123!",
                    "role":"Student"
                }
        '''
        serializer = UserSerializer(data=request.data)
        print(" init serializer ")
        serializer.is_valid(raise_exception=True)
        print(" valid serializer ")

        print(serializer.data)
        print(serializer.validated_data)
        print(" service started ")
        user = UserService.signup(serializer.data)
        print(" service done ")

        token = jwt.encode({"id": user.id, "exp": datetime.now() + timedelta(days=30)}, settings.SECRET_KEY, algorithm="HS256")

        return Response({"success": True, "message": "User created", "token": str(token)}, status=201)


class LoginView(APIView):
    def post(self, request):
        print(request.data)
        print(request.data["email"])
        data = UserService.login(request.data["email"], request.data["password"])
        if check_password(request.data["password"], data.hashed_password):
            token = jwt.encode({"id": data.id, "exp": datetime.now() + timedelta(days=30)}, settings.SECRET_KEY, algorithm="HS256")
            return Response({"success": True, "message": "User logged in", "token": str(token)}, status=status.HTTP_200_OK)
        else:
            return Response({"success": False, "message": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)

class VerifyTokenView(APIView):
    def post(self, request):
        try:
            data = jwt.decode(request.data["token"], settings.SECRET_KEY, algorithms=["HS256"])
            print(data)
            print(data["id"])
            user = UserService.verify_token(data["id"])
            return Response({"success": True, "message": "Token Verified", "data" : { "id" : str(user.id)}}, status=status.HTTP_200_OK)
        except Exception as e :
            print(e)
            return Response({"success": False, "message": "Invalid or expired token"}, status=status.HTTP_401_UNAUTHORIZED)

class GetProfile(APIView):
    def get(self, request):
        token = jwt.decode(request.headers.get("Authorization").split(" ")[1], settings.SECRET_KEY, algorithms=["HS256"])
        print(token)
        UserService.verify_token(token["id"])
        user = UserService.get_profile(token["id"])
        attempts = AttemptService.get_attempts(token["id"])
        user["average"] = 0
        # print(*attempts)

        for attempt in attempts:
            print(f"percentage at {attempt}")
            print((attempt.Score / attempt.TotalScore) * 100)
            user["average"] += (attempt.Score / attempt.TotalScore) * 100
            print(f"current average {user['average']}")

        print(user["average"])
        user["average"] = user["average"] / len(attempts)
        print(user["average"])

        return Response({"success": True, "message": "Profile Loaded", "data": user}, status=status.HTTP_200_OK)