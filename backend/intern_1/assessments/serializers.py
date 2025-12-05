from email import message
from rest_framework import serializers
from .models import Assessment


class UserAssessmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Assessment
        fields = ['AssessmentID', "Title"]


