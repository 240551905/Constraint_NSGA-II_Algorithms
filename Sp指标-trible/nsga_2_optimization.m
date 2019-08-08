function [Chromosome,V]=nsga_2_optimization(Px,Pc)
%% ��֧�������Ŵ��㷨������ģ������Ż�����
%% ���ò���
Population=1000;                                                           %��Ⱥ��ģ
Generation=300;                                                            %��������               
% Px = 0.9;                                                                 %�������
% Pc = 0.1;                                                                 %�������
M=3;                                                                       %Ŀ�꺯������
V=29;                                                                      %ģ�����-1
% l_limit=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];     %���߱����Ͻ�
% u_limit=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];     %���߱����½�
% mum=20;                                                                  %�ֲ�����
%% ���������ʼ��Ⱥ
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=Initiative(Population, BaseV);                                       %������ʼ��Ⱥ
ObjV1=fitness(Chrom);                                                      %�����ʼ��Ⱥ����Ӧ��ֵ
x=[Chrom,ObjV1];                                                              
f = non_domination_sort_mod(x, M, V);                                      %��֧������                                                         %
gen=1;
trace=cell(Generation,1);
%% ��ʼ����
while gen<=Generation
    intermediate_chromosome=[];
    Parent_Chromosome=tour_selection(f,V);                                 %��Ԫ������ѡ�񸸴������н���ͱ���                                                                     %���淽ʽ����㽻��
    SelCh=recombine_tp(Parent_Chromosome,Px);                              %���㽻��
    %SelCh=Poly_mutation(SelCh,Mrate,V,mum,l_limit,u_limit);               %���췽ʽ������ʽ����
    SelCh1=mutation(SelCh,Pc,BaseV);    
    %SelCh1=Mut(SelCh, BaseV,Pc);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh1,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh1; %���Ӵ�����͸����������һ��
    intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);   %������Ϻ����Ӧ��ֵ
    [~,nu]=unique(intermediate_chromosome(:,V+1:V+M),'rows');              %ȥ���ظ��ĸ���
    chromosome=intermediate_chromosome(nu(1:length(nu)),:);
    intermediate_chromosome = non_domination_sort_mod(chromosome, M, V);   %���з�֧������
    Objv1=fitness(SelCh1);
    x_1=[SelCh1,Objv1];
    temp=non_domination(x_1, M, V);
    %��ÿһ�������ķ�֧������temp��
    trace{gen}=temp;
    f=replace_chromosome(intermediate_chromosome, M, V,Population);        %������̣���ѡ����Ⱥ��ģ�ĸ���
    Chrom = f(:,1:V);
%   Popobj=f(f(:,V+M+1)==1,V+1:V+M);                                       %��֧���Ӧ��Ŀ�꺯��ֵ
%     if(M<=3)
%         plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
%         title(num2str(gen));
%         xlabel('����');
%         ylabel('ʱ��');
%         zlabel('��������');
%         drawnow
%     end
    gen=gen+1;
end
%Popobj=f(f(:,V+M+1)==1,V+1:V+M);
trace_1=cell2mat(trace);
[~,nu]=unique(trace_1(:,V+1:M+V),'rows');
Chrom_1=trace_1(nu(1:length(nu)),:);
Chromosome= non_domination(Chrom_1,M,V);
end