% Logistic regression predicting choosing the option on the right hand side. 
% Predictors are difference in value, probability and EV 
% Figure 2

clear all;close all;

addpath('/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence');
data_dir='/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/';

list = dir(data_dir);
sl = [];
for i = 1:length(list)
    try
        sl = [sl str2num(list(i).name)];
    end
end

aggregated_data=[];


%% load data - performs logistic regression
for s = 1:length(sl)
    aggregated_data(s,:) = logistic_regression_choice(sl(s));
end
   
%% plot the data (all participant together, Fig 2A)

sd=[nanstd(aggregated_data(:,3),1),nanstd(aggregated_data(:,4),1),nanstd(aggregated_data(:,5),1)];
SEM=sd/sqrt(length(aggregated_data));
y=[nanmean(aggregated_data(:,3),1),nanmean(aggregated_data(:,4),1),nanmean(aggregated_data(:,5),1)];

c=1:3;
fig = figure('Color', 'w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 16 16]);
set(gca,'FontName','Arial','FontSize',10)
b = bar(c,diag(y),'stacked');

set(b(1), 'FaceColor',[00.76,0.87,0.78]);
set(b(2),'FaceColor',[0.86,0.86,0.86]);
set(b(3),'FaceColor',[0.73,0.83,0.96]);

set(gca,'xticklabel',{; 'value'; 'probability'; 'EV'},'FontSize',16);
ylim([-5 23])
hold on

dp1 = scatter(ones(1,size(aggregated_data(:,3),1)), aggregated_data(:,3)',18,[00.65,0.65,0.65], 'filled'); alpha(dp1,0.4);
dp2 = scatter(ones(1,size(aggregated_data(:,4),1))+1, aggregated_data(:,4)',18,[00.65,0.65,0.65], 'filled'); alpha(dp2,0.4);
dp3 = scatter(ones(1,size(aggregated_data(:,5),1))+2, aggregated_data(:,5)',18,[00.65,0.65,0.65], 'filled');alpha(dp3,0.4);


errorbar(c,y,SEM, 'k.', 'color', 'k', 'CapSize',2.4, 'Marker', 'none', 'Linewidth', 1.7)
title('Predictors for choosing option on the right', 'FontSize', 20)
ylabel('effect size (au)','FontSize', 20)

%% plot between groups (Fig 2B)

drug = readtable('/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/anonymised demographics.csv');
drug =table2array(drug(:,1:2));

group1 = aggregated_data(drug(:,2)==0,:); %placebo
group2 = aggregated_data(drug(:,2)==1,:); %prop
group3 = aggregated_data(drug(:,2)==2,:); %ami

value_average = [nanmean(group1(:,3),1), nanmean(group2(:,3),1), nanmean(group3(:,3),1)];
value_SEM = [(nanstd(group1(:,3),1)/sqrt(length(group1))), (nanstd(group2(:,3),1)/sqrt(length(group2))), (nanstd(group3(:,3),1)/sqrt(length(group3)))];

prob_average = [nanmean(group1(:,4),1), nanmean(group2(:,4),1), nanmean(group3(:,4),1)];
prob_SEM = [(nanstd(group1(:,4),1)/sqrt(length(group1))), (nanstd(group2(:,4),1)/sqrt(length(group2))), (nanstd(group3(:,4),1)/sqrt(length(group3)))];

EV_average = [nanmean(group1(:,5),1), nanmean(group2(:,5),1), nanmean(group3(:,5),1)];
EV_SEM = [(nanstd(group1(:,5),1)/sqrt(length(group1))), (nanstd(group2(:,5),1)/sqrt(length(group2))), (nanstd(group3(:,5),1)/sqrt(length(group3)))];


all_SEM=[value_SEM; prob_SEM; EV_SEM];
all_average= [value_average; prob_average; EV_average];

c=1:3;
fig = figure('Color', 'w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 16 16]);
set(gca,'FontName','Arial','FontSize',10)
b=bar(c,all_average, 'FaceColor','flat');


b(1).CData(1,:) = [0.95,0.97,0.95]; %1st bard
b(2).CData(1,:) = [0.76,0.87,0.78];
b(3).CData(1,:) = [0.23,0.44,0.34];

b(1).CData(2,:) = [0.97,0.97,0.97];
b(2).CData(2,:) = [0.86,0.86,0.86];
b(3).CData(2,:) = [0.49,0.49,0.49];

b(1).CData(3,:) = [0.96,0.98,0.99];
b(2).CData(3,:) = [0.73,0.83,0.96];
b(3).CData(3,:) = [0.39,0.47,0.64];


set(gca,'xticklabel',{'magnitude'; 'probability'; 'EV'},'FontSize',16);
ylim([-5 23]);
hold on


dp1 = scatter(ones(1,size(group1(:,3),1))-0.22, group1(:,3)',18,[0.6,0.6,0.6], 'filled'); alpha(dp1,0.4);
dp2 = scatter(ones(1,size(group2(:,3),1)), group2(:,3)',18,[0.6,0.6,0.6], 'filled'); alpha(dp2,0.4); 
dp3 = scatter(ones(1,size(group3(:,3),1))+0.22, group3(:,3)',18,[0.6,0.6,0.6], 'filled'); alpha(dp3,0.4);

dp4 = scatter(ones(1,size(group1(:,4),1))+0.78, group1(:,4)',18,[0.6,0.6,0.6], 'filled'); alpha(dp4,0.4);
dp5 = scatter(ones(1,size(group2(:,4),1))+1, group2(:,4)',18,[0.6,0.6,0.6], 'filled'); alpha(dp5,0.4); 
dp6 = scatter(ones(1,size(group3(:,4),1))+1.22, group3(:,4)',18,[0.6,0.6,0.6], 'filled'); alpha(dp6,0.4);

dp7 = scatter(ones(1,size(group1(:,5),1))+1.78, group1(:,5)',18,[0.6,0.6,0.6], 'filled'); alpha(dp7,0.4);
dp8 = scatter(ones(1,size(group2(:,5),1))+2, group2(:,5)',18,[0.6,0.6,0.6], 'filled'); alpha(dp8,0.4); 
dp9 = scatter(ones(1,size(group3(:,5),1))+2.22, group3(:,5)',18,[0.6,0.6,0.6], 'filled'); alpha(dp9,0.4);


hold on
err1=errorbar(c-0.22,all_average(:,1),all_SEM(:,1),'k.', 'color', 'k', 'CapSize',2.4, 'Marker', 'none', 'Linewidth', 1.5);
err2=errorbar(c,all_average(:,2),all_SEM(:,2),'k.', 'color', 'k', 'CapSize',2.4, 'Marker', 'none', 'Linewidth', 1.5);
err3=errorbar(c+0.22,all_average(:,3),all_SEM(:,3),'k.', 'color', 'k', 'CapSize',2.4, 'Marker', 'none', 'Linewidth', 1.5);

legend({'placebo'; 'propranolol';'amisulrpide'},'FontSize', 17);
title('Predictors for choosing option on the right', 'FontSize', 20)
ylabel('effect size (au)','FontSize', 20)
