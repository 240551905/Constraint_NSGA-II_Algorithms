function plotgenSP()
%-------------------MAIN LOOP----------------------------------------------  
opt.objfunction='��������Ż��㷨';                                         % ��Ӧ�ľ���Ĳ��Ժ���
opt = nsga2_basic_parameters(opt);                                         % �Ż��㷨��Ӧ�Ļ�������
G=2000;
opt.trace_1=zeros(1,G);
for i=1:1:G
    %Chromosome=nsga_2_optimization(i*1); 
    opt = nsga2_main(opt,i);
    opt.trace_1(1,i)= size(opt.Chromosome,1);
    i
end
xlswrite('data03.xlsx',opt.trace_1,1);
opt.fig = figure;
plot(1:1:G,opt.trace_1,'*-');
xlabel('��������');
ylabel('��֧������');
title("ʵ��1-��֧���ĸ�������������ı仯");
end