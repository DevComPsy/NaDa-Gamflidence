% plot average confidence over trials

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


%% plot confidence for all participants

confidence=[];

for s = 1:length(sl)
    list=dir(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(sl(s)) '/*_user_params.mat']);
    load(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(sl(s)) '/' list(end).name]);
    confidence(s,:) = transpose(user.log(:,10));
end

fig = figure('Color', 'w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 25 15]);
set(gca,'FontName','Arial','FontSize',10)

ms= 2; 
plot(mean(confidence),'color', [0.76,0.87,0.78],'LineWidth',ms); % confidence


%% plot confidence for groups

drug = readtable('/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/anonymised demographics.csv');
drug =table2array(drug(:,1:2));

group1 = confidence(drug(:,2)==0,:); %placebo
group2 = confidence(drug(:,2)==1,:); %prop
group3 = confidence(drug(:,2)==2,:); %ami


fig = figure('Color', 'w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 25 15]);
set(gca,'FontName','Arial','FontSize',10)

ms= 2; 
plot(mean(group1),'color', [0.76,0.87,0.78],'LineWidth',ms); 
hold on
plot(mean(group2),'color', 'b','LineWidth',ms); % confidence
plot(mean(group3),'color', [0.4,0.3,0.78],'LineWidth',ms); % confidence
legend({'placebo'; 'propranolol';'amisulrpide'},'FontSize', 17);
