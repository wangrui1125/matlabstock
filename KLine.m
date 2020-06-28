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
isMat = size(varargin{1}, 2); %���ص�һ��������ֵ������
indexShift = 0; %��������λ��
useDate = 0; %�Ƿ�ʹ��

%��ȡOHLC
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

%������ɫ��ֵ
if nargin + isMat < 7
    colorDown = 'g'; 
    colorUp = 'r'; 
else
    colorUp = varargin{3+indexShift};
    colorDown = varargin{4+indexShift};
end

%����Dateֵ
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

%���ÿ��
w = .3 * min([(date(2)-date(1)) (date(3)-date(2))]);


d = C - O; %���̼�-���̼�

hold on


%��k��, ���̼�С�ڿ��̼ۣ���
n = find(d < 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', colorDown) %x1, x2, y1, y2
    x = [date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y = [O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, colorDown)
end

%��k�ߣ����̼۴��ڿ��̼ۣ���
n = find(d > 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', colorUp) %x1, x2, y1, y2
    x=[date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y=[O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, colorUp)
end

%��k�ߣ����̼۵��ڿ��̼�
n = find(d == 0);
for i = 1:length(n)
    line([date(n(i)) date(n(i))], [L(n(i)) H(n(i))], 'Color', 'w') %x1, x2, y1, y2
    x=[date(n(i))-w date(n(i))-w date(n(i))+w date(n(i))+w date(n(i))-w];
    y=[O(n(i))      C(n(i))      C(n(i))      O(n(i))      O(n(i))];
    fill(x, y, 'w')
end


