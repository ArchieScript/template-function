








local function SetSoloMuteAllTracks(valSolo,valMute)--0,1; 
    for i = 1,reaper.CountTracks(0)do
        track = reaper.GetTrack( 0, i-1 )
        if valSolo then reaper.SetMediaTrackInfo_Value(track,'I_SOLO',valSolo)end
        if valSolo then reaper.SetMediaTrackInfo_Value(track,'B_MUTE',valMute)end
    end
end














