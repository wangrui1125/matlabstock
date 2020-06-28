def roeget(stackcode):
	import baostock as bs
	import pandas as pd
	# 登陆系统
	lg = bs.login()
	# 显示登陆返回信息
	# print('login respond error_code:'+lg.error_code)
	# print('login respond  error_msg:'+lg.error_msg)
	# 查询季频估值指标盈利能力
	profit_list = []
	for y in range(2007,2021):
		qu=4;
		if y==2021:
			qu=1        
		for i in range(qu):        
			rs_profit = bs.query_profit_data(code=stackcode, year=y, quarter=i+1)
			while (rs_profit.error_code == '0') & rs_profit.next():
				profit_list.append(rs_profit.get_row_data())
	result_profit = pd.DataFrame(profit_list, columns=rs_profit.fields)
	# 结果集输出到csv文件
	result_profit.to_csv("profit_data.csv", encoding="utf8", index=False)
	# 登出系统
	bs.logout()
def growget(stackcode):
	import baostock as bs
	import pandas as pd
	# 登陆系统
	lg = bs.login()
	# 显示登陆返回信息
	# print('login respond error_code:'+lg.error_code)
	# print('login respond  error_msg:'+lg.error_msg)
	# 查询季频估值指标盈利能力
	growth_list = []
	for y in range(2007,2021):
		qu=4;
		if y==2021:
			qu=1        
		for i in range(qu):        
			rs_profit = bs.query_growth_data(code=stackcode, year=y, quarter=i+1)
			while (rs_profit.error_code == '0') & rs_profit.next():
				growth_list.append(rs_profit.get_row_data())
	result_growth = pd.DataFrame(growth_list, columns=rs_profit.fields)
	# 结果集输出到csv文件
	result.to_csv("grow_data.csv", encoding="utf8", index=False)
	# 登出系统
	bs.logout()

def Kget(stockcode,checkdate1,checkdate2):
	import pandas as pd
	import baostock as bs
	#### 登陆系统 ####
	lg = bs.login()
	# 显示登陆返回信息
	# print('login respond error_code:'+lg.error_code)
	# print('login respond  error_msg:'+lg.error_msg)

	#### 获取沪深A股历史K线数据 ####
	# 详细指标参数，参见“历史行情指标参数”章节；“分钟线”参数与“日线”参数不同。
	# 分钟线指标：date,time,code,open,high,low,close,volume,amount,adjustflag
	rs = bs.query_history_k_data_plus(stockcode,"date,code,open,high,low,close,preclose,volume,amount,adjustflag,turn,tradestatus,pctChg,peTTM",
		start_date=checkdate1, end_date=checkdate2,
		frequency="d", adjustflag="3")
	# print('query_history_k_data_plus respond error_code:'+rs.error_code)
	# print('query_history_k_data_plus respond  error_msg:'+rs.error_msg)

	#### 打印结果集 ####
	data_list = []
	while (rs.error_code == '0') & rs.next():
		# 获取一条记录，将记录合并在一起
		data_list.append(rs.get_row_data())
	result = pd.DataFrame(data_list, columns=rs.fields)
	#### 结果集输出到csv文件 ####   
	result.to_csv("history_A_stock_k_data.csv", encoding="utf8", index=False)
	# print(result)
	#### 登=出系统 ####
	bs.logout()
if '__main__'==__name__:
	import sys
	import pandas as pd
	# roeget(sys.argv[1])
	# growget(sys.argv[1])
	Kget(sys.argv[1],sys.argv[2],sys.argv[3])