function error = percentErrorOneoutputUnit(resultTarget, orginalTargat)
    num = size(resultTarget);
    num = num(2);
   
    for i = 1:num
        if resultTarget(i) >= 0.5
            resultTarget(i) = 1;
        else
            resultTarget(i) = 0;
        end
    end
    correct_num = 0;
    for i = 1:num
        if resultTarget(i) == orginalTargat(i)
            correct_num = correct_num+1;
        end
    end

    error = (num-correct_num)/num;
end