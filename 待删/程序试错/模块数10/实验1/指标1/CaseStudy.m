%% ������ɴ��ģ����
%function [Index,time,cost,Performance,D]=CaseStudy(modules)
%% ���������
rng(1);
%% ���ó�ʼ����
modules=13;%ģ����
%option=3;%��ѡģ��ĸ���
%vb=2;%���ݹ�ϵ
%mb=1;%�ų��ϵ
%% �������ģ��ʵ��
%modules=15+round(5*rand(1));%ģ������
Instances=zeros(1,(modules-1));%ѡ������
for i=1:1:(modules-1)
Instances(1,i)=2+round(3*rand(1));%ģ��ʵ��2-5
end
Index=cumsum(Instances);
bb=Index(end);
%% ���ѡ���ѡģ��
option=randperm(5,1);
optonSelect=randperm((modules-1),option);
%% ʱ�����
time=zeros(1,bb);
for i=1:1:(modules-1)
    if i==1
    time(1,1:Index(i))=2+round(8*rand(Instances(1,i),1));%2-10
    else
        time(1,(Index(i-1)+1):Index(i))=2+round(8*rand(Instances(1,i),1));%2-10
    end
end
time(1,Index(optonSelect))=0.0001;
time(1,end+1)=0;
%% ���þ���
cost=zeros(bb,1);
for l=1:1:(modules-1)
    if l==1
    cost(1:Index(l),1)=5+round(15*rand(Instances(1,l),1));%5-20
    else
        cost((Index(l-1)+1):Index(l),1)=5+round(15*rand(Instances(1,l),1));
    end
end
for j=1:1:bb
    if time(1,j)==0.0001
        cost(j,1)=0;
    end
end
cost(end+1)=0;
Performance=zeros(bb,1);
for p=1:1:(modules-1)
    if p==1
        Performance(1:Index(p),1)=3*rand(Instances(1,p),1);%0-3
    else
        Performance((Index(p-1)+1):Index(p),1)=3*rand(Instances(1,p),1);
    end
end
for j=1:1:bb
    if time(1,j)==0.0001
        Performance(j,1)=0;
    end
end
%temp=sum(Perfermance);
%Perfermance=Perfermance./temp;
Performance(end+1)=0;
%% �ڽӾ���Ĳ���
 D=zeros((modules-1),modules);
 for i=1:1:(modules-1)
     for j=(i+1):1:modules
         if(round(rand(1)*6)==0)
             D(i,j)=1;
         else 
             D(i,j)=0;
         end
        % D(i,j)=round(rand(1));
     end
     D(i,round(rand(1)*(modules-i-1))+i+1)=1;
 end
%% ���ݺ��ų��ϵ
vb=1+round(2*rand(1));
mb=1+round(2*rand(1));
result=randperm((modules-1),(vb+mb)*2);
temp=[];
%% ���ݹ�ϵ
for i=1:1:vb
    p=result(i*2-1);%ģ��
    l=randperm(Instances(result(i*2-1)),1);%ģ��ʵ��
    %temp=[temp;p,l];
    m=result(i*2);%ģ��
    n=randperm(Instances(result(i*2)),1);%ģ��ʵ��
    temp=[temp;p,l,m,n];
end
%% �ų��ϵ
conf=[];
for i=(vb+1):1:(vb+mb)
    k=result(i*2-1);%ģ��
    l=randperm(Instances(result(i*2-1)),1);%ģ��ʵ��
    %conf=[conf;k,l];
    r=result(i*2);%ģ��
    e=randperm(Instances(result(i*2)),1);%ģ��ʵ��
    conf=[conf;k,l,r,e];
end
%end
