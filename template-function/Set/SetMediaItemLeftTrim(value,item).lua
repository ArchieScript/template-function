  
         
  
         -- Set Media Item Left Trim

                                                      (баг)
  
  local function SetMediaItemLeftTrim(value,item)
        local Pos = reaper.GetMediaItemInfo_Value( item, 'D_POSITION' )
        local len = reaper.GetMediaItemInfo_Value( item, 'D_LENGTH' )
        local take = reaper.GetActiveTake( item )
        local playrate = reaper.GetMediaItemTakeInfo_Value( take, 'D_PLAYRATE')
        local offset = reaper.GetMediaItemTakeInfo_Value( take, 'D_STARTOFFS' )
        if len > value then
            reaper.SetMediaItemLength( item,  value , true )
            reaper.SetMediaItemPosition( item,(len-value)+ Pos, true )
            reaper.SetMediaItemTakeInfo_Value( take, 'D_STARTOFFS',offset + (len-value)*playrate )
        else
            if Pos < (value-len) then return end
            reaper.SetMediaItemLength( item, value , true )
            reaper.SetMediaItemPosition( item, Pos-(value-len), true )
            reaper.SetMediaItemTakeInfo_Value( take, 'D_STARTOFFS',offset + (len-value)*playrate )
        end
    end
    
    
    
    
                                                          работает
    
    
    ------------SetMediaItemLeftTrim2------------------
    local function SetMediaItemLeftTrim2(position,item)
        reaper.PreventUIRefresh(3864598);
        local sel_item = {};
        for i = 1, reaper.CountSelectedMediaItems(0) do;
            sel_item[i] = reaper.GetSelectedMediaItem(0,i-1);
        end;
        reaper.SelectAllMediaItems(0,0);
        reaper.SetMediaItemSelected(item,1);
        reaper.ApplyNudge(0,1,1,0,position,0,0);
        reaper.SetMediaItemSelected(item,0);
        for _, item in ipairs(sel_item) do;
            reaper.SetMediaItemSelected(item,1);
        end;
        reaper.PreventUIRefresh(-3864598);
    end -- Удлинить укоротить Медиа Элемент Слева
    ---------------------------------------------
    
