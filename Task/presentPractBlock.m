function [user, params] = presentPractBlock(user, params)

try
%% instructions
clearpict(1);
cgfont(params.general.text.font,20)
preparestring(['practice'],1,0,0);
preparestring(['Press Space to start'],1,0,-100);
t_tmp = drawpict(1);
cgfont(params.general.text.font,params.general.text.font_size)
[~,t_tmp] = waitkeydown(inf,params.general.keys.confirm);


%% instructions
presentInstructions(params,1)

%% random items
idx = randperm(params.task.exp.n_blocks*params.task.exp.n_trialPB);

%% run games
for g = 1:10
    
    % fixation
    fixation(params,params.task.exp.dur_fix_pre,params.trigger.tr_fix+g);
        
    % run game
%     disp([floor(idx(g)/params.task.exp.n_trialPB), mod(idx(g),params.task.exp.n_trialPB)])
    [user, params] = presentTrial(params, user, max([floor(idx(g)/params.task.exp.n_trialPB),1]), max([mod(idx(g),params.task.exp.n_trialPB),1]));
end



%% end screen & save
save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '_pract.mat']);


%% block done
clearpict(1);
cgfont(params.general.text.font,20)
preparestring(['Practice finished.'],1,0,0);
cgfont(params.general.text.font,params.general.text.font_size)
t_tmp = drawpict(1);
waituntil(t_tmp+2000);

catch exception     % if crashed
    user.warning = exception;
    save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '_pract.mat']);
    stop_cogent
    exception.rethrow
end