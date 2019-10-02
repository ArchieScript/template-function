



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
