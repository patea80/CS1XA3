from django.shortcuts import render

from django.contrib import admin
from django.urls import path

from django.http import HttpResponse

# Create your views here.
def post_varsa(request):
 name = request.POST.get("name","")
 password = request.POST.get("password","")

 if name == "Jimmy" and password == "Hendrix":
  return HttpResponse("Cool")
 else:
  return HttpResponse("Bad User Name")

 urlpatterns = [
  path("lab7/" , post_varsa) ,
]
