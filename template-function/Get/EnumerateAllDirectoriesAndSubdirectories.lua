






     -- Получить таблицу с подкаталогами 






    local function EnumerateAllDirectoriesAndSubdirectories(path);
        local T = {};
        for i = 0,math.huge do;
            local Subdirectories = reaper.EnumerateSubdirectories(path,i);
            if Subdirectories then;
                T[#T+1] = path..'/'..Subdirectories;
            else;
                break;
            end;
        end;
        ::REPEAT::;
        local X = #T;
        for i = 1,#T do;
            for i2 = 0,math.huge do;
                local Subdirectories = reaper.EnumerateSubdirectories(T[i],i2);
                if Subdirectories then;
                    local SKIP = nil;
                    for i3 = 1,#T do;
                        if T[i3]==T[i]..'/'..Subdirectories then SKIP = true break end;    
                    end;
                    if not SKIP then;
                        T[#T+1] = T[i]..'/'..Subdirectories;
                    end;
                else;
                    break;
                end;   
            end;
        end;
        if #T ~= X then goto REPEAT end;
        return T;
    end;
    
    
    
    pathTest = reaper.GetResourcePath()..'/FXChains';
    Test = EnumerateAllDirectoriesAndSubdirectories(pathTest);
    
    --file = reaper.EnumerateFiles(#Test[i],i2-1);
    
    --con = table.concat (T, '\n')
    --reaper.ShowConsoleMsg(  con )















