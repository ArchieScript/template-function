



    local function SaveSelTracks()
        sel_tracks = {}
        for i = 1, reaper.CountSelectedTracks(0) do
            sel_tracks[i] = reaper.GetSelectedTrack(0, i - 1)
        end
    end
    ---


    local function RestoreSelTracks()
        local tr = reaper.GetTrack(0, 0)
        reaper.SetOnlyTrackSelected(tr)
        reaper.SetTrackSelected(tr, 0)
        ---
        for _, track in ipairs(sel_tracks) do
            reaper.SetTrackSelected(track, 1)
        end
    end

---================================================




    function SaveSelTracksGuid() 
        sel_tracks = {} 
        for i = 1, reaper.CountSelectedTracks(0) do 
            track = reaper.GetSelectedTrack(0, i - 1)
            sel_tracks[i] = reaper.GetTrackGUID( track )
        end 
    end 
    --- 


    function RestoreSelTracksGuid() 
        local tr = reaper.GetTrack(0,0) 
        reaper.SetOnlyTrackSelected(tr) 
        reaper.SetTrackSelected(tr, 0) 
        --- 
        for i = 1, #sel_tracks do
            track = reaper.BR_GetMediaTrackByGUID( 0, sel_tracks[i] )
            if track then
                reaper.SetTrackSelected(track, 1) 
            end
        end  
    end 


--============================================================






    -------SaveSelTracksGuidSlot---------------------------------------------------------
    ------RestoreSelTracksGuidSlot-------------------------------------------------------
    function Arc_Module.SaveSelTracksGuidSlot(Slot);
        local t = {};
        _G[Slot] = t;
        for i = 1, reaper.CountSelectedTracks(0) do;
            local sel_tracks = reaper.GetSelectedTrack(0,i-1);
            t[i] = reaper.GetTrackGUID(sel_tracks);
        end;
    end;
    ---
    function Arc_Module.RestoreSelTracksGuidSlot(Slot,reset);
       local tr = reaper.GetTrack(0,0);
       reaper.SetOnlyTrackSelected(tr);
       reaper.SetTrackSelected(tr, 0);
       ---
       local t = _G[Slot];
       for i = 1, #t do;
           local track = reaper.BR_GetMediaTrackByGUID(0,t[i]);
           if track then;
               reaper.SetTrackSelected(track,1);
           end;
       end;
       if reset == 1 or reset == true then;
           _G[Slot] = nil;
       end;
    end;
    -- SaveSelTracksGuidSlot("Slot_1")
    -- RestoreSelTracksGuidSlot("Slot_1",true)
    -- SaveSelTracksGuidSlot("Slot_2")
    -- RestoreSelTracksGuidSlot("Slot_2",false)
    -- RestoreSelTracksGuidSlot("Slot_2",true)
    --====End===============End===============End===============End===============End====


