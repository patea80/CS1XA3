from django.urls import path
from . import views

# mapped from path hello/
urlpatterns = [
    path('postadd/', views.post_add , name = 'userauthapp-post_add') ,
    path('getadds/', views.get_adds , name = 'userauthapp-get-adds') ,
    path('adduser/', views.add_user , name = 'userauthapp-add_user') ,
    path('loginuser/', views.login_user , name = 'userauthapp-login_user') ,
    path('userinfo/', views.user_info , name = 'userauthapp-user_info') ,
    

]
