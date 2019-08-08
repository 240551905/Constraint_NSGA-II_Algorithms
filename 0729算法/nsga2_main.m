%% This is main function that runs NSGA-II procedure
function opt = nsga2_main(opt,px,pm)

    %% ------------INITIALIZE------------------------------------------------
    opt.pop = lhsamp_model(opt.N, opt);                                    % ������ʼ��Ⱥ
    
    %% ------------EVALUATE--------------------------------------------------
    [opt.popObj, opt.popCons] = evaluate_pop(opt, opt.pop);                % ������Ⱥ��Ŀ�꺯��ֵ��Լ��ֵ
    %opt.popCV = evaluateCV(opt.popCons);  
    opt.popCV = sum(opt.popCons, 2);                                       % �����������Լ��ֵ���ܺ�
    %opt.archiveObj = opt.popObj;                                           % to save all objectives
    
    %% -------------------PLOT INITIAL SOLUTIONS-----------------------------
%     opt.fig = figure;
%     plot_population(opt, opt.popObj);                                      % ����ǰ�Ľ⼯
    
    
    %% --------------- OPTIMIZATION -----------------------------------------
    
    gen = 1;
    while gen < opt.G                                                      % opt.G =200����������

        opt = mating_selection(opt);%--------Mating Parent Selection-------% ��Ԫ������ѡ��
        opt = crossover(opt,px);%-------------------Crossover-----------------% ����
        opt = mutation(opt,pm);%--------------------Mutation------------------% ����
        
        
        %---------------EVALUATION-----------------------------------------
        [opt.popChildObj, opt.popChildCons] = evaluate_pop(opt, opt.popChild);% �����Ӵ���Ӧ��Ŀ�꺯����Լ��ֵ
        %opt.popCV = evaluateCV(opt.popCons);                               % ���㸸����Ӧ��Լ��ֵ
        opt.popCV = sum(opt.popCons, 2);
        %opt.popChildCV = evaluateCV(popChildCV);                          % �����Ӵ���Ӧ��Լ��ֵ
        opt.popChildCV = sum(opt.popChildCons, 2);
        
        
        
        %---------------MERGE PARENT AND CHILDREN--------------------------% horzcat()ˮƽ��������
        opt.totalpopObj = vertcat(opt.popChildObj, opt.popObj);            % vertcat()��ֱ�������飬���Ӵ��͸�����Ŀ�꺯����ֱ����
        opt.totalpop = vertcat(opt.popChild, opt.pop);                     % ���Ӵ�����͸������崹ֱ����
        opt.totalpopCV = vertcat(opt.popChildCV, opt.popCV);               % ��ÿ���Ӵ��͸�����Լ��������ֵ��Ӵ�ֱ����
        opt.totalpopCons = vertcat(opt.popChildCons, opt.popCons);         % ���Ӵ��͸�����Լ������ֵ��ֱ����
        %-----------------��ÿһ���ķ�֧��ⴢ������-------------------------
        [opt.tracepop, opt.tracepopObj] = calculate_feasible_paretofront(opt, opt.totalpop, opt.totalpopObj, opt.totalpopCV);
        opt.trace{gen}=horzcat(opt.tracepop, opt.tracepopObj);
        %-----------------SURVIVAL SELECTION-------------------------------
        opt = survival_selection(opt);                                      %������̣��Ӹ������Ӵ���ѡ��N������
        gen = gen + 1;
        
        %opt.popCV = evaluateCV(opt.popCons);
        opt.popCV = sum(opt.popCons, 2);
        %opt.archiveObj = vertcat(opt.archiveObj,opt.popObj);
        
        
        %-------------------PLOT NEW SOLUTIONS----------------------------- 
%         if mod(gen,100)==0
%             disp(gen);
%             plot_population(opt, opt.tracepopObj);
%         end
    end
    
%----------------------RETURN VALUE----------------------------------------
     %[opt.pop, opt.popObj] = calculate_feasible_paretofront(opt, opt.pop, opt.popObj, opt.popCV);
%     opt.fig = figure;
%     plot_population(opt, opt.popObj);
V=opt.V;
M=opt.M;
opt.totaltrace=cell2mat(opt.trace);
[~,nu]=unique(opt.totaltrace(:,V+1:M+V),'rows');
Chrom=opt.totaltrace(nu(1:length(nu)),:);
opt.Chromosome= non_domination(opt,Chrom);
end                                                                        
%------------------------------END OF -FILE--------------------------------