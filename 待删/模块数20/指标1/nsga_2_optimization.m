function [Chromosome,V]=nsga_2_optimization(Generation)
%��֧�������Ŵ��㷨������ģ������Ż�����,����Ŀ���װ������
%rng(qq);
%% ���ò���
Population=100;
%Generation=10000;                
Crate = 0.90;                
Mrate = 0.1;
M=3;%����Ŀ�꺯��
V=19;%16��ģ��
%modules=30;%ģ����
%% ����һ����ʼ��
BaseV=[4,5,2,3,3,2,3,3,4,4,4,5,3,6,2,5,4,4,3];
%Chromp=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],Population,1);   
%[Index,time,cost,Performance,D]=CaseStudy(modules);
%Chrom= NONLCON(Chromp,Index,D,time,cost);
Chrom=Initiative(Population, BaseV);
ObjV1=fitness(Chrom);
x=[Chrom,ObjV1];
f = non_domination_sort_mod(x, M, V);
Chrom = f(:,1:V);
gen=1;
trace=cell(Generation,1);
%% ��ʼ����
while gen<=Generation
    temp=[];
    pool=round(Population/2);
    tour=2;
    Parent_Chromosome1=tournament_selection(f, pool, tour);
    Parent_Chromosome2=tournament_selection(f, pool, tour);
    Parent_Chromosome=[Parent_Chromosome1;Parent_Chromosome2];
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh1=recombin('xovmp',SelCh1,Crate);%���鵥�㽻��
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[4,5,2,3,3,2,3,3,4,4,4,5,3,6,2,5,4,4,3]];
    SelCh1=mutbga(SelCh1, fv,Mrate);
    SelCh1=fix(SelCh1);
    SelCh2= NONLCON(SelCh1);
    Chrom=[Chrom;SelCh2];
    ObjV=fitness(Chrom);
    ObjV_1=fitness(SelCh2);
    x=[Chrom,ObjV];
    x_1=[SelCh2,ObjV_1];
    f = non_domination_sort_mod(x, M, V);
    temp=non_domination(x_1, M, V);
    %��ÿһ�������ķ�֧������temp��
    %temp=f_1(f_1(:,33)==1,1:32);
    trace{gen}=temp;
    f=replace_chromosome(f, M, V,Population);
    Chrom = f(:,1:V);
    %disp(['��',num2str(gen),'��']);
    gen=gen+1;
end
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1,'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end