function KLine(varargin)
%% fun help
% function Kplot(O,H,L,C)
%          Kplot(O,H,L,C,date)
%          Kplot(O,H,L,C,date,colorUp,colorDown,colorLine)
%
%          Kplot(OHLC)
%          Kplot(OHLC,date)
%          Kplot(OHLC,date,colorUp,colorDown,colorLine)
%
%  KLine(OHLC, 0, 'r', 'g', 'w');
%%
isMat = size(varargin{1}, 2); %返回第一个参数的值的列数
indexShift = 0; %参数索引位置
useDate = 0; %是否使用

%提取OHLC
if isMat == 4,
    O = varargin{1}(:,1);
    H = varargin{1}(:,2);
    L = varargin{1}(:,3);
    C = varargin{1}(:,4);
else
    O = varargin{1};
    H = varargin{2};
    L = varargin{3};
    C = varargin{4};
    indexShift = 3;
end

%设置颜色的值
if nargin + isMat < 7
    colorDown = 'g'; 
    colorUp = 'r'; 
else
    colorUp = varargin{3+indexShift};
    colorDown = varargin{4+indexShift};
end

%设置Date值
if nargin + isMat < 6
    date = (1:length(O))';
else
    if varargin{2+indexShift} ~= 0
        date = varargin{2+indexShift};
        useDate = 1;
    else
        date = (1:length(O))';
    end
end

%设置宽度
w = .3 * min([(date(2)-date(1)) (date(3)-date(2))]);


d = C - O; %收盘价-开盘价

hold on


%画k线, 收盘价小于开盘价，跌
n = find(d < 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', colorDown) %x1, x2, y1, y2
    x = [date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y = [O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, colorDown)
end

%画k线，收盘价大于开盘价，涨
n = find(d > 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', colorUp) %x1, x2, y1, y2
    x=[date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y=[O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, colorUp)
end

%画k线，收盘价等于开盘价
n = find(d == 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', 'w') %x1, x2, y1, y2
    x=[date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y=[O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, 'w')
end


