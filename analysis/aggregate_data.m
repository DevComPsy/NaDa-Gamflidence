% function to aggreagte some data from the task

function out = aggregate_data(ID)

list_2=dir(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/*_user_params.mat']);
load(['/Users/johannahabicht/Documents/GitHub/NaDa Gamflidence/data/' int2str(ID) '/' list_2(end).name])

out=[];

out(1,1) = ID;
out(2,1) = (sum(user.log(:,8) == 1)/108)*100; % percentage of left choices
out(3,1) = mean(user.log(:,10)); % average confidence
out(4,1) = std(user.log(:,10)); % variability of confidence
out(5,1) = mean(user.log(:,9)); % RT of choice
out(6,1) = mean(user.log(:,11)); %RT of confidence
out(7,1) = median(user.log(:,10)); %median of confidence

%percentage of no-brainers chosen
out(8,1) = ((length(find(user.log(:,8) == 2 & user.log(:,6) > user.log(:,4) & user.log(:,7) > user.log(:,5))) +...
    length(find(user.log(:,8) == 1 & user.log(:,6) < user.log(:,4) & user.log(:,7) < user.log(:,5))))/...
    (length(find(user.log(:,6) > user.log(:,4) & user.log(:,7) > user.log(:,5))) + length(find(user.log(:,6) < user.log(:,4) & user.log(:,7) < user.log(:,5)))))*100;

%percentage of optimal option chosen
out(9,1) = (length(find(user.log(:,8) == 2 & user.log(:,6).*user.log(:,7) > user.log(:,4).*user.log(:,5))) +...
    length(find(user.log(:,8) == 1 & user.log(:,6).*user.log(:,7) < user.log(:,4).*user.log(:,5))))...
    /(length(find(user.log(:,6).*user.log(:,7) > user.log(:,4).*user.log(:,5))) + length(find(user.log(:,6).*user.log(:,7) < user.log(:,4).*user.log(:,5))))*100;

% choose one with lower prob
out(10,1) = (length(find(user.log(:,8) == 1 & user.log(:,5) < user.log(:,7) & user.log(:,6).*user.log(:,7) > user.log(:,4).*user.log(:,5))) +...
    length(find(user.log(:,8) == 2 & user.log(:,5)>user.log(:,8) & user.log(:,6).*user.log(:,7) < user.log(:,4).*user.log(:,5))))...
    /108*100;

% choose option closer to 50% (uncertainty)
out(11,1) = (length(find(user.log(:,8) == 1 & abs(user.log(:,5) - 50) < abs(user.log(:,7)-50) & abs(user.log(:,5)-50) ~= abs(user.log(:,7)-50)))+...
    length(find(user.log(:,8) == 2 & abs(user.log(:,5) - 50) > abs(user.log(:,7)-50) & abs(user.log(:,5)-50) ~= abs(user.log(:,7)-50))))...
    /(108-length(find(abs(user.log(:,5)-50) == abs(user.log(:,7)-50))))*100;


% chosen and unchosen EV
for i = 1:length(user.log)
         if user.log(i,8) == 1 % when left is chosen
            chosen_EV(i,1) = user.log(i,4) * user.log(i,5);
            unchosen_EV(i,1) = user.log(i,6) * user.log(i,7);
            chosen_value(i,1) = user.log(i,4);
            unchosen_value(i,1) = user.log(i,6);
            chosen_prob(i,1) = user.log(i,5);
            unchosen_prob(i,1) = user.log(i,7);
         else
            chosen_EV(i,1) = user.log(i,6) * user.log(i,7);
            unchosen_EV(i,1) = user.log(i,4) * user.log(i,5);
            chosen_value(i,1) = user.log(i,6);
            unchosen_value(i,1) = user.log(i,4);
            chosen_prob(i,1) = user.log(i,7);
            unchosen_prob(i,1) = user.log(i,5);
         end
end

EV_difference = chosen_EV - unchosen_EV;
value_difference = chosen_value - unchosen_value;
prob_difference = chosen_prob - unchosen_prob;

out(12,1) = corr(EV_difference, user.log(:,10)); % correlation between expected value differnce and confidence
out(13,1) = corr(value_difference, user.log(:,10)); % correlation between reward magnitude difference and confidence
out(14,1) = corr(prob_difference, user.log(:,10)); %correlation between probability difference and confidence

%% how many times they chose the same value  for confidence

c = unique(user.log(:,10)); % the unique values of confidence 
 for i = 1:length(c)
   counts(i,1) = sum(user.log(:,10)==c(i)); % number of times each unique value is repeated
 end
 
out(15,1) = (max(counts)/108)*100; %percentage of how many times they chose the same value of confidence

end