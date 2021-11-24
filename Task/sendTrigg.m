function sendTrigg(params,trigger,time)

% parallel port
% outportb(params.trigger.scanport, trigger);

% eyetracker
if params.general.eyelink==1
        Eyelink('Message',[int2str(trigger)]);
end

% logfile
if nargin > 2
    logstring([num2str(time) ': ' int2str(trigger)]);
else
    logstring(int2str(trigger));
end

% parallel port: reset
wait(params.trigger.nulltime);
% outportb(params.trigger.scanport,params.trigger.tr_offset);