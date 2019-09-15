

    local ActiveDoubleScr,stopDoubleScr;
    local extnameProj = ({reaper.get_action_context()})[2];

    local function loop();
        ----- stop Double Script -------
        if not ActiveDoubleScr then;
            stopDoubleScr = (tonumber(reaper.GetExtState(extnameProj,"stopDoubleScr"))or 0)+1;
            reaper.SetExtState(extnameProj,"stopDoubleScr",stopDoubleScr,false);
            ActiveDoubleScr = true;
        end;
        
        local stopDoubleScr2 = tonumber(reaper.GetExtState(extnameProj,"stopDoubleScr"));
        if stopDoubleScr2 > stopDoubleScr then  return  end;
        --------------------------------
        
        -- какой-то код
        
        reaper.defer(loop);
    end;
