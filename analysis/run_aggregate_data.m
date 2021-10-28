%Aggregate behavioural measures to control for performance (such as 
%averages, confidence, uncertainty etc). See the function file for more
%details on the measures.

clear all;close all;
addpath('/Users/johannahabicht/Library/Mobile Documents/com~apple~CloudDocs/Documents/GitHub/NaDa Gamflidence');
data_dir='/Users/johannahabicht/Library/Mobile Documents/com~apple~CloudDocs/Documents/GitHub/NaDa Gamflidence/data/';

list = dir(data_dir);
sl = [];
for i = 1:length(list)
    try
        sl = [sl str2num(list(i).name)];
    end
end

aggregated_data=[];

%% load data - aggregates some data, details in the function
for s = 1:length(sl)
    aggregated_data(s,:) = aggregate_data(sl(s));
end
