f = open("음음.csv", 'r')  # 날짜 파일 입력
output = ""
output += "지하철역\n"
oh = []
while True:
    line = f.readline()
    if not line:
        break
    if len(str(line).split(',')[9])>1:
        print(str(line).split(',')[9])
        output+=str(line).split(',')[2]
        output+="\n"
f.close()
f = open("음음_output.csv", 'w')
f.write(output)
f.close()
# print(output)