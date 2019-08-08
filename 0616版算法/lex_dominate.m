function [d] = lex_dominate(obj1, obj2)
    a_dom_b = 0;
    b_dom_a = 0;
    
    
    sz = size(obj1,2);
    for i = 1:sz	                                                       % �ж�ÿ��Ŀ�꺯����ÿ��ά��
        if obj1(i) > obj2(i)                                               % ���Ŀ��1��ĳһ��ά�ȴ���Ŀ��2
            b_dom_a = 1;                                                   % b_dom_a = 1
        elseif(obj1(i) < obj2(i))                                          % ���Ŀ��1��ĳһ��ά��С��Ŀ��2
			a_dom_b = 1;                                                   % a_dom_b = 1;  
        end
        
    end
    
    if(a_dom_b==0 && b_dom_a==0)                                           % ���a_dom_b==0 && b_dom_a==0 ��˵�����������
        d = 2;                                                             % ���a_dom_b==1 && b_dom_a==1��˵��������Ϊ��֧��
    elseif(a_dom_b==1 && b_dom_a==1)
       d = 2; 
    else
        if a_dom_b==1                                                      % a ֧�� b
            d = 1;
        else
            d = 3;                                                         % b ֧�� a
        end
    end        
end