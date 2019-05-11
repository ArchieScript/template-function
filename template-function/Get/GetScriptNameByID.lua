







              --Получить имя скрипта по ID скрипта



    function GetScriptNameByID(id);
        local Path,text = reaper.GetResourcePath()..'/reaper-kb.ini';
        local file = io.open(Path,'r');
        if not file then return end;
        text = file:read('a');file:close();
        return text:match(id:match('[%a%d]+')..'%s"(.-)".-\n');
    end

    scriptname = GetScriptNameByID(id)





----------------------------------------
-- ГОТОВ:

    
    function GetScriptNameByID(id);
        if type(id)~="string"then error("expects a 'string', got "..type(id),2) end;
        local file = io.open(reaper.GetResourcePath()..'/reaper-kb.ini','r');
        if not file or (#id<1) then return -1 end;local text = file:read('a');file:close();
        id = id:match('%_*(%S+)');return
        text:match("%s"..id..'%s-"Custom:%s-.(.-)"')or
        text:match('"'..id..'"%s-"Custom:%s-.(.-)"')or-1;
    end;
    














