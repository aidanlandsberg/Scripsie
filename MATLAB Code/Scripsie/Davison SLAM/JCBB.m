%-------------------------------------------------------
function H = JCBB (prediction, observations, compatibility)
% 
%-------------------------------------------------------
global Best;
global configuration;

Best.H = zeros(1, observations.m);
Best.d2 = 10^10;

JCBB_R (prediction, observations, compatibility, [], 1);

H = Best.H;
configuration.name = 'JOINT COMPATIBILITY B & B';

%-------------------------------------------------------
function JCBB_R (prediction, observations, compatibility, H, i)
% 
%-------------------------------------------------------
global Best;
global configuration;

if i > observations.m % leaf node?
    if pairings(H) > pairings(Best.H) % did better?
        Best.H = H;
        Best.d2 = joint_mahalanobis2 (prediction, observations, H);
    elseif (pairings(H) == pairings(Best.H))
        d2 = joint_mahalanobis2 (prediction, observations, H);
        if d2 < Best.d2
           Best.H = H;
           Best.d2 = joint_mahalanobis2 (prediction, observations, H);
        end
    end
else
    individually_compatible = find(compatibility.ic(i,:));
    for j = individually_compatible
        if jointly_compatible(prediction, observations, [H j])
            JCBB_R(prediction, observations, compatibility, [H j], i + 1); %pairing (Ei, Fj) accepted 
        end
    end
    if pairings(H) + pairings(compatibility.AL(i+1:end)) >= pairings(Best.H) % can do better?
       JCBB_R(prediction, observations, compatibility, [H 0], i + 1); % star node: Ei not paired
    end
end

%-------------------------------------------------------
% 
%-------------------------------------------------------
function p = pairings(H)

p = length(find(H));