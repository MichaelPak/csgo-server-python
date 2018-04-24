import os
import sys
import requests
from urllib.request import urlopen

BASE_DOWNLOAD_URL = 'http://builds.sourcepython.com/job/Source.Python/lastSuccessfulBuild/artifact/'
ARTIFACTS_URL = 'http://builds.sourcepython.com' \
                '/job/Source.Python/lastSuccessfulBuild/api/json?tree=artifacts[relativePath]'
UPDATE_ZIP_FILE = 'source-python.zip'
GAME_NAME = 'csgo'


def get_url():
    response = requests.get(url=ARTIFACTS_URL)
    for artifact in response.json().get('artifacts'):
        if GAME_NAME in artifact['relativePath']:
            break
    else:
        raise RuntimeError
    return os.path.join(BASE_DOWNLOAD_URL, artifact['relativePath'])


def download(file_path, timeout=3):
    with urlopen(get_url(), timeout=timeout) as url:
        data = url.read()

    file = os.path.join(file_path, UPDATE_ZIP_FILE)
    with open(file, 'wb') as f:
        f.write(data)


if __name__ == '__main__':
    download(sys.argv[1])
