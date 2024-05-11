from .env_config import CURRENT_ENVIRONMENT
import os
import django


def get_django_setting_module():
    if CURRENT_ENVIRONMENT == "Local":
        return "mayekawa_backend.settings.environments.local.local"
    if CURRENT_ENVIRONMENT == "Staging":
        return "mayekawa_backend.settings.environments.staging.staging"
    if CURRENT_ENVIRONMENT == "Production":
        return "mayekawa_backend.settings.environments.production.production"


def django_setup():
    os.environ['DJANGO_SETTINGS_MODULE'] = get_django_setting_module()
    if os.environ['DJANGO_SETTINGS_MODULE'] is None:
        os.environ['DJANGO_SETTINGS_MODULE'] = "mayekawa_backend.settings.environments.staging.staging"
    django.setup()