
function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F  
    case 'F1'
        fobj = @F1;
        %lb=[0.0001 0.0001 0 0 -50];%ÿ��������Сֵ
        %ub=[1 50 50 50 50];
        lb=[0 0 0];%ÿ��������Сֵ -c -p -e
        ub=[1000 100 1];
        dim=3;
end

end

function o = F1(x)
    o=LinearSVR(x,1);
end