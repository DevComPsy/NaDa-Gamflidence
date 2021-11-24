function [user, params] = presentTrial(params, user, b, g)

% keyboard
%% clean up stuff
readkeys
logkeys
clearpict(2)    % buffer 2

item_No = (b-1) * params.task.exp.n_trialPB + g;

%% get item values
valL = user.trials(item_No).ValL;
probL = user.trials(item_No).ProbL;
valR = user.trials(item_No).ValR;
probR = user.trials(item_No).ProbR;


%% display options
% left choice
preparestring(['£ ' int2str(valL)],2,params.task.exp.vals_pos(1,1), params.task.exp.vals_pos(1,2));
preparestring([int2str(probL) '%'],2,params.task.exp.prop_pos(1,1), params.task.exp.prop_pos(1,2));

% right choice
preparestring(['£ ' int2str(valR)],2,params.task.exp.vals_pos(2,1), params.task.exp.vals_pos(2,2));
preparestring([int2str(probR) '%'],2,params.task.exp.prop_pos(2,1), params.task.exp.prop_pos(2,2));

%% wait for choice
t_tmp = drawpict(2);
sendTrigg(params,params.trigger.tr_choice_ons,t_tmp);

[keyout,t_tmp2] = waitkeydown(inf,params.general.keys.choice);
readkeys
logkeys
chosen = find(params.general.keys.choice==keyout);
sendTrigg(params,params.trigger.tr_choice+chosen,t_tmp2);
RT_choice = t_tmp2-t_tmp;

%% highlight choice
if chosen == 1
    setforecolour(params.general.display.hlt_col(1),params.general.display.hlt_col(2),params.general.display.hlt_col(3));
    preparestring(['£ ' int2str(valL)],2,params.task.exp.vals_pos(1,1), params.task.exp.vals_pos(1,2));
    preparestring([int2str(probL) '%'],2,params.task.exp.prop_pos(1,1), params.task.exp.prop_pos(1,2));
    setforecolour(params.general.display.fg_col(1),params.general.display.fg_col(2),params.general.display.fg_col(3));
elseif chosen == 2
    setforecolour(params.general.display.hlt_col(1),params.general.display.hlt_col(2),params.general.display.hlt_col(3));
    preparestring(['£ ' int2str(valR)],2,params.task.exp.vals_pos(2,1), params.task.exp.vals_pos(2,2));
    preparestring([int2str(probR) '%'],2,params.task.exp.prop_pos(2,1), params.task.exp.prop_pos(2,2));
    setforecolour(params.general.display.fg_col(1),params.general.display.fg_col(2),params.general.display.fg_col(3));
end
t_tmp3 = drawpict(2);
waituntil(t_tmp2 + params.task.exp.dur_shw_choice);
sendTrigg(params,params.trigger.tr_end_choice,t_tmp3);

%% get confidence
[conf,conf_RT] = get_confidence(params,user);

%% log data
user.log(end+1,:) = [b,g,item_No,valL,probL,valR,probR,chosen,RT_choice,conf,conf_RT];

save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '.mat']);
