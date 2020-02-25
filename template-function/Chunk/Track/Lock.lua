

    -- GetLockTrackState(TrackChunk);
    -- SetLockTrackState(TrackChunk,state);--0/1







    local function GetLockTrackState(TrackChunk);
        local bracket = 0;
        for var in string.gmatch(TrackChunk,".-\n") do;
        
            if var:match('^%s-%S')=='<'or var:match('^%s-%S')=='>'then;
                bracket = bracket+1;
            end;
            local ret = tonumber(var:match('^%s-LOCK%s+(%d*).-$'));
            if ret then return ret end;
            if bracket >= 2 then return 0 end;
        end;
    end;
    ------------------------
    ------------------------ 
    local function SetLockTrackState(TrackChunk,state);--0/1
        local t,bracket,ret,Write = {},0;
        for var in string.gmatch(TrackChunk..'\n',".-\n") do;
            if var:match('^%s-%S')=='<'or var:match('^%s-%S')=='>'then;
                bracket = bracket+1;
            end;
            if bracket < 2 and not ret then;
                ret = var:match('^%s-LOCK%s+%d');
                if ret then var = var:gsub('LOCK%s+%d','LOCK '..state,1)end;
            end;
            if bracket >= 2 and not ret then break end;
            t[#t+1]=var;
        end;
        ----
        if not ret then;
            t={};
            for var in string.gmatch(TrackChunk..'\n',".-\n") do;
                if not Write then;
                    Write = var:match('NAME.-\n');
                    if Write then;
                        var = var..'LOCK '..state..'\n';
                    end;
                end;
                t[#t+1]=var;
            end;
        end;
        return table.concat(t);
    end;
    
    
