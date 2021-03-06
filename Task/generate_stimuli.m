% based on Laurence's task stimuli (2012 NN; 2013 PLOS CB)
% mod from LH
clear all; close all; clc

%% Laurence's options
vals=round([8 14 11 17 2 14 5 17 2 8 5 11]./2);
probs=[10 10 25 25 40 40 60 60 75 75 90 90];

%% pair
decisionlist=[];

% Make list of all possible decisions
disp('Making decision list...');
for i = 1:length(vals)
  for j = 1:length(vals)
    if i==j
      %do nothing (don't present the same option on both sides)
    elseif vals(i)==vals(j)
      %do nothing (don't present two options of the same value on
      %both sides)
    elseif probs(i)==probs(j)
      %do nothing (don't present two options of the same
      %probability on both sides)
    else 
      decisionlist = [decisionlist; i j]; %include this decision
    end
  end
end

%% shuffle (w flipped positions)
disp('Shuffling decisions...');
items = decisionlist(randperm(length(decisionlist)),:);
% items2 = fliplr(decisionlist(randperm(length(decisionlist)),:));
% items = [items1; items2];

%% fill in probabilities & values
disp('filling in decisions...');
trials = [];
for i = 1:length(items)
    trials(i).ProbL = probs(items(i,1));
    trials(i).ValL = vals(items(i,1));
    trials(i).ProbR = probs(items(i,2));
    trials(i).ValR = vals(items(i,2));
end

%% save
%save('trials_v01.mat','trials')

%%
disp('Done.');