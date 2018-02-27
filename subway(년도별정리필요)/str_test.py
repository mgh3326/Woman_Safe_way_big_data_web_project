f = open("outupt.csv", 'r')  # 날짜 파일 입력
f.readline()
oh=[]
while True:
    line = f.readline()
    if not line:
        break
    oh.append(str(line).split('\n')[0])  # 공백 제거를 위함
f.close()
print(oh)
for index in oh:
    if(index.find('(')>0):
        print(index.split('(')[0])