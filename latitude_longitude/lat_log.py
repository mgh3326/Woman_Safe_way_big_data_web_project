import urllib
import json
from urllib.request import urlopen
from urllib import parse


def get_locate(str):
    location = str
    print("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address="+parse.quote(location))
    data = urllib.request.urlopen(
        "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=" + parse.quote(location))

    _json = json.loads(data.read())

    latitude = _json["results"][0]["geometry"]["location"]["lat"]
    longitude = _json["results"][0]["geometry"]["location"]["lng"]

    print(latitude)
    print(longitude)

# 출처: http://wkdgusdn3.tistory.com/entry/Python-주소로-위도-경도-검색하기 [착한코딩님의 블로그]

get_locate("판고 파출소")