    
    
    
    
    -- Glue Selected items intervals of less than
    -- Клей Выбранных предметов с интервалами менее или равному ...(interval);
    
    
    function GlueSelectedItemsIntervalsLessThan(interval);
        --reaper.Undo_BeginBlock()
        --reaper.PreventUIRefresh(19566);
        ----
        local SaveAll_T = {};
        local CountSelItem = reaper.CountSelectedMediaItems(0);
        for i = 1,CountSelItem do;
            local Item = reaper.GetSelectedMediaItem(0,i-1);
            SaveAll_T[#SaveAll_T+1] = Item;
        end;
        
        reaper.SelectAllMediaItems(0,0);
        
        ::restart::
        for i = 1,#SaveAll_T do;
            local val_1,Tr1 = pcall(reaper.GetMediaItem_Track,SaveAll_T[i]);
            local val_2,Tr2 = pcall(reaper.GetMediaItem_Track,SaveAll_T[i+1]);
            if val_1 and val_2 then;
                if Tr1 == Tr2 then;
                    local Pos1 = reaper.GetMediaItemInfo_Value(SaveAll_T[i],"D_POSITION");
                    local Len1 = reaper.GetMediaItemInfo_Value(SaveAll_T[i],"D_LENGTH");
                    local Pos2 = reaper.GetMediaItemInfo_Value(SaveAll_T[i+1],"D_POSITION");
                    if not tonumber(interval) or interval < 0 then interval = 0 end;
                    if Pos1+Len1 >= Pos2 - interval then;
                        reaper.SetMediaItemInfo_Value(SaveAll_T[i],"B_UISEL",1);
                        reaper.SetMediaItemInfo_Value(SaveAll_T[i+1],"B_UISEL",1);
                        reaper.Main_OnCommand(40362,0);--Glue items,ignor time sel
                        local ItemNew = reaper.GetSelectedMediaItem(0,0);
                        table.remove(SaveAll_T,i+1);
                        table.remove(SaveAll_T,i);
                        table.insert(SaveAll_T,i,ItemNew);
                        reaper.SetMediaItemInfo_Value(ItemNew,"B_UISEL",0);
                        goto restart;
                    end;
                end; 
            end;
        end;
        
        for i = 1, #SaveAll_T do;
            pcall(reaper.SetMediaItemInfo_Value,SaveAll_T[i],"B_UISEL",1);
        end;
        ----
        --reaper.PreventUIRefresh(-19566);
        --reaper.Undo_EndBlock("",0);
    end;
