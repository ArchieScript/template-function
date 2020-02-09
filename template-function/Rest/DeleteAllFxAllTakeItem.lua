






    local function DeleteAllFxAllTakeItem(itChunk);
        local T = {};
        for line in string.gmatch(itChunk..'\n',".-\n") do;
            if line:match('^<TAKEFX')then X = true end;
            if X then;
                if line:match('^%S')=='<' then;
                    x = (x or 0)+1;
                elseif line:match('^%S')=='>'and x then;
                    x = x - 1; 
                end;
                if x == 0 then;
                    X = nil;
                end;
                line = '';
            end;
            if line ~= '' then;
                T[#T+1] = line;
            end;
        end;
        return table.concat(T);
    end;
    
    
    
     local _, itChunk = reaper.GetItemStateChunk(item,'',false)
    itChunk =  DeleteAllFxAllTakeItem(itChunk);
    --reaper.ShowConsoleMsg( itChunk..'\n' )
     reaper.SetItemStateChunk( item, itChunk, true )
