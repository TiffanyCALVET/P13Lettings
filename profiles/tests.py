from django.test import TestCase
from django.urls import reverse
from django.contrib.auth.models import User

from .models import Profile


class ProfilesTest(TestCase):

    def setUp(self):
        self.user = User.objects.create(
            username="UserTest",
            password="S3cret!!",
            email="test@test.com",
        )
        self.profile = Profile.objects.create(user=self.user, favorite_city="Paris")

    def test_profiles_index(self):
        response = self.client.get(reverse('profiles:index'))
        assert response.status_code == 200
        assert b"<title>Profiles</title>" in response.content

    def test_profiles(self):
        response = self.client.get(reverse('profiles:profile', args=["UserTest"]))
        assert response.status_code == 200
        assert b"<title>UserTest</title>" in response.content
