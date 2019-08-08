function [Chromosome,V]=nsga_2_optimization(Crate,Mrate )
%��֧�������Ŵ��㷨������ģ������Ż�����,����Ŀ���װ������
%% ���ò���
Population=600;
Generation=500;                
%Crate = 0.9;                
%Mrate = 0.1;
M=3;%����Ŀ�꺯��
V=29;%16��ģ��
%modules=4;%ģ����
%% ����һ����ʼ��
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
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
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3]];
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
[~,nu]=unique(trace_1(:,V+1:V+M),'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end