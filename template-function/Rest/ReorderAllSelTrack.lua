




   

local function ReorderAllSelTrack( TrackIdx )   
  
    ---------------------------------
    for i = 1, reaper.CountTracks( 0 ) do
        local tr = reaper.GetTrack(0,i-1)
        if (reaper.GetTrackDepth( tr ) == 0) then
           if (reaper.GetMediaTrackInfo_Value( tr, 'I_FOLDERDEPTH')~= 1) then
               reaper.SetMediaTrackInfo_Value( tr, 'I_FOLDERDEPTH',0) 
           end
        end
    end tr = nil  -- http://goo.gl/TH6hxs
    --------------------------------
    local makePrevFolder,cycle = 0,0 
    local track,numb,Depth,SelTrack,tr
    if TrackIdx > 0 then
        track = reaper.GetTrack(0,TrackIdx-1)
        numb = reaper.GetMediaTrackInfo_Value( track, 'IP_TRACKNUMBER')
        Depth = reaper.GetTrackDepth( track )  
        SelTrack = reaper.GetSelectedTrack(0, 0 )  
        if Depth > 0 then
            local retval, flagsOut = reaper.GetTrackState( track ) 
            if flagsOut&1 ~= 1 then --&1=folder
                for i = numb-1, 0, -1 do
                    tr = reaper.GetTrack(0,i)
                    local retval, flagsOut = reaper.GetTrackState( tr )
                    if flagsOut&1 == 1 then break end
                    if SelTrack == tr then makePrevFolder = 2 break end    
                    cycle = cycle + i
                end 
            end
        end 
    else    
        numb = 0
    end  
    if SelTrack then 
        reaper.PreventUIRefresh(789) 
        if SelTrack == tr and cycle == 0  then
            reaper.SetTrackSelected(SelTrack,0)
        end
    end
    reaper.ReorderSelectedTracks(numb ,makePrevFolder)
    if SelTrack then
        reaper.SetTrackSelected(SelTrack,1)
        reaper.PreventUIRefresh(789*0)
    end
end   
















