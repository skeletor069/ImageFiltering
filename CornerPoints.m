function [ Mc ] = CornerPoints(W, Q)
tw = 0.004;
tq = 0.5;
dimension = size(W);
Mc = zeros(dimension);
for i=1:dimension(1)
    for j=1:dimension(2)
        if W(i,j) > tw && Q(i,j) > tq
            Mc(i,j) = 1;
        end
    end
end

end

