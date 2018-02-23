import urllib
import json
from urllib.request import urlopen
from urllib import parse


def get_locate(intput_str, output):
    location = intput_str
    # print("http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address="+parse.quote(location))
    data = urllib.request.urlopen(
        "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&language=ko&address=" + parse.quote(location))

    _json = json.loads(data.read())
    print(_json["results"][0]["geometry"]["location"])
    try:
        latitude = _json["results"][0]["geometry"]["location"]["lat"]
        longitude = _json["results"][0]["geometry"]["location"]["lng"]
    except IndexError:  # 에러 종류
        latitude = 0
        longitude = 0
    # print(str(latitude)+","+str(longitude))
    print(latitude, end=",")

    # str_latitude=str(latitude)
    output = output+str(latitude)+','

    print(longitude)
    output += str(longitude)
    output += '\n'
    return output


# 출처: http://wkdgusdn3.tistory.com/entry/Python-주소로-위도-경도-검색하기 [착한코딩님의 블로그]
# oh = []
# output = ""
# f = open("위도경도input.csv", 'r')  # 날짜 파일 입력
# line = f.readline()
# output += "위치,위도,경도"
# while True:
#     line = f.readline()
#     if not line:
#         break
#     oh.append(str(line).split('\n')[0])  # 공백 제거를 위함
# f.close()
# # print(oh)
# for index in oh:
#     print(index, end=",")
#     output = output+index+','
#     output = get_locate(index, output)
# print("함수 종료")
# f = open("outupt.csv", 'w')
# f.write(output)
# f.close()
# print(output)
oh=""
get_locate("불광동",oh)