f = open("음음_output.csv", 'r')  # 날짜 파일 입력
f.readline()
my_oh = []
while True:
    line = f.readline()
    if not line:
        break
    my_oh.append(str(line).split('\n')[0])  # 공백 제거를 위함
f.close()
# print(my_oh)
for index in my_oh:
    if(index.find('(') > 0):
        my_oh.append(index.split('(')[0])
f = open("지하철_하차_승객수.csv", 'r')  # 날짜 파일 입력
output = ""
output += f.readline()
oh = []
while True:
    line = f.readline()
    if not line:
        break
    if my_oh.count(str(line).split(',')[2]) > 0:
        oh.append(str(line).split(',')[2])  # 공백 제거를 위함
        output += str(line)
    elif str(line).split(',')[2].find('(') > 0:
        if my_oh.count(str(line).split(',')[2].find('(')) > 0:
            oh.append(str(line).split(',')[2])  # 공백 제거를 위함
            output += str(line)
f.close()
print(oh)
f = open("outupt_역.csv", 'w')
f.write(output)
f.close()
print(output)
