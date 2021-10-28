% Aggregate data to find choice consistency and change of mind

clear all;close all;

addpath('/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/');
data_dir='/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/';

list = dir(data_dir);
sl = [];
for i = 1:length(list)
    try
        sl = [sl str2num(list(i).name)];
    end
end

aggregated_data=[];

%% load data, perform consistency function
for s = 1:length(sl)
    aggregated_data(s,:) = consistency(sl(s)); % see the function to find the meaning of each column 
end