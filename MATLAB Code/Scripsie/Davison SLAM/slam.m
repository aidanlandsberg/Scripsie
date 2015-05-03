%-------------------------------------------------------
% University of Zaragoza
% Centro Politecnico Superior
% Robotics and Real Time Group
% Authors:  J. Neira, J. Tardos
% Date   :  7-2006
%-------------------------------------------------------
% slam, explore data association algorithms
%-------------------------------------------------------
clear all;
close all;
randn('state', 0);
rand('state', 0);
addpath 'tools';

% determines execution and display modes
global configuration;

configuration.ellipses = 1;
configuration.tags = 0;
configuration.odometry = 1;
configuration.noise = 1;
configuration.alpha = 0.99;
configuration.step_by_step = 1;
configuration.people = 0;
configuration.ekf_iterations = 4;

% figure numbers
configuration.ground = 1;
configuration.map = 2;
configuration.observations = 3;
configuration.compatibility = 4;
configuration.ground_hypothesis = 5;
configuration.hypothesis = 6;
configuration.tables = 7;

% variables you need in several places
global map ground sensor people chi2 results compatibility;

%chi2 = chi2inv(configuration.alpha,1:1000);
load 'data/chi2';

sensor.range = 3.5;
sensor.maxangle = pi/2;
sensor.minangle = -sensor.maxangle;
sensor.srho = 0.01;
sensor.stita = 0.125*pi/180;

% generate the experiment data
[ground, people] = generate_cloister_experiment;

% start with a fresh map
[map, ground] = new_map(map, ground);

% plot ground
draw_ground(ground);
pause

if configuration.people
    people.x = []; 
    people.y = [];
end

% ok, here we go
step = 1;
observations = get_observations(ground, sensor, step);
draw_observations (observations, ground, step);

% initial features
map = add_features(map, observations, 1);

results.total = [];
results.true.positives = [];
results.true.negatives = [];
results.false.positives = [];
results.false.negatives = [];

GT = zeros(1, observations.m);
H = zeros(1, observations.m);
results = store_results (results, observations, GT, H);

% plot map
configuration.name = '';
draw_map (map, ground, step);

steps = length(ground.motion);
for step = 2 : steps,
    
    disp('--------------------------------------------------------------');
    disp(sprintf('Step: %d', step));
    
    %  EKF prediction step
    [motion, odometry, map] = compute_motion(map, step);
    
    % sense
    observations = get_observations(ground, sensor, step);
    
    %data association
    [H, GT, compatibility] = data_association(map, observations, step);
    
    % update EKF step
    map = EKF_update (map, observations, H);
    
    % only new features with no neighbours
    map = add_new_features (map, observations, step, H);
    
    % map maintenance:
    %
    % map.hits(i): number of times feature i has been observed
    % map.fist(i): step in which feature i was first observed
    %
    % unreliable = "features seen only once, more than two steps ago";
    % map = erase_features(map, unreliable);
    
    draw_map (map, ground, step);
    results = store_results(results, observations, GT, H);
end

show_results(map, ground, results);
