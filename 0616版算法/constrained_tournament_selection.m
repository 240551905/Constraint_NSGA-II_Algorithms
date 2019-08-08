function [selected_pop]= constrained_tournament_selection(opt, pop, popObj, popCV)

    
    N = opt.N;                                                             % ��Ⱥ��ģ

    %----TOURNAMENT CANDIDATES-------------------------------------------------

    tour1 = randperm(N);                                                   % ������һ��
    tour2 = randperm(N);                                                   % ��������һ��


    %----START TOURNAMENT SELECTION--------------------------------------------


    selected_pop = zeros(N, opt.V);                                        % ��ѡ��ĸ��壬100��6
    for i = 1:N
        p1 = tour1(i);
        p2 = tour2(i);

        if (popCV(p1)<=0 && popCV(p2)<=0)%both are feasible                % ������������嶼�ǿ��н�

            obj1 = popObj(p1,:);
            obj2 = popObj(p2,:);
            d = lex_dominate(obj1, obj2);                                  

            if d == 1                                                      % p1 dominates p2
                selected_pop(i, :) = pop(p1,1:opt.V);
            elseif d == 3                                                  % p2 dominates p1
                selected_pop(i, :) = pop(p2,1:opt.V); 
            else                                                           % d == 2��˵�� a �� b ��Ȼ��֧��
                % check crowding distance���Ƚ�ӵ���Ⱦ���
                if(opt.CD(p1)>opt.CD(p2))                                   
                    selected_pop(i, :) = pop(p1,1:opt.V);
                elseif (opt.CD(p1)<opt.CD(p2))
                    selected_pop(i, :) = pop(p2,1:opt.V);
                else                                                       %randomly pick any solution
                    if(rand <= 0.5) 
                        pick = p1; 
                    else
                        pick = p2; 
                    end
                    selected_pop(i, :) = pop(pick,1:opt.V);
                end
            end
        else                                                               % ��������ǿ��н�
              if(popCV(p1) < popCV(p2))                                      % ���p1��Ӧ��Լ��ֵ��С          
                      selected_pop(i, :) = pop(p1,1:opt.V);                      
              elseif (popCV(p2) < popCV(p1))                                 % ����ѡ��p2
                    selected_pop(i, :) = pop(p2,1:opt.V);                  % p2 has less constraint violation
              else                                                           % randomly pick any solution                          
                    if(rand <= 0.5)                                        % ��� p1=p2,���ѡ��һ���������н���ͱ���
                        pick = p1; 
                    else
                        pick = p2; 
                    end
                selected_pop(i, :) = pop(pick,1:opt.V);                
             end
        end
    end
end 