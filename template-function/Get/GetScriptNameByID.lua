







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
-- Готов:

    function GetScriptNameByID(id);
        local file = io.open(reaper.GetResourcePath()..'/reaper-kb.ini','r');
        if file then;local text = file:read('a');file:close();
            return text:match(id:match('[^_](%S+)')..'%s-"Custom:%s-.(.-)"')or-1;
    end;end;





