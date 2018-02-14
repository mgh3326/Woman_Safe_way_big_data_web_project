#pandas import

import pandas as pd

#읽어온후 저장

testCSV_path = "C:\\output\\1-4호선승하차승객수.csv"

olive_oil = pd.read_csv(testCSV_path)

#상위 3줄 출력

olive_oil.head(3) #결과

olive_oil = pd.read_csv(testCSV_path,header=None) #컬럼이름이 value로 들어가버림
olive_oil.head(3) #결과

olive_oil.rename(columns = {olive_oil.columns[0]:"id_area"},inplace=True) #컬럼명 변경
olive_oil.head(3)

olive_oli = pd.read_csv(testCSV_path, names=["a","b","c","d"]) #칼럼이랑 갯수 맞춰서 해줘야됨 
olive_oli.head(3)

olive_oil.to_csv("C:\\output\\1-4호선승하차승객수_py.csv")