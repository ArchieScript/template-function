









    --=========================================
    local function GetSetArmTrackState(set,track,state);
        if not set or set == 0 then;
            return reaper.GetMediaTrackInfo_Value(track,"I_RECARM");
        else;
            local _,TrackChunk = reaper.GetTrackStateChunk(track,'',false);
            local bracket,ret = 0,nil;
            for var in string.gmatch(TrackChunk..'\n',".-\n") do;
                if var:match('^%s-%S')=='<'or var:match('^%s-%S')=='>'then;
                    bracket = bracket+1;
                end;
                ret = tonumber(var:match('^%s-LOCK%s+(%d*).-$'));
                if ret or (bracket >= 2) then break end;
            end;
            if ret and ret >= 1 then;
                local x,t,arg1,arg2 = 0,{},nil,nil;
                for var in string.gmatch(TrackChunk..'\n',".-\n") do;
                    if not arg1 and not arg2 then;
                        arg1,arg2 = var:match('^%s-(REC%s+)(%d*).-$');
                        if arg1 and arg2 then;
                            var = var:gsub(arg1..arg2,arg1..state);
                        end;
                    end;
                    x=x+1;t[x]=var;
                end;
                reaper.SetTrackStateChunk(track,table.concat(t),false);
            else;
                reaper.SetMediaTrackInfo_Value(track,"I_RECARM",state);
            end;
        end;
    end;
    --=========================================
    
    
    
    
    
    
    
    
    
