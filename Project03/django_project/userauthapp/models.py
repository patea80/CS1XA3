from django.db import models
from django.contrib.auth.models import User

class Advertisement(models.Model):
    def __init__(self, title, price, description, phnum):
        self.title = title
        self.price = price
        self.description = description
        self.phnum = phnum


class UserInfoManager(models.Manager):
    def create_user_info(self, fullname, email, username, password):
        user = User.objects.create_user(username=username,
                                        password=password)
        # userinfo = self.create(user=user,info="info")
        user.fullname = fullname
        user.email = email
        user.allAds = []

        user.save()

        acc = self.create(user=user)

        return acc

class UserInfo(models.Model):
    user = models.OneToOneField(User,
                                on_delete=models.CASCADE,
                                primary_key=True,)

    info = models.CharField(max_length=30)

    objects = UserInfoManager()


