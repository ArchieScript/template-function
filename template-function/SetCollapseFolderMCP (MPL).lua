
 
 
 
 
     -- Author: Michael Pilyavskiy  (mpl)
 
 
 
    function SetCollapseFolderMCP(track, is_show)
        local _,tr_chunk = reaper.GetTrackStateChunk(track,'',true)
        local BUSCOMP_var1 = tr_chunk:match('BUSCOMP (%d+)')
        local tr_chunk_out = tr_chunk:gsub('BUSCOMP '..BUSCOMP_var1..' %d+', 'BUSCOMP '..BUSCOMP_var1..' '..(is_show and 0 or 1))
        reaper.SetTrackStateChunk(track, tr_chunk_out,true)
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
