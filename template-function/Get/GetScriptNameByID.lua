




          --Автор: MPL

              --Получить имя скрипта по ID



function GetScriptNameByID(ID)
    local fp, cont = reaper.GetResourcePath()..'/reaper-kb.ini'
    local f = io.open(fp, 'a+')
    if not f then return else cont = f:read('a') f:close() end
    return cont:match(ID:match('[%a%d]+')..'%s"(.-)".-\n')
end

scriptname = GetScriptNameByID(id)











