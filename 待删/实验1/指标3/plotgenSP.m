clc;close all
N=20;
trace_1=zeros(1,N); 
for i=1:1:N
    Popobj=nsga_2_optimization(i*50); 
    trace_1(1,i)= size(Popobj,1);
    i
end
%xlswrite('data131.xlsx',trace_1,1);
figure(1)
plot(50:50:1000,trace_1,'*-');
xlabel('��������');
ylabel('��֧������');
title("ʵ��1-��֧���ĸ�������������ı仯");