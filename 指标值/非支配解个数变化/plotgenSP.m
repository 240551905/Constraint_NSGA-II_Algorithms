clc;close all
N=300;
trace_1=zeros(1,N); 
for i=1:1:N
    Chromosome=nsga_2_optimization(i*1); 
    trace_1(1,i)= size(Chromosome,1);
    i
end
%xlswrite('data131.xlsx',trace_1,1);
figure(1)
plot(1:1:300,trace_1,'*-');
xlabel('��������');
ylabel('��֧������');
title("ʵ��1-��֧���ĸ�������������ı仯");