from django.urls import URLPattern, path
from . import views

urlpatterns = [
    path("signup/", views.SignupView.as_view()),
    path("login/", views.LoginView.as_view()),
    path("verify-token/", views.VerifyTokenView.as_view()),
]