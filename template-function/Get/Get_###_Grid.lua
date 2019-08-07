








    local function GetPreviousGrid(time);
        for i = 1,math.huge do;
            local val = reaper.SnapToGrid(0,time);
            if val <= time then return val end;
            time = time-0.001;
        end;
    end;
    
    
    
    
    local function GetNextGrid(time);
        for i = 1,100 do --math.huge do;
            local val = reaper.SnapToGrid(0,time);
            if val >= time then return val end;
            time = time+0.001;
        end;
    end;
