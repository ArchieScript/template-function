




    -- Копировать или переместить элемент мультимедиа.
    -- COPY_MOVE = 0 переместить, = 1 Копировать.
    -- Вернет время и новый  элемент при перемещении или время и старый при копировании. 
     
     
     
     
     
     
     
    function CopyMoveMediaItem(item, time, COPY_MOVE);        
        local var2;
        local retval, str = reaper.GetItemStateChunk(item,"",false);
        for var in string.gmatch (str,".-\n") do;
           var = var:gsub("GUID%s-{.-}","GUID "..reaper.genGuid());
           var2 = (var2 or "")..var;
        end;
        ----
        if COPY_MOVE == 1 then; --1copy
            reaper.PreventUIRefresh(9876);
            local It_Track = reaper.GetMediaItem_Track(item);
            local newItem = reaper.CreateNewMIDIItemInProj(It_Track,time,time+0.1,false);
            reaper.SetItemStateChunk(newItem,var2,false);
            reaper.SetMediaItemInfo_Value(newItem,"D_POSITION",time);
            reaper.PreventUIRefresh(-9876);
            local newPos = reaper.GetMediaItemInfo_Value(newItem,"D_POSITION");
            return newPos,newItem;
        else;
            reaper.SetMediaItemInfo_Value(item,"D_POSITION",time);
            return time,item;
        end;          
    end;
    
    
    
    
    
    
    
