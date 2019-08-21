








    ------------------------------------------------------------
    local function DeleteEnvAutoItem(env,Auto_idx)
        reaper.GetSetAutomationItemInfo(env,Auto_idx,"D_POSITION",99^99,1);
        local retval,str = reaper.GetEnvelopeStateChunk(env,"",false);
        for var in str:gmatch(".-\n") do;
            if(tonumber(var:match("POOLEDENVINST%s+%S+%s+(.-)%s.+\n"))or-1) >= 99^98 then var="" end;
            str2=(str2 or "")..var;
        end;
        reaper.SetEnvelopeStateChunk(env,str2,false);
    end;
    ------------------------------------------------------------
