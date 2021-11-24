function [conf,conf_RT] = get_confidence(params,user)

conf = nan; conf_RT = nan;

% setup
x_minmax = [-200 200];
respkeys = params.conf.keys; %[params.general.keys.choice(1) params.general.keys.choice(2) params.general.keys.confirm];
keydown = [0; 0; 0]; %no key down right now (vs 1 or 2, 3)

% set up screen
clearpict(2);
cgfont(params.general.text.font,20)
preparestring('1',2,x_minmax(1),params.conf.y_pos_slid-20);
preparestring('10',2,x_minmax(2),params.conf.y_pos_slid-20);
cgfont(params.general.text.font,params.general.text.font_size)

sendTrigg(params,params.trigger.tr_conf);

% start
z=0;
tm_org = 0; tm = 0;
while ~keydown(3) && tm - tm_org <= params.task.exp.dur_conf  % submit not pressed
    
    
    % prepare conf
    preparestring(params.conf.question(1:37),2,0,params.conf.y_pos_quest+10);
    preparestring(params.conf.question(39:end),2,0,params.conf.y_pos_quest-30);
    cgpencol(params.general.display.bg_col);cgellipse(z,params.conf.y_pos_slid,15,15,'f');cgpencol(params.general.text.color);
    cgpenwid(6); cgdraw(x_minmax(1),params.conf.y_pos_slid,x_minmax(2),params.conf.y_pos_slid);cgpenwid(1); 
    cgpenwid(6); cgdraw(x_minmax(1),params.conf.y_pos_slid-5,x_minmax(1),params.conf.y_pos_slid+5);cgpenwid(1); 
    cgpenwid(6); cgdraw(x_minmax(2),params.conf.y_pos_slid-5,x_minmax(2),params.conf.y_pos_slid+5);cgpenwid(1); 
    cgpenwid(6); cgdraw(x_minmax(1)/2,params.conf.y_pos_slid-5,x_minmax(1)/2,params.conf.y_pos_slid+5);cgpenwid(1); 
    cgpenwid(6); cgdraw(x_minmax(2)/2,params.conf.y_pos_slid-5,x_minmax(2)/2,params.conf.y_pos_slid+5);cgpenwid(1); 
    cgpenwid(6); cgdraw(0,params.conf.y_pos_slid-5,0,params.conf.y_pos_slid+5);cgpenwid(1); 
    
    
    % new conf position
    readkeys;
    [key,ktime,nkeypress] = getkeydown(respkeys);
    
    if nkeypress %0, 1 or 2 - key was pressed last - both possible
        if key(end) == respkeys(1)
            keydown(1:2) = [1 0];
        elseif key(end) == respkeys(2)
            keydown(1:2) = [0 1];
        end
        if key(end)==respkeys(end)
            keydown(3) = 1;
        end
%         disp([key(end) keydown(3)])
    end
%     disp(keydown)
    
    [key,ktime,nkeyrelease] = getkeyup(respkeys);
    if nkeyrelease, %key was released
        if key(end) == respkeys(1)
            keydown(1) = 0;
        elseif key(end) == respkeys(2)
            keydown(2) = 0;
        end
    end
%     disp(z)
    if sum(keydown) %at least one button pressed
        if keydown(1) %if both pressed, go left
            z = z - params.conf.pixperkey;
        elseif keydown(2)
            z = z + params.conf.pixperkey;
        end;
    end;
    
    % not beyond end of slider
    if z < x_minmax(1)
        z = x_minmax(1);
    elseif z> x_minmax(2)
        z = x_minmax(2);
    end
    
    % draw new position
%     disp(z)
    cgpencol(params.conf.col); cgellipse(z,params.conf.y_pos_slid,15,15,'f'); cgpencol(params.general.text.color); % draw current
    
    % draw and get time
    tm = drawpict(2);
    if tm_org == 0
        tm_org = tm;
    end
end

sendTrigg(params,params.trigger.tr_end_conf,tm);

conf_RT = tm - tm_org;
conf = ((z-x_minmax(1))/diff(x_minmax))*100;