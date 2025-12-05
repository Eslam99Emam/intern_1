from django.urls import path
from . import views

urlpatterns = [
    path("get/<int:id>", views.GetAssessment.as_view()),
    path("check/", views.CheckAssessment.as_view()),
]
