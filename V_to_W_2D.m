function [W] = V_to_W_2D(V)

global g;

W = zeros(4,1);
W(1) = V(1);
W(2) = V(1)*V(2);
W(3) = V(1)*V(3);
W(4) = V(4)/(g-1) + 0.5*V(1)*(V(2)^2 + V(3)^2);

end

