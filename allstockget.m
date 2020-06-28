%% 所有的股票数据，更新
% 1、创业bai板。创业板的代码是300打头的股票代码。% 
% 2、沪市A股。沪市A股的代码是以600、601或603打头。% 
% 3、沪市B股。沪市B股的代码是以900打头。% 
% 4、深市A股。深市A股的代码是以000打头。% 
% 5、中小板。中小板的代码是002打头。% 
% 6、深圳B股。深圳B股的代码是以200打头。
%
% 读取所有股票列表 
python('getallstacks.py','2020-06-24')
clear;

load allst
shgp=[];
shzs=[];
szgp=[];
szcy=[];
szzs=[];

for i=1:length(allstock) 
        stackcode=allstock{i,1};
        if findstr(stackcode,'sh.60')
            shgp=[shgp;stackcode];
        elseif findstr(stackcode,'sh.00')
            shzs=[shzs;stackcode];        
        elseif findstr(stackcode,'sz.00')
            szgp=[szgp;stackcode];       
       elseif findstr(stackcode,'sz.30')
            szcy=[szcy;stackcode];     
       elseif findstr(stackcode,'sz.39')
            szzs=[szzs;stackcode]; 
        end    
end
save allst

%%  getallnewst
load allst;
writetemp('temp.txt',shgp);
% python('getallK.py','2020-06-24'); % 建议使用python执行
allK=importfileallK('assignDayData.csv');
if length(allK)== length(shgp)
    for gp=1:length(shgp)
        str=[shgp(gp,1:2) shgp(gp,4:end)]
        load (str); 
        for j=1:size(allK,2)
            newst{j}=allK{gp,j};
        end
        eval(['save ' str ' roe growth kddata newst']);
    end    
end  

