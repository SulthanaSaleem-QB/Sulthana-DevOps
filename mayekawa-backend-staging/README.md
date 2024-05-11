# mayekawa-backend



## Getting started
Clone project with the following command:

```
cd existing_repo
git remote add origin https://code.qburst.com/mayekawa/mayekawa-backend.git
git branch -M main
```

install following packages:

```
sudo apt-get install texlive
sudo apt-get install texlive-latex-extra
```

install Django libraries the following command

```
pip install -r requirements.txt
```

Add Database configurations in the [db_config.py](mayekawa_backend/settings/db_config.py) file, create new file if not exist.

sample content is as follows

```
OTHER_DB_CONFIG = {
   'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mayekawa_local',
        'USER': 'mayekawa',
        'PASSWORD': 'mayekawa',
        'HOST': '127.0.0.1',
        'PORT': '5432'
    },
}

AZURE_DB_CONFIG = {
   'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mayekawa_local',
        'USER': 'mayekawa',
        'PASSWORD': 'mayekawa',
        'HOST': '127.0.0.1',
        'PORT': '5432'
    },
}

```

add CURRENT_ENVIRONMENT value in mayekawa_backend/settings/env_config.py, find sutable value from [current_env](mayekawa_backend/settings/current_env.py) file.

