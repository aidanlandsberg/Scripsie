function [ qnew ] = quatmultiply_f( q, r )
% Calculates the product of two quarternions:
% q01 = quatmultiply_f(q0,q1)
% where q0 and q1 are two individual unit quarternions
qtemp(1) = (r(1)*q(1) - r(2)*q(2) - r(3)*q(3) - r(4)*q(4));
qtemp(2) = (r(1)*q(2) + r(2)*q(1) - r(3)*q(4) + r(4)*q(3));
qtemp(3) = (r(1)*q(3) + r(2)*q(4) + r(3)*q(1) - r(4)*q(2));
qtemp(4) = (r(1)*q(4) - r(2)*q(3) + r(3)*q(2) + r(4)*q(1));

qnew = [qtemp(1) qtemp(2) qtemp(3) qtemp(4)];

end

