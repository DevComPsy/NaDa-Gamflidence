function [user, params] = presentBlock(user, params, b)

try
%% instructions
clearpict(1);
cgfont(params.general.text.font,20)
preparestring(['Block ' int2str(b) ' of ' int2str(params.task.exp.n_blocks) '.'],1,0,0);
preparestring(['Press Space to start'],1,0,-100);
t_tmp = drawpict(1);
cgfont(params.general.text.font,params.general.text.font_size)
[~,t_tmp] = waitkeydown(inf,params.general.keys.confirm);

%% diary
diary([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '_' int2str(b) '.dry'])

%% start eyetracking
if params.general.eyelink==1
    if Eyelink( 'Initialize' ) ~= 0; return; end % open a connection to the eyetracker PC
    Eyelink( 'Openfile', [int2str(user.ID) '_' int2str(b)] );                % open a file called ###.edf on the eyetracker PC
    Eyelink( 'StartRecording' );        % start recording (to the file)
end

%% instructions
if b == 1
%     presentInstructions(params)
end

%% run games
for g = 1:params.task.exp.n_trialPB
    
    % fixation
    fixation(params,params.task.exp.dur_fix_pre,params.trigger.tr_fix+g);
        
    % run game
    [user, params] = presentTrial(params, user, b, g);
end

%% stop eyetracking
if params.general.eyelink==1
    Eyelink( 'StopRecording' )                   % stop recording
    Eyelink( 'Closefile' )                       % close the file
    Eyelink( 'ReceiveFile' )                     % copy the file from eyetracker PC to Stim PC
    try
        movefile([int2str(user.ID) '_' int2str(b) '.edf'],params.general.res_dir);
    catch
        warning(['not able to move eyetracking file of block' int2str(b) '!']);
    end
end

%% end screen & save
save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '.mat']);
save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '_user_params.mat'],'user','params');


%% block done
if b < params.task.exp.n_blocks
    clearpict(1);
    cgfont(params.general.text.font,20)
    preparestring(['Block finished.'],1,0,0);
    cgfont(params.general.text.font,params.general.text.font_size)
    t_tmp = drawpict(1);
    waituntil(t_tmp+2000);
else
    [user,winning] = getWinnings(user);
    fprintf(['Money won: £ ' num2str(winning,'%.2f') '!\n'])
    clearpict(1);
    cgfont(params.general.text.font,20)
    preparestring(['task finished.'],1,0,30);
    preparestring(['Money won: £ ' num2str(winning,'%.2f') '!'],1,0,-10);
    cgfont(params.general.text.font,params.general.text.font_size)
    t_tmp = drawpict(1);
    waitkeydown(inf)
end

%% exp end: calculate outcome

readkeys
logkeys
diary off

catch exception     % if crashed
    user.warning = exception;
    save([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '.mat']);
    stop_cogent
    exception.rethrow
end