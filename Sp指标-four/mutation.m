function child=mutation(chromosome,pc)
global N V BaseV
%[N,V]=size(chromosome);
i=1;
while i<N
    for j=1:5:V
        if rand<=pc
            chromosome(i,j)=randperm(BaseV(j),1);
        end
    end
    temp=NONLCON_1(chromosome(i,:));
    if ~isempty(temp)                                                       %����õ��Ĳ��ǿ��н⣬����������
       i=i+1; 
    end
end
 child=chromosome;