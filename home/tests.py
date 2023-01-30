from django.test import Client, TestCase
from django.urls import reverse


class HomeTest(TestCase):

    def test_home_view(self):
        response = self.client.get(reverse('home:index'))
        assert response.status_code == 200
        assert b"<title>Holiday Homes</title>" in response.content

