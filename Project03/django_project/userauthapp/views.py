from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
import json

from .models import UserInfo, Advertisement


def post_add(request):
    # category = json_req.get('category','')
    json_req = json.loads(request.body)
    title = json_req.get('title','')
    price = json_req.get('price', 0)
    description = json_req.get('description','')
    phnum = json_req.get('phnum','')
    
    print("auth") 
    item = Advertisement(title,price,description,phnum)

    print(request.user)
    if not request.user.is_authenticated:
        return HttpResponse("LoggedOut")
    else:
        user.allAds.append(item)
        user.save()
        return HttpResponse("Success")


  

def add_user(request):
    """recieves a json request { 'username' : 'val0', 'password' : 'val1' } and saves it
       it to the database using the django User Model
       Assumes success and returns an empty Http Response"""
    json_req = json.loads(request.body)
    fname = json_req.get('fullname','')
    mail = json_req.get('email','')
    uname = json_req.get('username','')
    passw = json_req.get('password','')
    if uname != '':
        account = UserInfo.objects.create_user_info(fullname = fname, email = mail, username=uname,
                                        password=passw)
        account.save()
        
        login(request,account.user)
        return HttpResponse('Registered')

    else:
        return HttpResponse('Error')


def login_user(request):
    """recieves a json request { 'username' : 'val0' : 'password' : 'val1' } and
       authenticates and loggs in the user upon success """
    json_req = json.loads(request.body)
    uname = json_req.get('username','')
    passw = json_req.get('password','')
    user = authenticate(request,username=uname,password=passw)
    if user is not None:
        login(request,user)
        return HttpResponse("LoggedIn")
    else:
        return HttpResponse('LoginFailed')

def user_info(request):
    """serves content that is only available to a logged in user"""

    if not request.user.is_authenticated:
        return HttpResponse("LoggedOut")
    else:
        # do something only a logged in user can do
        return HttpResponse("Hello " + request.user.first_name)
