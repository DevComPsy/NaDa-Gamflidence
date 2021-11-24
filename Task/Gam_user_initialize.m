function [user,params] = Gam_user_initialize(ID,params)


%% user details
user = [];
user.ID                         = ID;
user.date                       = int64(dot(clock,[10^10,10^8,10^6,10^4,10^2,1]));  % YYYYMMDDHHMMSS date
user.warning                    = [];



%% load, shuffle, & fill in trials
tmp = load(params.task.trialsFile);
user.trials = tmp.trials(randperm(length(tmp.trials)));




%% prepare logfile
user.log_desc = {'block','trial','itemNo','ValL','ProbL','ValR','ProbR','chosen','RT','conf','confRT'};
user.log = [];


