










    
    
    local function Get_Auto_RecArm_State(TrackChunk);
        local bracket = 0;
        for var in string.gmatch(TrackChunk..'\n',".-\n") do;
            if var:match('^%s-<')or var:match('^%s->')then;
                bracket = bracket+1;
            end;
            local ret = tonumber(var:match('^%s-AUTO_RECARM%s+(%d+)'));
            if ret then;
                return ret;
            end;
            if bracket > 2 and not ret then return 0 end;
        end;
        return 0;
    end;
    
    
    local function Set_Auto_RecArm_State(TrackChunk,state);
        local REC,t,idx = nil,{},0;
        for var in string.gmatch(TrackChunk..'\n',".-\n") do;
            if var:match('^%s-AUTO_RECARM')then;
                local arg1,arg2 = var:match('^%s-(AUTO_RECARM%s+)(%d*).-$');
                if arg1 and arg2 then;
                    var = var:gsub(arg1..arg2,arg1..state);
                end;
            else;
                if REC and state == 1 then;
                    var = 'AUTO_RECARM '..state..'\n'..var;
                end;
            end;
            if REC then REC = nil end;
            if var:match('^%s-REC%s+%d+')then;
                REC = true;
            end;
            idx = idx + 1;
            t[idx] = var
        end;
        return table.concat(t);
    end;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
