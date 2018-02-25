oh = []
f = open("일별 기록.csv", 'r')
line = f.readline()

while True:
    line = f.readline()
    if not line:
        break
    oh.append(line)
f.close()
for index in oh:
    temp = str(index).split(',')[0]
    print(temp+"  : ", end="")
    print(temp.split('-')[2])
#주석