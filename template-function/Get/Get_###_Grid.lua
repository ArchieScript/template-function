


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















