



    
    
    
    
    
    
    
    -- Получить значение сетки Проекта;
    -- Форматирует значение сетки в удобочитаемую форму;
    -- divisionIn: Необезательный параметр, по умолчанию сетка установленная в проекте иначе установить неформатированное значение
    -- Вернет:
    -- retval: true при успехе иначе false.
    -- flag: флаг сетки ???
    -- division: Не форматированое значение сетки.
    -- swingmode: 0-1 свинг включен / выключен.
    -- swingshift: значения свинга. -1 - 1.
    -- T: Триплет  true / false
    -- Пример: Сетка проекта = "вернет строку"
    -- str1: значения в виде - 1/8T = "1/12";  1/8 = "1/8";  2 = "2";  1.5 = "3/2"
    -- str2: значения в виде - 1/8T = "1/12";  1/8 = "1/8";  2 = "2";  1.5 = "1.5"
    -- str3: значения в виде - 1/8T = "1/8T";  1/8 = "1/8";  2 = "2";  1.5 = "3/2"
    -- str4: значения в виде - 1/8T = "1/8T";  1/8 = "1/8";  2 = "2";  1.5 = "1/5"
    
    
    
    
    local function Get_Format_ProjectGridEx(divisionIn);
        local function Modf(numb);
            if type(numb)~="number" then error("#1 to 'Modf' (number expected, got string)",2)end;
            local whole,fraction = string.match(numb,"^(%d+)%D-(%d-)$");
            return math.modf(tonumber(whole.."."..fraction));
        end;
        local flag,division,swingmode,swingshift = reaper.GetSetProjectGrid(0,0);
        division = tonumber(divisionIn)or division;
        if not tonumber(division) then return false end;
        local i,T,str1,str2,str3,str4;
        repeat i=(i or 0)+1 if i>50000 then return false end; until({Modf(i/division)})[2]==0;
        local fraction = i / division;
        str1 = (string.format("%.0f",i).."/"..string.format("%.0f",fraction)):gsub("/%s-1$","");
        if division >= 1 then str2 = string.format("%.3f",division):gsub("[0.]-$","") else str2 = str1 end;
        if (fraction % 3) == 0 then T = true else T = false end;
        if T then str3=string.format("%.0f",i).."/"..string.format("%.0f",fraction-(fraction/3)).."T"else str3=str1 end;
        if T then;
            if division>=0.6666 then str4=string.format("%.3f",(division/2)+division):gsub("[0.]-$","").."T"else str4=str3;end;
            elseif division >= 1 then str4=str2 else str4=str1;
        end;
        return true,flag,division,swingmode,swingshift,T,str1,str2,str3,str4;
    end;
    
    
    local retval,flag,division,swingmode,swingshift,T,str1,str2,str3,str4 = Get_Format_ProjectGridEx(divisionIn);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
