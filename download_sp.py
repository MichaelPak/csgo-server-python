import os
import sys
import requests
from urllib.request import urlopen

BASE_URL = 'http://downloads.sourcepython.com'
ARTIFACT_LIST = 'artifacts.txt'
UPDATE_ZIP_FILE = 'source-python.zip'
GAME_NAME = 'csgo'


def get_url():
    response = requests.get(url=os.path.join(BASE_URL, ARTIFACT_LIST))
    for artifact in response.text.split('\n'):
        if GAME_NAME in artifact:
            return os.path.join(BASE_URL, artifact)
    else:
        raise RuntimeError


def download(file_path, timeout=3):
    if not os.path.exists(file_path):
        os.makedirs(file_path)

    with urlopen(get_url(), timeout=timeout) as url:
        data = url.read()

    file = os.path.join(file_path, UPDATE_ZIP_FILE)
    with open(file, 'wb') as f:
        f.write(data)


if __name__ == '__main__':
    download(sys.argv[1])
