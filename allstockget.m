%% ���еĹ�Ʊ���ݣ�����
% 1����ҵbai�塣��ҵ��Ĵ�����300��ͷ�Ĺ�Ʊ���롣% 
% 2������A�ɡ�����A�ɵĴ�������600��601��603��ͷ��% 
% 3������B�ɡ�����B�ɵĴ�������900��ͷ��% 
% 4������A�ɡ�����A�ɵĴ�������000��ͷ��% 
% 5����С�塣��С��Ĵ�����002��ͷ��% 
% 6������B�ɡ�����B�ɵĴ�������200��ͷ��
%
% ��ȡ���й�Ʊ�б� 
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
% python('getallK.py','2020-06-24'); % ����ʹ��pythonִ��
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

