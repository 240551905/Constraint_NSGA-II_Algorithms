function main()
%-------------------MAIN LOOP----------------------------------------------  
    opt.objfunction='��������Ż��㷨';                                     % ��Ӧ�ľ���Ĳ��Ժ���
    opt = nsga2_basic_parameters(opt);                                     % �Ż��㷨��Ӧ�Ļ�������
    opt.parater=zeros(opt.N1,opt.N2);
    temp=zeros(opt.N1,opt.N2);
    for k=1:1:opt.iter
        for i=1:1:opt.N1
            for j=1:1:opt.N2
                opt = nsga2_main(opt,0.5+0.1*(i-1),(j-1)*0.01);
                Distance = pdist2(opt.Chromosome,opt.Chromosome,'cityblock');
                Distance(logical(eye(size(Distance,1)))) = inf;
                temp(i,j)= std(min(Distance,[],2));
            end
        end
        k
        %xlswrite('data111.xlsx',temp,k);
        opt.parater=opt.parater+temp;
    end
    opt.parater=opt.parater./opt.iter;
    xlswrite('data01.xlsx',opt.parater,1);
    %------------------------���ӻ�----------------------------------------
    opt.fig = figure;
    bar3(opt.parater');
    xbins=0.5:0.1:1;
    ybins=0:0.01:0.1;
    %zbins=0:1:36;
    set(gca,'XTickLabel',xbins);
    set(gca,'YTickLabel',ybins);
    %set(gca,'ZTickLabel',zbins);
    %zlim([1,36]);
    %%
    xlabel('�������');
    ylabel('�������');
    zlabel('Spcingֵ');
    title('������ʺͱ�����ʶ�Spcingֵ��Ӱ��');
end
%------------------------------END OF -FILE--------------------------------