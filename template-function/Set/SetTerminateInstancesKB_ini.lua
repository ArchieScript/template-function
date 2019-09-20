





--Set - terminate All Instances Or Start New One KB_ini
--Установите - завершить все экземпляры или начать новый KB_ini
---------------------------------------------------------------



    ScrName = "Archie_Edit cursor;  MMM.lua"
    ScrPath = [[C:/Users/Archie/Desktop/Reaper-Vremenno/Scripts/Archie-ReaScripts/MAIN/Edit cursor]]
    
    
    
    function SetTerminateAllInstancesOrStartNewOneKB_ini(newState,ScrPath,ScrName);
        -- newState= 4-Reset/260-Terminate/516-New;
        local file = io.open(reaper.GetResourcePath().."/reaper-kb.ini","r");
        if file then;
            local ScrNameX = ScrName:gsub("[%p]","%%%0");
            local ScrPathX = ScrPath:gsub("[\\/]",""):gsub("[%p]","%%%0");
            local ScrPath2X = (ScrPath:gsub("[\\/]","")):gsub(((reaper.GetResourcePath().."Scripts")
                                      :gsub("[\\/]",""):gsub("[%p]","%%%0")),""):gsub("[%p]","%%%0");
            local line_T, found,Stop = {};
            for line in file:lines()do;
                if not found then;
                    if line:match(ScrNameX) then;
                        if line:gsub("[\\/]",""):match(ScrPathX..ScrNameX)or
                            line:gsub("[\\/]",""):match(ScrPath2X..ScrNameX) then;
                            found = true;
                            local state = tonumber(line:match("^%S+%s+(%d+)"));
                            if state == newState then;
                                Stop = true; file:close();break;
                            else;
                                line = line:gsub(line:match("^%S+%s+%d+"),line:match("^%S+%s+%d+"):gsub("%s%d+"," "..newState,1),1);
                            end;
                        end;
                    end;
                end;
                table.insert(line_T,line);
            end;
            if not Stop then;
                file:close();
                if #line_T > 0 then;
                    local newLine = table.concat(line_T,"\n")
                    local file = io.open(reaper.GetResourcePath().."/reaper-kb.ini","w");
                    file:write(newLine);
                    file:close();
                end;
            end;
        end; 
    end;
    --reaper.defer(function() SetTerminateAllInstancesOrStartNewOneKB_ini(516,ScrPath,ScrName)end);
    --SetTerminateAllInstancesOrStartNewOneKB_ini(516,ScrPath,ScrName)
