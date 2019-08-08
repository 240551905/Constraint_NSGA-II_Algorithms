%function [Popobj]=nsga_2_optimization(Px,Pc)
%% ��֧�������Ŵ��㷨������ģ������Ż�����
%% ���ò���
global Population Generation M V BaseV N
Population=1000;                                                           %��Ⱥ��ģ
Generation=300;                                                            %��������               
Px=0.9;
Pc=0.01;
%�������
M=3;                                                                       %Ŀ�꺯������
V=29;                                                                      %ģ�����-1
N=1000;
%% ���������ʼ��Ⱥ
BaseV=[3,4,2,3,2,2,3,3,3,4,3,4,3,5,2,4,3,4,2,3,4,5,3,4,5,5,2,2,3];
Chrom=crtbp(Population, BaseV)+repmat([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...%������ʼ��Ⱥ
      1,1,1,1,1,1,1,1,1,1,1,1],Population,1);
gen=1;
trace=cell(Generation,1);
%% ��ʼ����
while gen<=Generation
    intermediate_chromosome=[];
    fixChrom=txx(Chrom);%��ʱ
    Parent_Chromosome=constrained_tournament_selection(fixChrom);
    %Parent_Chromosome=tour_selection(Chrom,ObjV,ConV);                     %��Ԫ������ѡ�񸸴������н���ͱ���                                                                     %���淽ʽ����㽻��
    SelCh=recombine_tp(Parent_Chromosome,Px);  %���㽻��
    %SelCh=Poly_mutation(SelCh,Mrate,V,mum,l_limit,u_limit);               %���췽ʽ������ʽ����
    SelCh1=mutation(SelCh,Pc); 
    %SelCh1=Mut(SelCh,BaseV ,Pc);
    mian_pop=size(Chrom,1);
    offspring_pop=size(SelCh1,1);
    intermediate_chromosome(1:mian_pop,:) = Chrom;
    intermediate_chromosome(mian_pop+1:mian_pop+offspring_pop,:) = SelCh1; %���Ӵ�����͸����������һ��
    %intermediate_chromosome(:,V+1:V+M)=fitness(intermediate_chromosome);   %������Ϻ����Ӧ��ֵ
    %[~,nu]=unique(intermediate_chromosome(:,V+1:V+M),'rows');              %ȥ���ظ��ĸ���
    %chromosome=intermediate_chromosome(nu(1:length(nu)),:);
    %intermediate_chromosome = non_domination_sort_mod(chromosome);   %���з�֧������
    intermediate_chromosome=txx(intermediate_chromosome);
%     Objv1=fitness(SelCh1);
%     x_1=[SelCh1,Objv1];
%     temp=non_domination(x_1);
%     %��ÿһ�������ķ�֧������temp��
%     trace{gen}=temp;
f=replace_chromosome(intermediate_chromosome); %������̣���ѡ����Ⱥ��ģ�ĸ���
Chrom = f(:,1:V);
  Popobj=f(f(:,V+M+1)==1,V+1:V+M);                                       %��֧���Ӧ��Ŀ�꺯��ֵ
    if(M<=3)
        plot3(Popobj(:,1),Popobj(:,2),Popobj(:,3),'ro')
        title(num2str(gen));
        xlabel('����');
        ylabel('ʱ��');
        zlabel('��������');
        drawnow
    end
    gen=gen+1;
end
Popobj=f(f(:,V+M+1)==1,V+1:V+M);
% trace_1=cell2mat(trace);
% [~,nu]=unique(trace_1(:,V+1:M+V),'rows');
% Chrom_1=trace_1(nu(1:length(nu)),:);
% Chromosome= non_domination(Chrom_1);
%end