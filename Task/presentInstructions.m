function presentInstructions(params,pract)

% determine number of slides
tmp  = dir([params.general.wd_stim 'Instructions\Slide*.JPG']);
n_sl = numel(tmp);
if pract
    n_sl = n_sl-1;
else
    n_sl = 1;
end

% go through slides
InstDone = 0; i = 1;
while ~InstDone
    if i > n_sl
        InstDone = 1;
    else
        % show instruction
        clearpict(1);
        if ~pract
            pic = [params.general.wd_stim 'Instructions\Slide' int2str(numel(tmp)) '.JPG'];
        else
            pic = [params.general.wd_stim 'Instructions\Slide' int2str(i) '.JPG'];
        end
        loadpict( pic, 1, 0, 0);
        t_tmp = drawpict(1);
        [keyout,t_tmp] = waitkeydown(inf,params.general.keys.instr);
        
        % evaluate response
        if keyout == params.general.keys.instr(1) && i > 1
            i = i-1;    % move to previous slide
        elseif keyout == params.general.keys.instr(2)
            i = i+1;    % move to next slide
        end
    end
end
