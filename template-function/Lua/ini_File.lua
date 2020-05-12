


    --=================================================================
    --=================================================================
    --=================================================================

-- WRITE

    -------------------------------------------------------------------
    --boolean 'lua' Необязательный параметр
    --Если установлен,будет добавлять комментарий 'два тире', полезно для записи в луа файл.
    --boolean 'clean', true=Очистка пустых строк, Необязательный параметр.
    -- вернет true если данные былы записанны в файл, иначе false (запись не производится, если это не не обходимо)
    -------------------------------------------------------------------
    local function iniFileWrite(section,key,value,iniFile,lua,clean);
        if lua==true then lua='--'else lua=''end;
        key = key:gsub('^%s-%;*',''):gsub('\n',''):gsub('%=','');
        value = tostring(value):gsub('\n','');
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
    --=================================================================
    --=================================================================

 -- READ   
    
    -------------------------------------------------------------------
    --boolean 'lua' - Смотреть function iniFileWrite, Необязательный параметр
    --Вернет value или ''
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
    
    
    --=================================================================
    --=================================================================
    --=================================================================
  
--REMOVES_ECTION
    
    -------------------------------------------------------------------
    --Удалить всю секцию, со всеми ключами
    --boolean 'lua' - Смотреть function iniFileWrite, Необязательный параметр
    -- вернет трие при успешном удалении, иначе false
    -------------------------------------------------------------------
    local function iniFileRemoveSection(section,iniFile,lua);
        if lua==true then lua='--'else lua=''end;
        section = section:gsub('\n','');
        local file = io.open(iniFile,'r');
        if not file then return false end;
        local t = {};
        for line in file:lines()do;
            table.insert(t,line);
        end;
        file:close();
        local remT = {};
        for i = 1, #t do;
            if t[i]:match('^%s-'..lua..'%[%s-'..section..'%s-%]')then;
                remT[#remT+1]=i;
                for i2 = i+1,#t do;
                    if t[i2]:match('^%s-'..lua..'%[')then break end;
                    remT[#remT+1]=i2;
                end;
                break;
            end;
        end;
        for i = #remT,1,-1 do;
            table.remove(t,remT[i]);
        end;
        if #remT > 0 then;
            file = io.open(iniFile,'w');
            wrt = file:write(table.concat(t,'\n'));
            file:close();
            return type(wrt)=='userdata';
        end;
        return false;
    end;
    -------------------------------------------------------------------
    
    
    --=================================================================
    --=================================================================
    --=================================================================
    
--ENUMERATE 
    
    -------------------------------------------------------------------
    --Перечислите данные, хранящиеся в ini для конкретного имени 'section'
    --Возвращает false, когда больше нет данных
    --idx На основе нуля
    --boolean 'lua' - Смотреть function iniFileWrite, Необязательный параметр
    -------------------------------------------------------------------
    local function iniFileEnum(section,idx,iniFile,lua);
        if not tonumber(idx)then error('param 2(idx) - expected number',2)end;
        if lua==true then lua='--'else lua=''end;
        section = section:gsub('\n','');
        local file = io.open(iniFile,'r');
        if not file then return false,'','' end;
        local t = {};
        for line in file:lines()do;
            table.insert(t,line);
        end;
        file:close();
        for i = 1, #t do;
            if t[i]:match('^%s-'..lua..'%[%s-'..section..'%s-%]')then;
                local j = 0;
                for i2 = i+1,#t do;
                    if t[i2]:match('^%s-'..lua..'%[')then break end;
                    local key,val = t[i2]:match('(.+)=(.*)');
                    if key and val then;
                        key =  key:gsub( ('^%s-'..lua:gsub('%p','%%%0')),'');
                        if j ==  tonumber(idx) then return true,key,val end;
                        j = j + 1;
                    end;
                end;
                break;
            end;
        end;
        return false,'','';
    end;
    -------------------------------------------------------------------
    --retval, key, val = iniFileEnum(section,idx,iniFile,lua);
    -------------------------------------------------------------------
    

    --=================================================================
    --=================================================================
    --=================================================================
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
