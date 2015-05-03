% SLAM 2D (Simultaneous Localization and Mapping)
% 
% Map:
%   x : state vector with,
%       x(r) : robot pose   = (px,py,alpha)'
%       x(l(i,:)): landmark # i = [xi yi]'
%
%       ex: x = [x(r) x(l1) x(l2) x(l3) x(l5)]
%
%   P: covariance matrix
%
%   mapspace: [1 2 3 4 5 ... N]
%
%   querying map space: s = find(mapspace,size)
%   reserve map space : mapspace(s) = 0;
%   free map space    : mapspace(s) = s;
%
%
% EKF:
%
%   Prediction: when the robot moves
%   Corection : when robot makes a measurement of  already mapped lmks
%   Initialize: at the discovery og new lmks
%   (repaprameterization): to change lmk nature
%   (deletion): to remove bad lmks
%   
% Functions:   
%   robot motion:    f() - x+ = f(x,u,n) |     x(r)+ = f(x(r), u. n)
%                                                F_x = [F_r 0; 0 1]
%   lmk observation: h() - y  = h(x) + v |     y     = h(x(r), x(l(i,:)))
%                                                  H = [H_r 0 H_i 0]
%   back-projection: g() - x+ = g(x,y)   | x(l(i,:)) = g(x(r),y)
%                                                  G = [I 0 0; 0 I 0; G_r 0 0]
%
% Frame transforms: [l_r, LR_r LR_l] = toFrame(x(r), x(l(i,:)))
%                                    = toFrame(R, L)
%                                    @ lmk measurement
%
%                   [l_r, LR_r LR_l] = fromFrame(R, L)
%                                    @ lmk initialization
%
%
%
%
%
%
%
%
%
%
%
