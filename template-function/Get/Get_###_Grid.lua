


----------------------------------------------------------
-- Реагирует на привязку сетки (вкл/выкл)
-- Ищет только видимую сетку

    local function GetPrevNextGridArrange(time,nextPrev);
        local ToggleSnap = reaper.GetToggleCommandStateEx(0,1157);
        local ToggleEnab = reaper.GetToggleCommandStateEx(0,40145);
        if ToggleSnap == 0 or ToggleEnab == 0 then;  
            return time;
        end;
        local val;
        for i = 1,math.huge do;
            val = reaper.SnapToGrid(0,time);
            if nextPrev < 0 then;
                if val<=--[[<]]time then;goto ret;end;time=time-0.0001;
            else;
                if val>--[[>=]]time then;goto ret;end;time=time+0.0001;
            end;
        end;
        ::ret::;
        return val;
    end;

-----------------------------------------------------




-----------------------------------------------------------


-- Не реагирует на привязку сетки (вкл/выкл)
-- Ищет только видимую сетку
-- Arrange


    local function GetPrevNextGridArrange(time,nextPrev);
        local ToggleSnap = reaper.GetToggleCommandStateEx(0,1157);
        if ToggleSnap == 0 then;reaper.Main_OnCommand(1157,0);end;
        local ToggleEnab = reaper.GetToggleCommandStateEx(0,40145);
        if ToggleEnab == 0 then;reaper.Main_OnCommand(40145,0);end;
        local val;
        for i = 1,math.huge do;
            val = reaper.SnapToGrid(0,time);
            if nextPrev < 0 then;
                if val<=--[[<]]time then;goto ret;end;time=time-0.001;
            else;
                if val>--[[>=]]time then;goto ret;end;time=time+0.001;
            end;
        end;::ret::;
        if ToggleSnap == 0 then;reaper.Main_OnCommand(1157 ,0);end;
        if ToggleEnab == 0 then;reaper.Main_OnCommand(40145,0);end;
        return val;
    end;







--**********************************************



    local function GetPrevGrid(pos);
        reaper.Main_OnCommand(40755,0); -- Snapping: Save snap state
        reaper.Main_OnCommand(40754,0); -- Snapping: Enable snap
        if pos > 0 then; 
            local grid = pos;
            local i = 0;
            local posX = pos;
            while (grid >= pos) do;
                pos = pos - 0.0001;
                if pos >= 0.0001 then;
                    grid = reaper.SnapToGrid(0,pos);
                else;
                    grid = 0;
                end;
                i=i+1;
                if i>(2e+5)then;
                   reaper.Main_OnCommand(40756,0); -- Snapping: Restore snap state
                   return posX;
                end;
            end;
            reaper.Main_OnCommand(40756, 0) -- Snapping: Restore snap state  
            return grid;
        end;
        return 0
    end;
    
    -------------------
    
    local function GetNextGrid(pos);
        reaper.Main_OnCommand(40755,0); -- Snapping: Save snap state
        reaper.Main_OnCommand(40754,0); -- Snapping: Enable snap
        local i = 0;
        local posX = pos;
        local grid = pos;
        while (grid <= pos) do;
            pos = pos + 0.0001;
            grid = reaper.SnapToGrid(0,pos);
            i=i+1;
            if i>(2e+5)then;
               reaper.Main_OnCommand(40756,0); -- Snapping: Restore snap state
               return posX;
            end;
        end;
        reaper.Main_OnCommand(40756,0); -- Snapping: Restore snap state
        return grid;
    end;







