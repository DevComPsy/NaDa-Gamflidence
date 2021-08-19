% linear regression predicting the level of confidence using the EV difference
% and the chosen EV as predictors. 

function out = linear_regression_conf(ID)

list_2=dir(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/*_user_params.mat']);
load(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/' list_2(end).name])

% chosen and unchosen EV

for i = 1:length(user.log)
    if user.log(i,8) == 1 % when left is chosen
        chosen_EV(i,1) = user.log(i,4) * user.log(i,5);
        unchosen_EV(i,1) = user.log(i,6) * user.log(i,7);
    else
        chosen_EV(i,1) = user.log(i,6) * user.log(i,7);
        unchosen_EV(i,1) = user.log(i,4) * user.log(i,5);
    end
end

EV_difference = chosen_EV - unchosen_EV;

x = [chosen_EV, EV_difference];
x = zscore(x);
conf = zscore(user.log(:,10));

%display(ID)
mdl = fitglm(x, conf); % linear regression

out=[ID, transpose(table2array(mdl.Coefficients(:,1))),]; %ID, intercept, chosen EV, EV diff

out(:,5) =  corr(chosen_EV, conf);
out(:,6) =  corr(EV_difference, conf);

end