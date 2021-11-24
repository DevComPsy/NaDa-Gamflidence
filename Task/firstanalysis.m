function firstanalysis(ID)

%resdir = [pwd '/data/'];

resdir = ['/Users/johannahabicht/Documents/work/NaDa Gamfliedence/data/' int2str(ID) '/']

%% load data
list = dir([resdir '*_' int2str(ID) '_user_params.mat']);
dat = load([resdir list.name]);

%% set up Fig
figure('Color','w');
set(gcf,'Unit','centimeters','OuterPosition',[0 0 20 20]);
set(gca,'FontName','Arial','FontSize',12)

%% expected values
ev = [dat.user.log(:,4).*dat.user.log(:,5) dat.user.log(:,6).*dat.user.log(:,7)];
ev(:,3) = ev(:,2) - ev(:,1); % EV diff
ev(:,4) = dat.user.log(:,8); % chosen
ev(:,5) = dat.user.log(:,10);  % confidence

%% choice accuracy
% n_bins = 7;
% bins = linspace(min(ev(:,3)),max(ev(:,3)),n_bins+1);
% idx = [];
% p_right = [];
% for b = 1:n_bins
%     idx{b} = find(ev(:,3)>=bins(b) & ev(:,3)<bins(b+1));
%     p_right(b,1) = mean(ev(idx{b},4)-1);
%     p_right(b,2) = std(ev(idx{b},4)-1)/sqrt(numel(idx{b}));
% end
% 
% subplot(2,2,1)
% errorbar((bins(1:n_bins)+bins(2:end))/2,p_right(:,1),p_right(:,2),'ko');
% xlabel('exp. value difference (right-left)')
% ylabel('prob choose right')

%% choice accuracy, split by conf
medianconf = median(ev(:,5));
n_bins = 7;
bins = linspace(min(ev(:,3)),max(ev(:,3)),n_bins+1);
idx_hc = [];idx_lc = [];
p_right_hc = []; p_right_lc = [];
for b = 1:n_bins
    idx_hc{b} = find(ev(:,3)>=bins(b) & ev(:,3)<bins(b+1) & ev(:,5)>medianconf);
    idx_lc{b} = find(ev(:,3)>=bins(b) & ev(:,3)<bins(b+1) & ev(:,5)<=medianconf);
    p_right_hc(b,1) = mean(ev(idx_hc{b},4)-1);
    p_right_hc(b,2) = std(ev(idx_hc{b},4)-1)/sqrt(numel(idx_hc{b}));
    p_right_lc(b,1) = mean(ev(idx_lc{b},4)-1);
    p_right_lc(b,2) = std(ev(idx_lc{b},4)-1)/sqrt(numel(idx_lc{b}));
end

subplot(2,2,1)
errorbar((bins(1:n_bins)+bins(2:end))/2,p_right_hc(:,1),p_right_hc(:,2),'ko','MarkerFaceColor',[.6 .6 .6]);
hold on
errorbar((bins(1:n_bins)+bins(2:end))/2+30,p_right_lc(:,1),p_right_lc(:,2),'ko','MarkerFaceColor',[0 0 0]);
legend('high conf','low conf','Location','southeast')
xlabel('exp. value difference (right-left)')
ylabel('prob choose right')

%% confidence beh
chosen_val_diff = ev(:,3);
chosen_val_diff(find(ev(:,4)==1)) = -chosen_val_diff(find(ev(:,4)==1));

subplot(2,2,2)
plot(chosen_val_diff,ev(:,5),'k*')
xlabel('exp. value difference (chosen-unchosen)')
ylabel('confidence')

%% total EV of chosen
cEV = [];
cEV(find(ev(:,4)==1)) = ev(find(ev(:,4)==1),1);
cEV(find(ev(:,4)==2)) = ev(find(ev(:,4)==2),2);

subplot(2,2,3)
plot(cEV,ev(:,5),'k*')
xlabel('exp. value chosen')
ylabel('confidence')

%% glm on conf
[~,~,stats] = glmfit([zscore(chosen_val_diff) zscore(cEV')],zscore(ev(:,5)));
[~,~,~,~,stats2] =regress(zscore(ev(:,5)),[ones(length(chosen_val_diff),1) zscore(chosen_val_diff) zscore(cEV')]);

subplot(2,2,4)
patch([0 10 10 0],[1 1 9 9],[1 1 1])
hold on
text(.3,4,['EV difference: t(' num2str(stats.dfe) ')=' num2str(stats.t(2),'%.2f') ', p=' num2str(stats.p(2),'%.3f')]);
text(.3,2,['EV chosen: t(' num2str(stats.dfe) ')=' num2str(stats.t(3),'%.2f') ', p=' num2str(stats.p(3),'%.3f')]);
text(.3,6,['model R2=' num2str(stats2(1),'%.2f') ', F=' num2str(stats2(2),'%.2f') ', p=' num2str(stats2(3),'%.2f')]);
text(.3,8,['effect of values on confidence:']);
axis('off')