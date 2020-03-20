print= reaper.ShowConsoleMsg









    local function GetTrackEnabled_State(TrackChunk);
        for var in string.gmatch(TrackChunk,".-\n") do; 
            local ret = tonumber(var:match('^%s-FX%s+(%d+)'));
            if ret then return ret end;
        end;
    end;
    
    
    
    local function SetTrackEnabled_State(TrackChunk,state);
        if state~=0 and state~=1 then state=1 end;
        local t,izm = {};
        for var in string.gmatch(TrackChunk..'\n',".-\n") do;
            local ret = tonumber(var:match('^%s-FX%s+(%d+)'));
            if ret and ret ~= state then;
                var = var:gsub('FX%s+%d+','FX '..state);
                izm = true;
            end;
            t[#t+1] = var
        end;
        return izm or false, table.concat(t);
    end;
