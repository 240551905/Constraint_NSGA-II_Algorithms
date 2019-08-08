function [popObj, popCons] = evaluate_pop(opt, pop)

    popObj = zeros(size(pop,1),opt.M);                                     % 100��2           
    if opt.C>0                                                             % opt.C��ʾԼ�������ĸ�������ʱΪ6
        popCons = zeros(size(pop,1),opt.C);                                % 100��6
    else
        popCons = zeros(size(pop,1), 1);                                   % ��Լ����100��1
    end
    sz = size(pop,1);                                                      % ��Ⱥ��ģ
    for i = 1:sz                                                        
        [f, g] = high_fidelity_evaluation(opt, pop(i,:));                  % ����Ŀ�꺯��ֵ��Լ��ֵ
        popObj(i, 1:opt.M) = f;                                            % ��Ŀ�꺯��ֵ��ֵ��popObj
        if opt.C>0                                                         % ����Լ���Ļ�����Լ��ֵ��ֵ��popCons
            popCons(i,:) = g;
        else
            popCons(i,1) = 0;                                              % û�У���Ϊ0
        end
    end

end