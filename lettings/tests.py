from django.test import TestCase
from django.urls import reverse

from .models import Address, Letting


class LettingsTest(TestCase):

    def setUp(self):
        self.address = Address.objects.create(
            number=10,
            street="av Hugo",
            city="Paris",
            state="France",
            zip_code=75001,
            country_iso_code="FRA"
        )
        self.letting = Letting.objects.create(title="Test Letting", address=self.address)

    def test_lettings_index(self):
        response = self.client.get(reverse('lettings:index'))
        assert response.status_code == 200
        assert b"<title>Lettings</title>" in response.content

    def test_lettings(self):
        response = self.client.get(reverse('lettings:letting', args=[1]))
        assert response.status_code == 200
        assert b"<title>Test Letting</title>" in response.content
