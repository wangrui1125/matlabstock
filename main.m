% main
% 数据爬取
clear;
load allst;

for gp=1:1
    
    str=[shgp(gp,1:2) shgp(gp,4:end)] 
%     if exist([ str '.mat'])
%         continue;
%     end
    load (str);
    python('roeget.py', shgp(gp,:),'2007-01-01','2020-06-24')% 数据获取
    % load shuju 
%     roe=importfile('profit_data.csv');
%     growth=importfile('grow_data.csv');
    kddata=importfileK('history_A_stock_k_data.csv');
    eval(['save ' str ' roe growth kddata']);
end

%% 作图 roe and pe
load allst;

numgp=length(shgp);
roes=zeros(numgp,3);

for cn=1:numgp
    eval(['load ' shgp(cn,1:2) shgp(cn,4:end) '']);
    [a,b]=size(roe);
    if a>5
        % roe
        for i=2:-1:1
             temp=roe{end-(i-1)*4,4};
             if length(temp)>0
                   roes(cn,i)=temp;
              end
        end
        % pe 
         roes(cn,3)=newst{7};
    end
end
%  plot([-0.1 0.1],[-0.1 0.1],'r-');
 %%
 
%  h=plot(1:length(shgp),roes(:,2)-roes(:,1),'-');hold on;
 h=plot(roes(:,2),roes(:,3),'o');hold on;
 
 