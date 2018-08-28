




       ----Автор: MPL


                --получить ID по имени скрипта
                
                
                
                
 
function GetIDByScriptName(scriptname)
    local fp, cont = reaper.GetResourcePath()..'/reaper-kb.ini'
    local f = io.open(fp, 'a+')
    if not f then return else cont = f:read('a') f:close() end
    scriptname = scriptname:gsub('Script:%s' ,''):gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
    for line in cont:gmatch('[^\r\n]+') do if line:match(scriptname) then return line:match('RS[%a%d]+') end end
end

ID = GetIDByScriptName( scriptname )
 
 
 
 
 
 
 
 
 
 
 
