function child=mutation(chromosome,pc)
global N V BaseV
%[N,V]=size(chromosome);
i=1;
for i=1:1:N
    for j=1:5:V
        if rand<=pc
            chromosome(i,j)=randperm(BaseV(j),1);
        end
    end
    %temp=NONLCON_1(chromosome(i,:));
    %if ~isempty(temp)                                                       %����õ��Ĳ��ǿ��н⣬����������
    %end
end
 child=chromosome;