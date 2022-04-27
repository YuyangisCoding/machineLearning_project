function percentError = calcPercentError(resultTarget, realTarget)
[~, length] = size(resultTarget);

newresultTarget = [];
newrealTarget = [];
index = 1;
for i = 1:length
    if ~isnan(resultTarget(1,i))
        newresultTarget(:,index) = resultTarget(:,i);
        newrealTarget(:,index) = realTarget(:,i);    
        index = index+1;
    end
end

[~, new_length] = size(newresultTarget);
resultInd = vec2ind(newresultTarget);
realInd = vec2ind(newrealTarget);
numberofErrors = 0;
for k = 1:new_length
if resultInd(k) ~= realInd(k)
    numberofErrors = numberofErrors+1;
end
end
percentError = numberofErrors/new_length;

end