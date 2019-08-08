function Popobj=nsga_2_optimization(Generation)
%��֧�������Ŵ��㷨������ģ������Ż�����,����Ŀ���װ������
%% ���ò���
Population=1000;
%Generation=30;                
Crate = 0.9;                
Mrate = 0.1;
M=3;%����Ŀ�꺯��
V=29;%16��ģ��
%modules=30;%ģ����
l_limit=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
u_limit=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
%mu=20;
mum=20;
%% ����һ����ʼ��
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=Initiative(Population, BaseV);
ObjV1=fitness(Chrom);
x=[Chrom,ObjV1];
f = non_domination_sort_mod(x, M, V);
Chrom = f(:,1:V);
gen=1;
%trace=cell(Generation,1);
%% ��ʼ����
while gen<=Generation
    intermediate_chromosome=[];
    Parent_Chromosome=tour_selection(f);
    SelCh1=Parent_Chromosome(:,1:V);
    SelCh1=recombin('xovsp',SelCh1,Crate);
    %SelCh1=SBX_Crossover(SelCh1,Crate,V,mu,l_limit,u_limit);
    %fv=[l_limit;u_limit];
    SelCh1=Poly_mutation(SelCh1,Mrate,V,mum,l_limit,u_limit);
    SelCh2= NONLCON(SelCh1);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh2,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh2;
    intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);
    [~,nu]=unique(intermediate_chromosome(:,V+1:V+M),'rows');
    chromosome=intermediate_chromosome(nu(1:length(nu)),:);
    intermediate_chromosome = non_domination_sort_mod(chromosome, M, V);
%      Objv2=fitness(SelCh2);
%      x_2=[SelCh2,Objv2];
%      temp=non_domination(x_2, M, V);
%     %��ÿһ�������ķ�֧������temp��
%      trace{gen}=temp;
    f=replace_chromosome(intermediate_chromosome, M, V,Population);
    Chrom = f(:,1:V);
    %Popobj=f(f(:,V+M+1)==1,V+1:V+M);
%     if(M<=3)
%         plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
%         title(num2str(gen));
%         drawnow
%     end
    %disp(['��',num2str(gen),'��']);
    gen=gen+1;
end
Popobj=f(f(:,V+M+1)==1,V+1:V+M);
% trace_1=cell2mat(trace);
% [~,nu]=unique(trace_1(:,V+1:M+V),'rows');
% Chrom_1=trace_1(nu(1:length(nu)),:);
% Chromosome= non_domination(Chrom_1,M,V);
end