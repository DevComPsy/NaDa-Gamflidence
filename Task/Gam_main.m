clear all; close all; clc
% addpath('D:\TOOLS\cogent\Toolbox\')
% addpath('C:\myDocuments\work\Tools\cogent\Toolbox\')

%% exp details
try
    [ID, debug] = getIDdlg();
catch
    ID = 999;
    debug = 1;
    warning('no subjectID entered');
end

%% set random seed
try
    RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
catch
    rng('shuffle')
end

%% prepare exp
    % exp settings
    params = Gam_initialize(ID,debug);
    [user,params] = Gam_user_initialize(ID,params);
    
    % check whether logfiles from this subject already exist
    if exist([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '.mat'],'file') > 0
        error('logfile of this subject already exists! Did you enter the wrong subject number?')
    end
    


%% set up & start cogent
config_log([params.general.res_dir int2str(user.date) '_' int2str(user.ID) '.log']);
config_display(params.general.display.mode, params.general.display.resolution, ...
    params.general.display.bg_col, params.general.display.fg_col, ...
    params.general.text.font, params.general.text.font_size, params.general.display.nbuffers);
config_keyboard(params.general.keyboard.quelength, params.general.keyboard.resolution, ...
    params.general.keyboard.mode);
start_cogent

%% practice
presentPractBlock(user, params);

%% run experiment
presentInstructions(params,0);
for b = 1:params.task.exp.n_blocks
    [user, params] = presentBlock(user, params, b);
end 


%% stop cogent
stop_cogent