



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
