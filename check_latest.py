#-*- coding:utf-8 -*-

import requests
from bs4 import BeautifulSoup

url = "https://github.com/opencv/opencv/tags"
version = []

res = requests.get(url)
soup = BeautifulSoup(res.text, "lxml")


ver_lis = soup.find_all('h4')
for idx in ver_lis:
    if idx.find('a'):
        content = idx.find('a').getText()
        content = content.replace(' ', '')
        content = content.replace('\n', '')
        version.append(content)


lastest = [0, None]
for idx in version:
    if (len(idx.split('-')) < 2):
        if(int(idx[0]) > lastest[0]):
            lastest[0] = int(idx[0])
            lastest[1] = idx


print(lastest[1])