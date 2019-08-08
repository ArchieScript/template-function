        
        
        
        
        
        
        
        
        
        
        
        
--noDuplicate: true или 1 не вставлять точку, если в этом времени уже есть точка (во время входит смещение  point_indent)  
--point_indent: установить время в секундах в котором будут проверяться точки и если точки в этом промежутке есть, то точка не добавится, noDuplicate  должен быть true. 
--Пример: если point_indent  = 1, то 0.5 сек влево и 0.5 сек вправо будет проверяться. для обычной точки  point_indent  = 0, но лучше установить 0.0001
-- time: От старта проекта даже у айтемов
-- autoitem_idx, value,shape,tension,selected,noSortIn / http://www.extremraym.com/cloud/reascript-doc/#InsertEnvelopePointEx

    -- Добавить точку автоматизации везде
    local function InsertEnvelopePointEx_Arc(Env,autoitem_idx,time,point_indent,noDuplicate,value,shape,tension,selected,noSortIn)
        
        local playrate,posItem;
        local Take = reaper.Envelope_GetParentTake(Env);
        if Take then;
            playrate = reaper.GetMediaItemTakeInfo_Value(Take,"D_PLAYRATE");
            local item = reaper.GetMediaItemTake_Item(Take)
            posItem = reaper.GetMediaItemInfo_Value(item,"D_POSITION");
        end;
      
        if autoitem_idx >= 0 and not Take then;
            local posAutoIt = reaper.GetSetAutomationItemInfo(Env,autoitem_idx,"D_POSITION",0,0);
            local lenAutoIt = reaper.GetSetAutomationItemInfo(Env,autoitem_idx,"D_LENGTH",0,0);
            if (time < posAutoIt) or (time > posAutoIt+lenAutoIt) then return false end;
        end;
      
        if noDuplicate == true or noDuplicate == 1 then;
            for i = 1, reaper.CountEnvelopePointsEx(Env,autoitem_idx) do;
                local _,time0,_,_,_,_ = reaper.GetEnvelopePointEx(Env,autoitem_idx,i-1);
                time0 = time0/(playrate or 1); 
                if time0 >= (time-(point_indent/2)) and time0 <= (time+(point_indent/2)) then;
                    point = true; break;
                end;
            end;
        end;
        if not point then;
            time = time-(posItem  or 0);
            time = time*(playrate or 1);
            reaper.InsertEnvelopePointEx(Env,autoitem_idx,time,value,shape,tension,selected,noSortIn)
            return true;
        end;
        point=nil; return false;
    end;
    
    







    -- Добавить точку автоматизации на тейк
    -- time: от начала тейка, все остальное написано выше.
    local function InsertEnvelopePointTake_Arc(Env,time,point_indent,noDuplicate,value,shape,tension,selected,noSortIn)
        
        local Take = reaper.Envelope_GetParentTake(Env);
        if not Take then return false end;
        local playrate = reaper.GetMediaItemTakeInfo_Value(Take,"D_PLAYRATE");
           
        if noDuplicate == true or noDuplicate == 1 then;
            for i = 1, reaper.CountEnvelopePoints(Env) do;
                local _,time0,_,_,_,_ = reaper.GetEnvelopePoint(Env,i-1);
                time0 = time0/playrate; 
                if time0 >= (time-(point_indent/2)) and time0 <= (time+(point_indent/2)) then;
                    point = true; break;
                end;
            end;
        end;  
        if not point then;
            time = time*(playrate or 1);
            reaper.InsertEnvelopePoint(Env,time,value,shape,tension,selected,noSortIn);
            return true;
        end;
        point=nil; return false;
    end;




    
    
    
    
    
