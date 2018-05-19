   
   
   
   
   
    local mute, track, solo = {}, {}, {} 

    local function SaveSoloMuteStateAllTracks()
        for i = 1, reaper.CountTracks(0) do
            track[i] = reaper.GetTrack(0, i - 1)
            mute[i] = reaper.GetMediaTrackInfo_Value(track[i],'B_MUTE') 
            solo[i] = reaper.GetMediaTrackInfo_Value(track[i],'I_SOLO') 
        end
    end
    ---
    
    
    
    
    local function RestoreSoloMuteStateAllTracks()
        for i = 1, #track do
            reaper.SetMediaTrackInfo_Value(track[i], 'B_MUTE', mute[i])
            reaper.SetMediaTrackInfo_Value(track[i], 'I_SOLO', solo[i]) 
        end
    end 



--============================================================







