function [Chromosome,V]=nsga_2_optimization(Generation)
%��֧�������Ŵ��㷨������ģ������Ż�����,����Ŀ���װ������
%rng(qq);
%% ���ò���
Population=600;
%Generation=300;                
Crate = 0.95;                
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
    Parent_Chromosome=tour_selection(f);
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh1=recombin('xovmp',SelCh1,Crate);%���鵥�㽻��
    fv=[[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];[4,5,2,3,3,2,3,3,4,4,4,5,3,6,2,5,4,4,3]];
    %SelCh1=mutbga(SelCh1, fv,Mrate);
    SelCh1=Mut(SelCh1,fv(2,:),Mrate);
    %SelCh1=fix(SelCh1);
    SelCh2= NONLCON(SelCh1);
    Chrom = [Chrom;SelCh2];
    ObjV=fitness(Chrom);
    ObjV_2=fitness(SelCh2);
    x=[Chrom,ObjV];
    x_1=[SelCh2,ObjV_2];
    f = non_domination_sort_mod(x, M, V);
    temp=non_domination(x_1, M, V);
    %��ÿһ�������ķ�֧������temp��
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