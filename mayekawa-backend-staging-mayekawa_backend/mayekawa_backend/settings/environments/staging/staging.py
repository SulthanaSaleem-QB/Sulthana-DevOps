from mayekawa_backend.settings.__init__ import *
import os

DEBUG = False

# Database
# https://docs.djangoproject.com/en/1.10/ref/settings/#databases

if os.getenv('AZURE_APPLICATION', None):
    DATABASES = AZURE_DB_CONFIG
else:
    DATABASES = OTHER_DB_CONFIG
