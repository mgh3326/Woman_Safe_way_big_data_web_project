import os
import sys
import urllib.request
import json
from itertools import repeat


f = open("input.csv", 'r')  # 날짜 파일 입력
line = f.readline()
goo = ["종로구",
       "중구",
       "용산구",
       "성동구",
       "광진구",
       "동대문구",
       "중랑구",
       "성북구",
       "강북구",
       "도봉구",
       "노원구",
       "은평구",
       "서대문구",
       "마포구",
       "양천구",
       "강서구",
       "구로구",
       "금천구",
       "영등포구",
       "동작구",
       "관악구",
       "서초구",
       "강남구",
       "송파구",
       "강동구"]
oh = list(repeat(0, 25))
print(oh)
while True: # 파일 읽기
    line = f.readline()
    if not line:
        break
    # print(str(line).split(',')[1]+str(line).split(',')[2].split('\n')[0])
    if(str(line).split(',')[0] != ""):
        print(goo.index(str(line).split(',')[0]))
        oh[goo.index(str(line).split(',')[0])] = goo.index(
            str(line).split(',')[0])+int(str(line).split(',')[1]ㅇ)
        print(str(line).split(',')[0])

    # oh.append(str(line).split(',')[
    #           1]+","+str(line).split(',')[2].split('\n')[0])  # 공백 제거를 위함
f.close()
print(oh)
f = open("output.csv", 'w')  # 날짜 파일 입력
f.write("구,하차인원\n")
for index in range(0, 25): # 리스트 25개를 출력 용도
    f.write(goo[index]+","+str(oh[index])+'\n')

f.close
