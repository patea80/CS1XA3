from django.db import models
from django.contrib.auth.models import User

class UserInfoManager(models.Manager):
    def create_user_info(self, fullname, email, username, password):
        user = User.objects.create_user(username=username, password=password)
        # userinfo = self.create(user=user,info="info")
        user.fullname = fullname
        user.email = email

        user.save()

        acc = self.create(user=user)
        return acc
    def __str__(self):
        return self.fullname + " " + self.email
        


class Add(models.Model):

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    
    title = models.CharField(max_length=100)
    price = models.CharField(max_length=100)
    description = models.CharField(max_length=100)
    phnum = models.CharField(max_length=100)

    def __str__(self):
        return self.title

