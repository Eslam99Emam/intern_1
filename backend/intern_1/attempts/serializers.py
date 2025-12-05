from email import message
from rest_framework import serializers
from . import models


class AttemptSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.AttemptAssessment
        fields = '__all__'


