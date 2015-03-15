function [ rnew ] = quatrotate_f( q, r )
% This Function calculates the rotated vector rnew, for a quarternion, q, and a vector, r. 
% q is a 1 x 4 vector
% r is a 1 x 3 vector
% The resultant rnew is a 1 x 3 vecctor

q_norm = norm(q);

if q_norm ~= 0
    q = q/q_norm;
end 

% RotMat = [...
%             (1 - 2*q(3)^2 - 2*q(4)^2) 2*(q(2)*q(3) + q(1)*q(4)) 2*(q(2)*q(4) - q(1)*q(3))
%             2*(q(2)*q(3) - q(1)*q(4)) (1 - 2*q(2)^2 - 2*q(4)^2) 2*(q(3)*q(4) + q(1)*q(2))
%             2*(q(2)*q(4) + q(1)*q(3)) 2*(q(3)*q(4) - q(1)*q(2)) (1 - 2*q(2)^2 - 2*q(3)^2)];

RotMat = [...
            (q(2)^2 - q(3)^2 - q(4)^2 + q(1)^2) 2*(q(3)*q(2) - q(4)*q(1)) 2*(q(4)*q(2) + q(3)*q(1))
            2*(q(2)*q(3) + q(4)*q(1)) (-q(2)^2 + q(3)^2 - q(4)^2 + q(1)^2) 2*(q(4)*q(3) - q(2)*q(1))
            2*(q(2)*q(4) - q(3)*q(1)) 2*(q(3)*q(4) + q(2)*q(1)) (-q(2)^2 - q(3)^2 + q(4)^2 + q(1)^2)];
        
rnew = RotMat*r'; 
end

