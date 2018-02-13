import urllib.request
from bs4 import BeautifulSoup
import requests

import pandas as pd
import datetime
from itertools import count
import xml.etree.ElementTree as ET


def get_html(url):
    _html = ""
    resp = requests.get(url)
    if resp.status_code == 200:
        _html = resp.text
    return _html


def getPastWeather(result, year, month):
    my_url = "http://www.weather.go.kr/weather/climate/past_cal.jsp?stn=108&yy=%s&mm=%s&obs=1&x=28&y=11" % (str(
        year), str(month + 1))  # 2018년 1월
    html = get_html(my_url)
    soup_data = BeautifulSoup(html, 'html.parser')
    # print(soupData)
    store_table = soup_data.find('table', attrs={'class': 'table_develop'})
    tbody = store_table.find('tbody')
    # print(tbody)
    b_end = True
    ohoh = []
    yes = []
    # print(result)
    for store_tr in tbody.findAll('td'):
        b_end = False

        tr_tag = list(store_tr.strings)
        for index in tr_tag:
            # print(i)
            if str(index).startswith('평균기온'):
                result.append(index)
            if str(index).startswith('최고기온'):
                result.append(index)
            if str(index).startswith('평균운량'):
                result.append(index)
            if str(index).startswith('일강수량'):
                result.append(index)
                # print("ohoh", end="")
                # print(ohoh)
                # print(ohoh)
                # yes.append(ohoh)
                # # print(yes)
                # ohoh.clear()
        # print("(" + str(len(tr_tag)) + ") " + str(tr_tag))
        # store_name = tr_tag[1]
        # store_address = tr_tag[3]
        # store_sido_gu = store_address.split()[:2]
    # print("ohoh", end="")
    # print(ohoh)

    if b_end:
        return

    return


def output(year, month):
    result = []
    getPastWeather(result, year, month)
    print("--------(%d)월" % (month + 1))
    # print(result)
    index = 0
    oh_index = 0
    for i in result:
        if index % 4 == 0:
            print("======(%d)일" % (oh_index + 1))
            oh_index += 1

        index += 1
        print(i)
    # print(result)


for i in range(0, 12):
    output(2017, i)
