% Script to run the function of linear regression that predicts confidence
% from EV difference and chosen EV

clear all; close all;

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


%% load data - aggregates some data, details in the function
for s = 1:length(sl)
    aggregated_data(s,:) = linear_regression_conf(sl(s));
end


%% plot EV difference and EV choice parameters for all paricipants

sd=[nanstd(aggregated_data(:,3),1),nanstd(aggregated_data(:,4),1)];
SEM=sd/sqrt(length(aggregated_data));
y=[nanmean(aggregated_data(:,3),1),nanmean(aggregated_data(:,4),1)];

c=1:2;
fig = figure();
b = bar(c,diag(y),'stacked');

set(b(1), 'FaceColor',[0.95,0.87,0.73]);
set(b(2),'FaceColor',[0.93,0.84,0.84]);

set(gca,'xticklabel',{'chosen EV'; 'EV diff'},'FontSize',14);
hold on

plot(ones(1,size(aggregated_data(:,3),1)), aggregated_data(:,3)','o','MarkerEdgeColor',[0.70,0.70,0.70], 'MarkerSize',5);
plot(ones(1,size(aggregated_data(:,4),1))+1, aggregated_data(:,4)','o','MarkerEdgeColor',[0.70,0.70,0.70], 'MarkerSize',5);


errorbar(c,y,SEM, 'k.', 'color', 'k', 'CapSize',3, 'Marker', 'none', 'Linewidth', 2)
title('Predictors for confidence', 'FontSize', 17)
