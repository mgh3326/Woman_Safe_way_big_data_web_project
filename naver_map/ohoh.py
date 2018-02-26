#본 예제는 Python에서 주소좌표변환 api를 호출하는 예제입니다.
import os
import sys
import urllib.request
import json


def naver_map(coordinate, output):
    client_id = "RuFoLfsTtI8AaT_9bWNn"
    client_secret = "kpOxKkLdiK"
    # print(coordinate)
    encText = urllib.parse.quote("126.9013,37.55598")

    url = "https://openapi.naver.com/v1/map/reversegeocode?query=" + encText  # json 결과
    # url = "https://openapi.naver.com/v1/map/geocode.xml?query=" + encText # xml 결과
    request = urllib.request.Request(url)
    request.add_header("X-Naver-Client-Id", client_id)
    request.add_header("X-Naver-Client-Secret", client_secret)
    # print(url)
    response = urllib.request.urlopen(request)
    rescode = response.getcode()
    if(rescode == 200):
        response_body = response.read()

        print(response_body.decode('utf-8'))
        _json = json.loads(response_body.decode('utf-8'))
        if not _json["result"]["items"]:
            print("ohoh")
        if(_json["result"]["items"][0]["addrdetail"]["sido"] == "서울특별시"):
            print(_json["result"]["items"][0]["addrdetail"]["sigugun"])
            output += _json["result"]["items"][0]["addrdetail"]["sigugun"]
        else:
            print()
        output += "\n"
        # latitude = _json["result"]["items"][0]["point"]["y"]

        # for i in response_body.decode('utf-8'):
        #     print(i)

    else:
        print("Error Code:" + rescode)
    return output


f = open("경도위도지하철입력용.csv", 'r')  # 날짜 파일 입력
oh = []
line = f.readline()
output = ""
output += "위치,경도,위도,구"
output += "\n"
while True:
    line = f.readline()
    if not line:
        break
    # print(str(line).split(',')[1]+str(line).split(',')[2].split('\n')[0])
    output += str(line).split('\n')[0]
    print(str(line).split(',')[0])
    output = naver_map(str(line).split(',')[1]+',' +
                       str(line).split(',')[2].split('\n')[0], output)
    # oh.append(str(line).split(',')[
    #           1]+","+str(line).split(',')[2].split('\n')[0])  # 공백 제거를 위함
f.close()
print(oh)
# for index in oh:
#     print(index)
#     output = naver_map(index, output)

f = open("outupt.csv", 'w')
f.write(output)
f.close()
print(output)
