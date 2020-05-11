







    -------------------------------------------------------------------
    local function iniFileWrite(section,key,value,iniFile);
        key = key:gsub('^%s-%;*',''):gsub('\n','');
        value = value:gsub('\n','');
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
        table.insert(t,'[{3D0dummy085du04EmC390my048E7dummyDF}]');
        local section_found;
        for i = 1, #t do;
            if t[i]:match('^%s-%[%s-'..section..'%s-%]')then;
                section_found = true;
                for i2 = i+1,#t do;
                    if t[i2]:match('^%s-%[')then;
                        table.insert(t,i2,key..'='..value)break;
                    end;
                    if t[i2]:match('^%s-'..key..'%s-%=.*')then;
                        t[i2] = key..'='..value;break;
                    end;
                end;
                break;
            end;
        end;
        table.remove(t,#t);
        if not section_found then;
            table.insert(t,'['..section..']');
            table.insert(t,key..'='..value);
        end;
        local write = table.concat(t,'\n');
        if write ~= table.concat(t2,'\n')then;
            write = write:gsub('\n\n','\n'):gsub('\n\n','\n');
            file = io.open(iniFile,'w');
            file:write(write);
            file:close();
            return true;
        end;
        return false;
    end;
    -------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
