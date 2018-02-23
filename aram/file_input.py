day = []
f = open("day_2014.csv", 'r')  # 날짜 파일 입력
line = f.readline()  # head 부분 머리기 위함
while True:
    line = f.readline()
    if not line:
        break
    day.append(str(line).split('\n')[0])  # 공백 제거를 위함
f.close()
data = []
data_day = []
fr = open("서대문구2014_t.csv", "r")  # 기록 파일 입력
fw = open("day_2016_result.csv", 'w')  # 결과 파일 출력을 위한 입력

line = fr.readline()  # head 부분 머리기 위함
print(line, end="")

while True:
    line = fr.readline()
    if not line:
        break
    data.append(str(line).split('\n')[0])  # 공백 제거를 위함
    data_day.append(str(line).split(',')[0])  # 공백 제거를 위함
fr.close()
oh_index = 0
for index in day:
        if oh_index >= len(data_day):
            print(index)
            continue

        # if oh_index > len(data_day):
        #     print(index)
        #     break
        if index == data_day[oh_index]:
            print(data[oh_index].split('\n')[0])
            oh_index += 1
        else:
            print(index)
# print(data_day)
# print(day)
# for index in day:
#     print(index)

fw.close()
fr.close()
