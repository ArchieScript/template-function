





    -- Получить Имя эффекта на треке
    -- Вернет Имя по умолчанию и Имя переименованное или по умолчанию 



    function TrackFX_GetFXNameOriginalSource(Track,idx_Fx);
        local TrackChunk, NameDefault;
        local retval,str = reaper.GetTrackStateChunk(Track,"",false);
        local strSave = str; str = string.gsub(str,"<","\n\n<").."\n\n";
        local ret,buf = reaper.TrackFX_GetFXName(Track,idx_Fx,"");
        if ret then;
            local buf2 = buf:gsub("[%%%[%]%(%)%*%+%-%.%?%^%$]",function(s)return"%"..s;end);
            local GUID = reaper.TrackFX_GetFXGUID(Track,idx_Fx);
            for var in str:gmatch("<.-\n\n") do;
                local guid = string.match(var,"FXID ({.-})");
                if guid==GUID then;var = var:gsub(buf2,'""'):gsub('""""','""');end;
                TrackChunk = (TrackChunk or "")..var;
            end; TrackChunk = TrackChunk:gsub("\n\n","\n");
            reaper.SetTrackStateChunk(Track,TrackChunk,false);
            ret,NameDefault = reaper.TrackFX_GetFXName(Track,idx_Fx,"");
            if NameDefault == "" then NameDefault = buf end;
            reaper.SetTrackStateChunk(Track,strSave,false);
        end;  
        return buf,NameDefault;
    end;
    
    
    
    
    
    
    
    
    
    
