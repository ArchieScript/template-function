
-- что бы не оставались пустые тайки


    -- 1 Options: Show empty take lanes (align takes by recording pass)
    -- 2 Options: Allow selecting empty take lanes
    -- 3 Options: Select takes for all selected items when clicking take lane
    local Opt_TakeLaneBehavior1 = reaper.GetToggleCommandStateEx(0,41346);
    local Opt_TakeLaneBehavior2 = reaper.GetToggleCommandStateEx(0,41355);
    local Opt_TakeLaneBehavior3 = reaper.GetToggleCommandStateEx(0,40249);
    if Opt_TakeLaneBehavior1 == 1 then A.Action(41346)end;
    if Opt_TakeLaneBehavior2 == 1 then A.Action(41355)end;
    if Opt_TakeLaneBehavior3 == 1 then A.Action(40249)end;
    
    
    A.Action(40129)--Take: Delete active take from items
    
    
    if Opt_TakeLaneBehavior1 == 1 then A.Action(41346)end;
    if Opt_TakeLaneBehavior2 == 1 then A.Action(41355)end;
    if Opt_TakeLaneBehavior3 == 1 then A.Action(40249)end;
















