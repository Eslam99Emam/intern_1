from django.urls import URLPattern, path
from . import views

urlpatterns = [
    path("period-scores-analysis/", views.PeriodScoresAnalysis.as_view()),
    path("subject-scores-analysis/", views.SubjectScoresAnalysis.as_view()),
    path("history/", views.AttemptsHistory.as_view()),
]