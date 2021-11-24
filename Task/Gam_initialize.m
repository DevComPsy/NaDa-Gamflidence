function params = Gam_initialize(userID,debug)

if ~nargin
    userID = 999;
    debug = 0;
end


%% general parameters
params.general.wd                   = pwd;
params.general.wd_stim              = [pwd '\stim\'];    % directory for stimuli
params.general.date                 = clock;
params.general.matlab               = version;
[~, tmp]        = system('hostname');
params.general.computer = cellstr(tmp);
params.general.res_dir              = [pwd '\data\'];

params.general.display.mode         = 1;            % 1: full screen; 2: dual screen
params.general.display.resolution   = 3;            % 3: 1024*768
params.general.display.bg_col       = [.6 .6 .6]; %[153/255 153/255 153/255];
params.general.display.hlt_col      = [0 0 1];      % colour of highlighted choice
params.general.display.fg_col       = [0 0 0];
params.general.display.nbuffers     = 5;            % number of offscreen buffers

params.general.keyboard.quelength   = 100;          % maximum number of key events recorded between calls to READKEYS
params.general.keyboard.resolution  = 1;            % time resolution in ms
params.general.keyboard.mode        = 'nonexclusive';   % 'exclusive': only cogent can access keyboard - needed for good timing

params.general.text.font            = 'Helvetica';
params.general.text.font_size       = 35;
params.general.text.color           = params.general.display.fg_col;


params.general.keys.confirm         = 71;           % space bar
params.general.keys.choice          = [97 98];      % [left right]
params.general.keys.start           = 19;
params.general.keys.instr          = [97 98];      % [left right]

params.general.eyelink              = 0;


%% task parameters
params.task.taskversion             = 'v0.1';
params.task.taskversion_date        = [2017 06 29];
params.task.author                  = 'TUH';
params.task.modifier                = 'TUH';

params.task.trialsFile              = 'trials_v01.mat';

params.task.exp.n_blocks            = 4;
params.task.exp.n_trialPB           = 108/params.task.exp.n_blocks;   % trials per block

params.task.exp.dur_fix_pre         = 1000; % before trial starts
params.task.exp.dur_shw_choice      = 1000;
params.task.exp.dur_conf            = 6000;

params.task.exp.prop_pos            = [-80 -20; 80 -20];    % position of probability [x,y]
params.task.exp.vals_pos            = [-80 20; 80 20];    % position of probability [x,y]


%% confidence
params.conf.y_pos_slid              = -100;
params.conf.y_pos_quest             = 100;
params.conf.col                     = [1 1 0];
params.conf.pixperkey               = 5;
params.conf.question                = 'How confident are you that the choice you made was the right one for you?';   % as in deMartino, 2013, NN
params.conf.keys                    = [97 98 100];


%% output triggers
params.trigger.scanport             = 888;
params.trigger.nulltime             = 10;   % ms

params.trigger.tr_fix               = 100;  % basis to encode specific trial (101-208)
params.trigger.tr_choice_ons        = 80;  % choice onset
params.trigger.tr_choice            = 90;  % basis for pressed button (+1,2)
params.trigger.tr_end_choice        = 99;
params.trigger.tr_conf              = 40;  % basis for pressed button (+1,2)
params.trigger.tr_end_conf          = 49;


params.trigger.tr_offset            = 0;



%% change parameters in debug mode
if debug
    params.general.display.mode         = 0;
    params.general.keyboard.mode        = 'nonexclusive';
end