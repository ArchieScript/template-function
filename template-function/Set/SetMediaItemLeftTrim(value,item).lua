  
         
  
         -- Set Media Item Left Trim


    
    
    
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
    
