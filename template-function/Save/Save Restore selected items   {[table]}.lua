






        -- Save Restore selected items table


    local function Save_Selected_Items()
      sel_item = {}
      for i = 1, reaper.CountSelectedMediaItems(0) do
        sel_item[i] = reaper.GetSelectedMediaItem(0, i - 1)
      end
    end
    ---

    local function Restore_Selected_Items()
      reaper.SelectAllMediaItems( 0, 0 )
      for _, item in ipairs(sel_item) do
        reaper.SetMediaItemSelected(item, 1)
      end
    end
    
    
    --===============================================================

  --GUID

     
        local guid
    function Save_Selected_Items()
        guid = {}
        for i = 1, reaper.CountSelectedMediaItems(0) do
            local sel_item = reaper.GetSelectedMediaItem(0, i - 1)
            guid[i] = reaper.BR_GetMediaItemGUID( sel_item )
        end
    end
    ---
    

    
    function Restore_Selected_Items()
        reaper.SelectAllMediaItems( 0, 0 )
        for i = 0, #guid do        
            local item = reaper.BR_GetMediaItemByGUID( 0, guid[i] )
            if item then
                reaper.SetMediaItemSelected( item, 1 )
            end
        end  
    end   
    
    
    









    
    
