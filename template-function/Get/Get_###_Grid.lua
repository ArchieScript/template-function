


----------------------------------------------------------
-- Реагирует на привязку сетки (вкл/выкл)
-- Ищет только видимую сетку


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
-----------------------------------------------------



-- Не реагирует на привязку сетки (вкл/выкл)
-- Ищет только видимую сетку
-- Arrange

    local function GetPreviousGridArrange(time);
        local ToggleSnap = reaper.GetToggleCommandStateEx(0,1157);
        if ToggleSnap == 0 then;reaper.Main_OnCommand(1157,0);end;
        for i = 1,math.huge do;
            local val = reaper.SnapToGrid(0,time);
            if val <= time then
                if ToggleSnap == 0 then;reaper.Main_OnCommand(1157,0);end;return val;
            end;
            time = time-0.001;
        end;
    end;

-----------------------------------------------------------


















