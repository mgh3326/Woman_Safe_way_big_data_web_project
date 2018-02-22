import urllib.request
from bs4 import BeautifulSoup
import requests

import pandas as pd
import datetime
from itertools import count
import xml.etree.ElementTree as ET


def get_html(url):  # 날씨 코드를 받아오기
    _html = ""
    resp = requests.get(url)
    if resp.status_code == 200:
        _html = resp.text
    return _html


def getPastWeather(result, year, month):  # 결과값을 년도, 달별로 받기
    my_url = "http://www.weather.go.kr/weather/climate/past_cal.jsp?stn=108&yy=%s&mm=%s&obs=1&x=28&y=11" % (
        str(year), str(month + 1))  # 년도와 달을 매개변수를 이용하여 주소값을 입력
    html = get_html(my_url)  # html로 문자열 반환 자료값을 받기
    # print(html)
    soup_data = BeautifulSoup(html, 'html.parser')  # beautiful함수로 실행
    # print(soupData)
    store_table = soup_data.find('table', attrs={'class': 'table_develop'})
    #print(store_table)
    tbody = store_table.find('tbody')  # tbody에 있는 정보만 가져오기
    # print(tbody)
    b_end = True
    # ohoh = []
    # yes = []
    # print(result)
    for store_tr in tbody.findAll('td'):
        b_end = False

        tr_tag = list(store_tr.strings)  #
        # print(tr_tag)
        for index in tr_tag:  # 순차적으로 불러온 값을 출력한다
            # print(i)
            if str(index).startswith('평균기온'):
                result.append(index)
            if str(index).startswith('최고기온'):
                result.append(index)
            if str(index).startswith('최저기온'):
                result.append(index)
            if str(index).startswith('평균운량'):
                result.append(index)
            if str(index).startswith('일강수량'):
                result.append(index)
                # print("ohoh", end="")   #다음줄로 넘겨서 출력
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
    # print(result)
    if b_end:  # 결과값을 옆으로 정리해서 출력
        return

    return


def output(year, month):
    result = []
    getPastWeather(result, year, month)
    # print("--------(%d)월" % (month + 1))
    # print(result)
    index = 0
    oh_index = 0
    for i in result:
        if index % 5 == 0:
            print("%d-%d-%d" %
                  (year, (month + 1), (oh_index + 1)), end=", ")
            oh_index += 1

        index += 1
        # print(i)
        # print(i.split(':')[0])
        if index % 5 != 0:
            print(i.split(':')[1], end=", ")
        if index % 5 == 0:
            print(i.split(':')[1])

    # print(result)


# 평균기온
# 최고기온
# 평균운량
# 일강수량
print("날짜, 평균기온, 최고기온, 최저기온, 평균운량, 일강수량")

for i in range(0, 12):
    output(2016, i)
