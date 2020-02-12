    

    --Get / Set




 --   Требуется перезагрузка рипера


    -- Set Get - terminate All Instances Or Start New One KB_ini
    -- Установите/получить - завершить все экземпляры или начать новый KB_ini
    ---------------------------------------------------------------
    -- set = 0 / false
    -- Если нашел запись скрипта в файле, то вернет (true,state)
    -- Если не нашел запись скрипта в файле то вернет (false)
    -----------
    -- set = 1 / true
    -- Если не нашел запись скрипта в файле то вернет (false)
    -- Если нашел запись скрипта в файле, и значения равны с newState, то вернет (false,state), перезапись не будет производиться,сработает как get/
    -- Если нашел запись скрипта в файле, и значения не равны с newState, то перепишет новое значения и вернет старое значение,true.
    --------------------------------------------------------------------------------------------------------------------------------
    
    -- ScrName = "Archie_Edit cursor;  MMM.lua"
    -- ScrPath = [[C:/Users/Archie/Desktop/Reaper-Vremenno/Scripts/Archie-ReaScripts/MAIN/Edit cursor
        
    
        
    local function GetSetTerminateAllInstancesOrStartNewOneKB_ini(set,newState,ScrPath,ScrName);
        -- newState = 4-Reset/260-Terminate/516-New;
        local ResPath = reaper.GetResourcePath();
        local file = io.open(ResPath.."/reaper-kb.ini","r");
        if file then;
            local ScrNameX = ScrName:gsub("[%p]","%%%0");
            local ScrPathX = ScrPath:gsub("[\\/]",""):gsub("[%p]","%%%0");
            ---
            local ScrPth1 = (ScrPath:gsub("[\\/]",""));
            local ScrPth2 = ((ResPath.."Scripts"):gsub("[\\/]","")):gsub("[%p]","%%%0");
            local ScrPath2X = ScrPth1:gsub(ScrPth2,""):gsub("[%p]","%%%0");
            ---
            local line_T, found,Stop,state = {};
            for line in file:lines()do;
                if not found then;
                    if line:match(ScrNameX) then;
                        if line:gsub("[\\/]",""):match(ScrPathX..ScrNameX)or
                            line:gsub("[\\/]",""):match(ScrPath2X..ScrNameX) then;
                            found = true;
                            state = tonumber(line:match("^%S+%s+(%d+)"));
                            if (set==0 or set==false)then;file:close();return true,state end;
                            if state == newState then; file:close();return false,state end;
                            line = line:gsub( line:match("^%S+%s+%d+"),line:match("^%S+%s+%d+"):gsub("%s%d+"," "..newState,1),1);
                        end;
                    end;
                end;
                table.insert(line_T,line);
            end;
            if (set==0 or set==false)then;file:close();return false end;
            if found then;
                file:close();
                if #line_T > 0 then;
                    local newLine = table.concat(line_T,"\n");
                    local file = io.open(reaper.GetResourcePath().."/reaper-kb.ini","w");
                    file:write(newLine);
                    file:close();
                    return true,state;
                end;
            end;
        end;
        return false;
    end;
    
    --reaper.defer(function() GetSetTerminateAllInstancesOrStartNewOneKB_ini(1,516,ScrPath,ScrName)end);
    --GetSetTerminateAllInstancesOrStartNewOneKB_ini(1,516,ScrPath,ScrName)
    --GetSetTerminateAllInstancesOrStartNewOneKB_ini(0,'',ScrPath,ScrName)
    --GetSetTerminateAllInstancesOrStartNewOneKB_ini(0,nil,ScrPath,ScrName)
    











