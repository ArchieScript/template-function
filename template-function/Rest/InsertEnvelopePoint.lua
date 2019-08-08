        
        
        
        
        
        
        
        
        
        
        
--*     
--noDuplicate: true или 1 не вставлять точку, если в этом времени уже есть точка (во время входит смещение  point_indent)  
--point_indent: установить время в секундах в котором будут проверяться точки и если точки в этом промежутке есть, то точка не добавится, noDuplicate  должен быть true. 
--Пример: если point_indent  = 1, то 0.5 сек влево и 0.5 сек вправо будет проверяться. для обычной точки  point_indent  = 0, но лучше установить 0.0001
-- time: От старта проекта(и у автоАйтемов). У медиа айтемов в зависимости от startTimeTakeProj.
-- startTimeTakeProj: 1 или true - time отсчитывается от начала проекта иначе от начала тейка.
-- autoitem_idx, value,shape,tension,selected,noSortIn / http://www.extremraym.com/cloud/reascript-doc/#InsertEnvelopePointEx

    -- Добавить точку автоматизации везде
    local function InsertEnvelopePointEx_Arc(Env,autoitem_idx,time,point_indent,noDuplicate,value,shape,tension,selected,noSortIn,startTimeTakeProj)
        
        local playrate,posItem,lenItem;
        local Take = reaper.Envelope_GetParentTake(Env);
        if Take then;
            playrate = reaper.GetMediaItemTakeInfo_Value(Take,"D_PLAYRATE");
            local item = reaper.GetMediaItemTake_Item(Take)
            posItem = reaper.GetMediaItemInfo_Value(item,"D_POSITION");
            lenItem = reaper.GetMediaItemInfo_Value(item,"D_LENGTH");
            if startTimeTakeProj == 1 or startTimeTakeProj == true then;
                time = time-posItem;
            end;
            --if posItem > time or posItem + lenItem < time then return false end; --Что бы точка не добавлялась за пределами айтема
        end;
        
        if autoitem_idx >= 0 and Take then return false end;
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
            time = time*(playrate or 1);
            reaper.InsertEnvelopePointEx(Env,autoitem_idx,time,value,shape,tension,selected,noSortIn)
            return true;
        end;
        point=nil; return false;
    end;
    
    






    -- **
    -- Добавить точку автоматизации на тейк
    -- startTimeTakeProj: 1 или true - time отсчитывается от начала проекта иначе от начала тейка, все остальное написано выше*.
    -- вернет true / false;
    local function InsertEnvelopePointTake_Arc(Env,time,point_indent,noDuplicate,value,shape,tension,selected,noSortIn,startTimeTakeProj);
        local Take = reaper.Envelope_GetParentTake(Env);
        if not Take then return false end;
        local playrate = reaper.GetMediaItemTakeInfo_Value(Take,"D_PLAYRATE");
        local item = reaper.GetMediaItemTake_Item(Take);
        local posItem = reaper.GetMediaItemInfo_Value(item,"D_POSITION");
        local lenItem = reaper.GetMediaItemInfo_Value(item,"D_LENGTH");
        if startTimeTakeProj == 1 or startTimeTakeProj == true then;
            time = time-posItem;
        end;
        --if posItem > time or posItem + lenItem < time then return false end; --Что бы точка не добавлялась за пределами айтема
        
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




    


    --***
    -- Добавить точку автоматизации на трек
    -- time: от начала проекта, у автоАйтемов тоже от начала проекта; все остальное написано выше*.
    -- вернет true / false;
    local function InsertEnvelopePointTrack_Arc(Env,autoitem_idx,time,point_indent,noDuplicate,value,shape,tension,selected,noSortIn)
        
        local Track = reaper.Envelope_GetParentTrack(Env);
        if not Track then return false end;
        
        if autoitem_idx >= 0 then;
            local posAutoIt = reaper.GetSetAutomationItemInfo(Env,autoitem_idx,"D_POSITION",0,0);
            local lenAutoIt = reaper.GetSetAutomationItemInfo(Env,autoitem_idx,"D_LENGTH",0,0);
            if (time < posAutoIt) or (time > posAutoIt+lenAutoIt) then return false end;
        end;
        
        if noDuplicate == true or noDuplicate == 1 then;
            for i = 1, reaper.CountEnvelopePointsEx(Env,autoitem_idx) do;
                local _,time0,_,_,_,_ = reaper.GetEnvelopePointEx(Env,autoitem_idx,i-1);
                if time0 >= (time-(point_indent/2)) and time0 <= (time+(point_indent/2)) then;
                    point = true; break;
                end;
            end;
        end;
        
        if not point then;
            reaper.InsertEnvelopePointEx(Env,autoitem_idx,time,value,shape,tension,selected,noSortIn);
            return true;
        end;
        point=nil; return false;
    end;  
    
    
    
    
