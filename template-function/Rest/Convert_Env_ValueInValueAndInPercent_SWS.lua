



    function Convert_Env_ValueInValueAndInPercent_SWS(envelope,valPoint,PerVal);
        local _,_,_,_,_,_,min,max,_,_,faderS = reaper.BR_EnvGetProperties(reaper.BR_EnvAlloc(envelope,true));
        reaper.BR_EnvFree(reaper.BR_EnvAlloc(envelope,true),true);
        local interval = (max - min);
        if PerVal == 0 then return (valPoint-min)/interval*100;
        elseif PerVal == 1 then return (valPoint/100)*interval + min;
        end;
    end;
    
    -- Конвертировать значения конверта в проценты из значения и в значение из процентов.
    -- Обратить внимания, что масштабирование огибающей должно быть отключено.(fade scaling)
    -- valPoint = Значение огибающей в зависимости от PerVal
    -- PerVal = 0 из значения в процент; =1 из процента в значения.
    -- Эффективно для перемещения точек на другую огибающую
    --====End===============End===============End===============End===============End====




---------------------------------------------------
    





    local function Convert_EnvVOLUME_InPercent_DB_SWS(env,value,PerVal);
        local _,_,_,_,_,_,min,max,_,_,faderS = reaper.BR_EnvGetProperties(reaper.BR_EnvAlloc(env,true));
        reaper.BR_EnvFree(reaper.BR_EnvAlloc(env,true),true);
        local DBmin = math.floor((20*math.log(min+3e-8,10))+.5);
        local DBmax = math.floor((20*math.log(max-3e-8,10))+.5);
        local DB_total = math.abs(DBmin)+math.abs(DBmax);
        if PerVal == 0 then;
            local val = ((20*math.log(value+3e-8,10))-DBmin);
            value = val/(DB_total/100);
            return math.floor(value);
        elseif PerVal == 1 then;
            return DBmin+(DB_total/100*value)
        end;
    end;
    -- Конвертировать значения конверта громкости в проценты из значения и в значение из процентов.
    -- Считает по дб, так как центр смещен.
    -- valPoint = Значение огибающей в зависимости от PerVal
    -- PerVal = 0 из значения в процент; =1 из процента в значения.
    -- Эффективно для перемещения точек на другую огибающую
    --====End===============End===============End===============End===============End====




