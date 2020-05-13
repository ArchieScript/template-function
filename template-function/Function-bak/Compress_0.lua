







-- Compress  /  Arc_Function_lua
-- Version: 1.0
-- Provides: [nomain].
----------------------
    
    local 
    path,scr_file = reaper.GetResourcePath()..'/Scripts/Archie-ReaScripts/Functions/','Arc_Function_lua.lua';
    
    
    -----------------------------------------
    local file = io.open(path..scr_file,'r');
    if not file then error("  There is no file !!! / Нет файла !!!  "..path,1)end;
    local text = file:read('a')..'\n';
    file:close();
    -------------
    
    
    function s(n);return string.rep(" ",n);end;
    
    
    ---перенос строки------------
    text = text:gsub('\n',s(1)) 
    -----------------------------
    
    
    --- / space / -----------------------------
    text = text:gsub(s(4),s(1)):gsub(s(3),s(1)):gsub(s(2),s(1)):gsub(s(2),s(1))
    ------------------------------------------- 
    
    
    
    --- / Записываем в файл / ------    
    file = io.open(path..'!!! '..scr_file,"w");
    file:write(text);
    file:close();
    --------------------------------
