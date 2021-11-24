function fixation(params,dur,trigger)

% clean up stuff
readkeys
logkeys
clearpict(1)
% pic = [params.general.wd_stim 'fixation.png'];
% loadpict( pic, 1, params.task.exp.pic_pos(1), params.task.exp.pic_pos(2));

settextstyle(params.general.text.font,30);
preparestring( '+', 1, 0, 0);
settextstyle(params.general.text.font,params.general.text.font_size);

% show
t_tmp = drawpict( 1 );
sendTrigg(params,trigger,t_tmp);

% wait
waituntil(t_tmp + dur);