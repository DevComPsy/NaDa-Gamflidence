% Logistic regression predicting choosing the right option from reward
% magnitude (value), probability and expected value.
% Followed analysis from Hunt et al., 2013

function out = logistic_regression_choice(ID)

list_2=dir(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/*_user_params.mat']);
load(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/' list_2(end).name])

v_diff = zscore(user.log(:,6) - user.log(:,4)); %right - left value
p_diff = zscore(user.log(:,7) - user.log(:,5)); %right - left probability
v_x_p_diff = zscore(user.log(:,6).*user.log(:,7) - user.log(:,4).*user.log(:,5)); % right value*probability minus left value*prob

x = [v_diff, p_diff, v_x_p_diff]; 

y = user.log(:,8) - 1; %left=0, right = 1

%display(ID)
mdl1 = fitglm(x,y,'link','logit','Distribution','binomial'); %predict choice from value, probability and EV difference

out=[ID, transpose(table2array(mdl1.Coefficients(:,1))),mdl1.ModelCriterion.BIC]; %ID, intercept, value, prob, EV

end
