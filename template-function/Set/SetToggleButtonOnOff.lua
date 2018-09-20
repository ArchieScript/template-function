








local function SetToggleButtonOnOff()
    local value,ScriptWay,sec,cmd,mod,res,val = reaper.get_action_context()
    local state = reaper.GetToggleCommandStateEx(sec, cmd) 
    reaper.SetToggleCommandState(sec, cmd, math.abs(state - 1))
    reaper.RefreshToolbar2(sec, cmd)
    return state  
end






function SetToggleButtonOnOff(numb) -- 1 = On ; 0 = Off  
    local value,ScriptWay,sec,cmd,mod,res,val = reaper.get_action_context()
    reaper.SetToggleCommandState( sec, cmd, numb ) 
    reaper.RefreshToolbar2( sec, cmd )
end














