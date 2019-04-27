from django.http import HttpResponse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.http import JsonResponse
import json

from userauthapp.models import Add


def post_add(request):

    json_req = json.loads(request.body)
    title = json_req.get('title','')
    price = json_req.get('price', '')
    description = json_req.get('description','')
    phnum = json_req.get('phnum','')
    if title == "":
        return HttpResponse("IncompleteInfo")
    else: 
        test = request.user.add_set.create(title = title, price = price, description = description, phnum =phnum)
        test.save()
        print(test)
        return HttpResponse('AddPosted')

def get_adds(request):
    title = list(Add.objects.values_list('title', flat=True))
    price = list(Add.objects.values_list('price', flat=True))
    description = list(Add.objects.values_list('description', flat=True))
    phnum = list(Add.objects.values_list('phnum', flat=True))
    d = {"title":title, "price":price, "description":description, "phnum":phnum}
    print(d)
    return JsonResponse(d)

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
        account = add.objects.create_user_info(fullname = fname, email = mail, username=uname,password=passw)
        user = authenticate(request, username=uname, password=passw)
                                        
        account.save()
        
        login(request,user)
        return HttpResponse('Registered')

    else:
        return HttpResponse('Error')


def login_user(request):
    print("Login")
    """recieves a json request { 'username' : 'val0' : 'password' : 'val1' } and
       authenticates and loggs in the user upon success """
    json_req = json.loads(request.body)
    uname = json_req.get('username','')
    passw = json_req.get('password','')
    user = authenticate(request,username=uname,password=passw)
    if user is not None:
        login(request,user)
        return HttpResponse("READY")
    else:
        return HttpResponse('LoginFailed')


def user_info(request):
    """serves content that is only available to a logged in user"""
    if not request.user.is_authenticated:
        return HttpResponse("LoggedOut")
    else:
        # do something only a logged in user can do
        return HttpResponse("Auth")
