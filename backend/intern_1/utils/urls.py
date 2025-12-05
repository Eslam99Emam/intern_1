from django.urls import URLPattern, path
from users import views

urlpatterns = [
    path("get-profile/", views.GetProfile.as_view()),
]