




-----------------------------------------------------------------------
    --преобразования секунд, прошедших часы, минуты, секунды

    local function sectotime(sec);
        local totalMin = math.floor((sec/60)+.5);
        local h = math.floor((totalMin/60)+.5);
        local m = totalMin%60;
        local s = sec%60;
        return string.format("%02d:%02d:%02d",h,m,s);
    end;
    
    
    
-----------------------------------------------------------------------
    --преобразования секунд, прошедших в дни, часы, минуты, секунды
    
    function disp_time(sec);
        local d = math.floor((sec/86400)+.5);
        local h = math.floor((math.fmod(sec,86400)/3600)+.5);
        local m = math.floor((math.fmod(sec,3600)/60)+.5);
        local s = math.floor(math.fmod(sec,60)+.5);
        return string.format("%d:%02d:%02d:%02d",d,h,m,s);
    end;
