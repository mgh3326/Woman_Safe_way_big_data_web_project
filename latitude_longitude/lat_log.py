import urllib
import json
from urllib.request import urlopen
from urllib import parse

location = "미아동"
print(parse.quote(location))
data = urllib.request.urlopen(
    "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=" + parse.quote(location))

json = json.loads(data.read())

latitude = json["results"][0]["geometry"]["location"]["lat"]
longitude = json["results"][0]["geometry"]["location"]["lng"]

print(latitude)
print(longitude)

# 출처: http://wkdgusdn3.tistory.com/entry/Python-주소로-위도-경도-검색하기 [착한코딩님의 블로그]
