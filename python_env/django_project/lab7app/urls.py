from django.urls import path
from . import views

urlpatterns = [
    path('lab7/', views.post_varsa , name='lab7app-post_varsa'),
]
