f = open("경도위도지하철입력용.csv", 'r')  # 날짜 파일 입력
oh=[]
line = f.readline()
output = ""
output += "위치,경도,위도,구"
while True:
    line = f.readline()
    if not line:
        break
    print(str(line).split(',')[1]+str(line).split(',')[2].split('\n')[0])
    oh.append(str(line).split(',')[1]+str(line).split(',')[2].split('\n')[0])  # 공백 제거를 위함
f.close()
# print(oh)
f = open("outupt.csv", 'w')
f.write(output)
f.close()
print(output)
