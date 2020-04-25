



--Ext State in script





    --============================================================= 
    --===(v.-.-- | Ext State | ====================================
    local function GetStrFile();
        local scriptFile = debug.getinfo(1,'S').source:gsub("^@",''):gsub("\\",'/');
        local file = io.open(scriptFile,'r');
        local str = file:read('a');
        file:close();
        return str,scriptFile;
    end;
    ---
    local function GetList(key);
        key=tostring(key);
        if not key or key:gsub(' ','') == '' then return '' end;
        return(GetStrFile():match('%-%-%[%=%[%s-'..key..'%s-%=%s-%{%s-%[%s-%[(.-)%]%s-%]%s-%}%s-%]%s-%=%s-%]')or''):gsub("\n",'');
    end;
    ---
    local function SetList(key,value);
        key=tostring(key)value=tostring(value);local StrNew;
        if not key or key:gsub(' ','') == '' then return false end;
        if not value then return false end;
        local StrFile,scriptFile = GetStrFile();
        local list = (StrFile:match('%-%-%[%=%[%s-'..key..'%s-%=%s-%{%s-%[%s-%[.-%]%s-%]%s-%}%s-%]%s-%=%s-%]'));
        if list then;
            if value:gsub(' ','') == '' then;
                StrNew = StrFile:gsub(list:gsub('%p','%%%0')..'%s*\n*','',1);
            else;
                StrNew = StrFile:gsub(list:gsub('%p','%%%0'),'--[=['..key..'={[['..value..']]}]=]',1);
            end;
        else;
            if value:gsub(' ','') ~= '' then;
                StrNew = '--[=['..key..'={[['..value..']]}]=]\n'..StrFile;
            end;
        end;
        if StrNew and StrFile ~= StrNew then;
            local file = io.open(scriptFile,'w');
            file:write(StrNew);
            file:close();
            return true;
        else;
            return false;
        end;
    end; 
    ---
    local function DelList(key);
        key=tostring(key);local StrNew;
        if not key or key:gsub(' ','') == '' then return false end;
        local StrFile,scriptFile = GetStrFile();
        local list = (StrFile:match('%-%-%[%=%[%s-'..key..'%s-%=%s-%{%s-%[%s-%[.-%]%s-%]%s-%}%s-%]%s-%=%s-%]%s*\n*'));
        if list then;
            StrNew = StrFile:gsub(list:gsub('%p','%%%0'),'',1);
        end;
        if StrNew and StrNew ~= StrFile then;
            local file = io.open(scriptFile,'w');
            file:write(StrNew);
            file:close();
            return true;
        else;
            return false;
        end;
    end;
    --=== | Ext State | v.-.--)====================================
    --=============================================================
    



    key = 'LIST';
    value = 1;
    val =  GetList(key);
    SetList(key,value);
    DelList(key);




