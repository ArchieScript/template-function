









function GetScriptNameByID(ID)
    local fp, cont = reaper.GetResourcePath()..'/reaper-kb.ini'
    local f = io.open(fp, 'a+')
    if not f then return else cont = f:read('a') f:close() end
    return cont:match(ID:match('[%a%d]+')..'%s"(.-)".-\n')
end

scriptname = GetScriptNameByID('_RS5a9b832ada3f7ee194cb55a9e2e504626cd6a546')
