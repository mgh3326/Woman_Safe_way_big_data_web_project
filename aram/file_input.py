day = []
f = open("day_2016.csv", 'r')  # 날짜 파일 입력
line = f.readline()  # head 부분 머리기 위함

while True:
    line = f.readline()
    if not line:
        break
    day.append(str(line).split('\n')[0])  # 공백 제거를 위함
f.close()
data = []
fr = open("일별 기록.csv", "r")  # 기록 파일 입력
fw = open("day_2016_result.csv", 'w')  # 결과 파일 출력을 위한 입력

line = fr.readline()  # head 부분 머리기 위함
while True:
    line = fr.readline()
    if not line:
        break
    for index in day:
        if index == str(line).split(',')[0]:
            print(str(line).split('\n')[0])
        else:
            print(index)
    data.append(str(line).split(',')[0])  # 공백 제거를 위함
fr.close()
# print(data)
# print(day)
# for index in day:
#     print(index)

fw.close()
fr.close()
