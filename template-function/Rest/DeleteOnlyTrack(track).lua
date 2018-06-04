




      --DeleteOnlyTrack(track)
  
      -- При удалении последнего трека в папке не закидывает следующие треки в предыдущую папку (в отличии от reaper.DeleteTrack( track ))




    local function DeleteOnlyTrack(track)
        local fold = reaper.GetMediaTrackInfo_Value( track, 'I_FOLDERDEPTH')
        local numb = reaper.GetMediaTrackInfo_Value( track, 'IP_TRACKNUMBER')
        if fold < 0 then
            local previous_track = reaper.GetTrack(0, numb - 2)
            local pre_folder = reaper.GetMediaTrackInfo_Value( previous_track, 'I_FOLDERDEPTH')
            if pre_folder == 1 then
                reaper.SetMediaTrackInfo_Value( previous_track, 'I_FOLDERDEPTH', 0 )
            elseif pre_folder <= 0 then
                reaper.SetMediaTrackInfo_Value( previous_track, 'I_FOLDERDEPTH', fold )
            end
            reaper.SetMediaTrackInfo_Value( track, 'I_FOLDERDEPTH', 0 )
        end
         reaper.DeleteTrack( track )
    end












