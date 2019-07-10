




    -- Копировать или переместить элемент мультимедиа.
    -- item = какой элемент переместить
    -- track = на какой трек переместить, если трек не указан, то перемесщение произойдет на родительском треке элемента
    -- COPY_MOVE = 0 переместить, = 1 Копировать.

    -- Вернет позицию и новый  элемент при перемещении или позицию и старый при копировании. 
     
     
     
     
     
     
     
    function CopyMoveMediaItem(item, track, time,  COPY_MOVE);        
        local var2;
        local pcal, retval, str = pcall(reaper.GetItemStateChunk,item,"",false);
        if not pcal then;
            error("Media Item expected",2);
        end;
        for var in string.gmatch (str,".-\n") do;
           var = var:gsub("GUID%s-{.-}","GUID "..reaper.genGuid());
           var2 = (var2 or "")..var;
        end;
        ----
        if not pcall(reaper.GetTrackColor,track) then;
            track = reaper.GetMediaItem_Track(item);
        end;
        reaper.PreventUIRefresh(9876);
        local newItem = reaper.CreateNewMIDIItemInProj(track,time,time+0.1,false);
        reaper.SetItemStateChunk(newItem,var2,false);
        reaper.SetMediaItemInfo_Value(newItem,"D_POSITION",time);
        local newPos = reaper.GetMediaItemInfo_Value(newItem,"D_POSITION");
        reaper.PreventUIRefresh(-9876);
        if COPY_MOVE ~= 1 then;
            reaper.DeleteTrackMediaItem(reaper.GetMediaItem_Track(item),item); 
        end;
        return newPos,newItem;          
    end;
    
    
    
    
    
    
    
