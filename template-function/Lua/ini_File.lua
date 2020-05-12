







    -------------------------------------------------------------------
    --boolean 'lua' Необязательный параметр
    --Если установлен,будет добавлять комментарий 'два тире', полезно для записи в луа файл.
    --boolean 'clean', true=Очистка пустых строк, Необязательный параметр.
    -------------------------------------------------------------------
    local function iniFileWrite(section,key,value,iniFile,lua,clean);
        if lua==true then lua='--'else lua=''end;
        key = key:gsub('^%s-%;*',''):gsub('\n',''):gsub('%=','');
        value = value:gsub('\n','');
        section = section:gsub('\n','');
        local file = io.open(iniFile,'r');
        if not file then;
            file = io.open(iniFile,'w');
            file:close();
            file = io.open(iniFile,'r');
        end;
        local t = {};
        for line in file:lines()do;
            table.insert(t,line);
        end;
        local t2 = {table.unpack(t)};
        file:close();
        table.insert(t,lua..'[{3D0ini0C8File5E8dummyE7CWriteD9F}]');
        local section_found;
        for i = 1, #t do;
            if t[i]:match('^%s-'..lua..'%[%s-'..section..'%s-%]')then;
                section_found = true;
                for i2 = i+1,#t do;
                    if t[i2]:match('^%s-'..lua..'%[')then;
                        table.insert(t,i2,lua..key..'='..value)break;
                    end;
                    if t[i2]:match('^%s-'..lua..key..'%s-%=.*')then;
                        t[i2] = lua..key..'='..value;break;
                    end;
                end;
                break;
            end;
        end;
        table.remove(t,#t);
        if not section_found then;
            table.insert(t,lua..'['..section..']');
            table.insert(t,lua..key..'='..value);
        end;
        local write = table.concat(t,'\n');
        if write ~= table.concat(t2,'\n')then;
            if clean==true then write=write:gsub('\n\n','\n'):gsub('\n\n','\n')end;
            file = io.open(iniFile,'w');
            wrt = file:write(write);
            file:close();
            return type(wrt)=='userdata';
        end;
        return false;
    end;
    -------------------------------------------------------------------
    
    --=================================================================
    
    -------------------------------------------------------------------
    --boolean 'lua' - Смотреть function iniFileWrite, Необязательный параметр
    -------------------------------------------------------------------
    local function iniFileRead(section,key,iniFile,lua);
        if lua==true then lua='--'else lua=''end;
        key = key:gsub('^%s-%;*',''):gsub('\n',''):gsub('%=','');
        section = section:gsub('\n','');
        local file = io.open(iniFile,'r');
        if not file then return '' end;
        local t = {};
        for line in file:lines()do;
            table.insert(t,line);
        end;
        file:close();
        for i = 1, #t do;
            if t[i]:match('^%s-'..lua..'%[%s-'..section..'%s-%]')then;
                for i2 = i+1,#t do;
                    if t[i2]:match('^%s-'..lua..'%[')then;return''end;
                    if t[i2]:match('^%s-'..lua..key..'%s-%=.*')then;
                        return t[i2]:match('^%s-'..lua..key..'%s-%=(.*)');
                    end;
                end;
                break;
            end;
        end;
        return '';
    end;
    -------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
