



---------------------------------------------------
   --Автор: MPL
      --получить ID по имени скрипта

function GetIDByScriptName(scriptname)
    local fp, cont = reaper.GetResourcePath()..'/reaper-kb.ini'
    local f = io.open(fp, 'a+')
    if not f then return else cont = f:read('a') f:close() end
    scriptname = scriptname:gsub('Script:%s' ,''):gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
    for line in cont:gmatch('[^\r\n]+') do if line:match(scriptname) then return line:match('RS[%a%d]+') end end
end

ID = GetIDByScriptName( scriptname )
------------------------------------------------------------
 


------------------------------------------
-- ГОТОВ:
-- Arc
     
    function GetIDByScriptName(scriptName);
        if type(scriptName)~="string"then error("expects a 'string', got "..type(scriptName),2) end;
        local file = io.open(reaper.GetResourcePath()..'/reaper-kb.ini','r'); if not file then return -1 end;local
        scrName = scriptName:gsub('Script:%s+',''):gsub("[%%%[%]%(%)%*%+%-%.%?%^%$]",function(s)return"%"..s;end);
        for var in file:lines()do;if var:match('"Custom:%s-'..scrName..'"')then;
            return var:match(".-%s+.-%s+.-%s+(.-)%s"):gsub('"',""):gsub("'","");
    end;end;return -1;end;      
    
-----------------------------------------
 
 
 
 
 
 
 
 
