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
    
    
    
    --- / Header / -----------------
    local header = string.match(text,"%S.-\n%s-\n"):gsub('\n%s-\n',']]\n')..'\n';
    -------------------------------- 
    
    
    --- / space / -----------------------------
    function s(n);return string.rep(" ",n);end;
    ------------------------------------------- 
    
    
    
    --- / Удалить Пробелы / --------
    for i = 1,100 do;
        text = text:gsub(s(2),s(1));
    end;
    --------------------------------
    
    
    
    --- / Удалить Пробелы В начале строки  / ---
    local tx;
    for var in string.gmatch(text,".-\n")do;
        var = var:match("%S.*\n")or"\n";
        tx = (tx or "")..var;
    end;
    text = tx;
    --------------------------------------------

    
    
    --- / Комент.Многостр / --------
    local space = "";
    for i1 = 1, 5 do;  -- " "
        local equality = "";
        for i2 = 1, 100 do; -- "="
            text = string.gsub(text,"%-%-"..space.."%["..equality.."%[.-%]"..equality.."%]",s(1));
            equality = equality.."=";
        end;
        space = space..s(1);
    end;
    --------------------------------
    
    
    
    --- / Комент.Одностр / -----------
    text = text:gsub("%-%-.-\n","\n");
    ----------------------------------
    
    
    
    --- / Удалить Первую Строку / --------------
    text = text:gsub("local VersionMod.-\n","");
    --------------------------------------------
    
    
    
    --- / Удалить Пробелы В начале / ---
    text = (text):match("%S.*");
    ------------------------------------ 
    
    
    
    
    --[
    --- / функцию в одну строку / --------
    local txx;
    for var in string.gmatch(text.."\n\n\n\n\n\n","%S.-\n\n\n\n\n\n")do;
        if #var < 4000 then;
            var = var:gsub("\n"," ");
       end;
       txx = (txx or "")..var.."\n";
    end;
    text = txx;
    --------------------------------------
    -- ]]
    
    
    
    --- / Удалить '\n' / -------------
    for i = 1,10 do;
        text = text:gsub("\n\n","\n");
    end;
    ----------------------------------
   --]] 
    
    
    
    --- / Удалить Пробелы / --------
    for i = 1,100 do;
        text = text:gsub(s(2),s(1));
    end;
    --------------------------------
    
    
    
    
    --- / Записываем в файл / ------    
    file = io.open(path..'!!! '..scr_file,"w");
    file:write(header..text);
    file:close();
    --------------------------------
