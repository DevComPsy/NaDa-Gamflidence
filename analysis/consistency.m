% Function to aggragte data for choice consistency and change of mind

function out = consistency(ID)

list_2=dir(['/Users/johannahabicht/Library/Mobile Documents/com~apple~CloudDocs/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/*_user_params.mat']);
load(['/Users/johannahabicht/Library/Mobile Documents/com~apple~CloudDocs/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/' list_2(end).name])

options = [user.log(:,4:7)]; 
chosen = user.log(:,8);
conf = user.log(:,10);


% find 2 trials that have the same choice and find whether they pick the
% same option or different (1 = same, 0 = change)

As = sort(options, 2);
Au = unique(As, 'rows');

for i = 1:54

    index = and(any(options == Au(i,1),2), any(options == Au(i,2),2)); 
    index2 = and(any(options == Au(i,3),2), any(options == Au(i,4),2));
    index_all = and(any(index ==1,2),any(index2==1,2)); %find trial indeces that have the same values
    
    picked = chosen(find(index_all==1));
    conf_picked = conf(find(index_all==1));
    values = options(index_all==1,:);
  
    if picked(1,1) == picked(2,1)
        choices(i,1) = 0; % different choices
        conf_reversal(i,1) = conf_picked(1,1);
        conf_same(i,1) = nan;
        EV_diff(i,1) = abs(values(1,1)*values(1,2) - values(1,3)*values(1,4));
        conf_initial(i,1) = conf_picked(1,1);
        conf_second(i,1) = conf_picked(2,1);
    else
        choices(i,1) = 1; % same choice (as the options are swapped they souldn't be equal)
        conf_same(i,1) = conf_picked(1,1);
        conf_reversal(i,1) = nan;
        EV_diff(i,1) = abs(values(1,1)*values(1,2) - values(1,3)*values(1,4));
        conf_initial(i,1) = conf_picked(1,1);
        conf_second(i,1) = conf_picked(2,1);
    end
    
end

out(1,1) = ID;
out(1,2) = (sum(choices)/54)*100; %the percentage of choosing the same choice
out(1,3) = nanmean(conf_same); %initial confidence of a trial where same option chosen on 2nd trial
out(1,4) = nanmean(conf_reversal); %initial confidence of a trial where reversal option chosen on 2nd trial



%% logistic regression predicting reversal from absolute EV_diff and initial confidence

conf_initial = zscore(conf_initial);
EV_diff = zscore(EV_diff);
reversal = abs(choices - 1);

mdl1 = fitglm([conf_initial, EV_diff],reversal,'link','logit','Distribution','binomial'); 

out(1,5:7) =transpose(table2array(mdl1.Coefficients(:,1))); %intercept, initial confidence, EV difference

end