    
    
    
    
    
    local CLICK = ''
    local CTRL = ''
    local ALT = ''
    local SHIFT = ''
    local CTRL_ALT = ''
    local CTRL_SHIFT = ''
    local SHIFT_ALT = ''
    
    
    local Mouse_State = reaper.JS_Mouse_GetState(127);
    if Mouse_State == 0 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(CLICK),0);
    elseif Mouse_State == 4 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(CTRL),0);
    elseif Mouse_State == 16 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(ALT),0);
    elseif Mouse_State == 8 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(SHIFT),0);
    elseif Mouse_State == 20 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(CTRL_ALT),0);
    elseif Mouse_State == 12 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(CTRL_SHIFT),0);
    elseif Mouse_State == 24 then;
        reaper.Main_OnCommand(reaper.NamedCommandLookup(SHIFT_ALT),0);
    end
    
