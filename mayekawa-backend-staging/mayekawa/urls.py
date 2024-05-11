from django.urls import path
from .views import *

urlpatterns = [
    path('login/', Login.as_view(), name='login'),
    path('logout/', logout_view),
    path('products/', ProductCodes.as_view()),
    path(
        'widgets/temperature-profile/',
        TemperatureProfile.as_view(),
        name='temperature-profile'
    ),
]
