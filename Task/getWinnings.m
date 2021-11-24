function [user,winning] = getWinnings(user)

% select trial
trial = randi(size(user.log,1));

% get chosen items
if user.log(trial,8)==1
    val = user.log(trial,4);
    prob = user.log(trial,5);
elseif user.log(trial,8)==2
    val = user.log(trial,6);
    prob = user.log(trial,7);
end

% gamble
wheel = rand(1);
if wheel <= prob/100
    winning = val;
else
    winning = 0;
end

user.winning = ceil(winning/2);