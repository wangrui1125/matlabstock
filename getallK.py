import baostock as bs
import pandas as pd
import sys

def download_data(date):
	bs.login()
	# 获取指定日期的指数、股票数据
	with open("temp.txt", "r") as f:  # 打开文件
		stock_df = f.readlines()  # 读取文件   
	data_df = pd.DataFrame()
	for code in stock_df:
		print("Downloading :" + code)
		k_rs = bs.query_history_k_data_plus(code[:-1], "date,code,open,high,low,close,peTTM,pbMRQ,psTTM", date, date)
		data_df = data_df.append(k_rs.get_data())
	bs.logout()
	data_df.to_csv("assignDayData.csv", encoding="gbk", index=False)

if __name__ == '__main__':
	# 获取指定日期全部股票的日K线数据
	download_data(sys.argv[1])