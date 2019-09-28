--Готово:



-- Копировать / Переместить Диапазон Конверта По Времени в конверте или с конверта на конверт.

-- ENV - Конверт с которого переместить
-- ENV_NEW - Конверт на который переместить  / ENV и ENV_NEW может быть один конверт.
-- time1/time2 - Диапазон конверта от time1 до time2 который нужно переместить.
-- timeNew1 - Время, куда нужно переместить (начальная точка от Диапазона time1-time2)
-- Move: true переместить / false скопировать.


    -------------------------------------------------------------------------------------------
    local function CopyMoveEnvelopePointsInRangeOfTime(ENV,ENV_NEW,time1,time2,timeNew1,Move);
        reaper.GetEnvelopeName(ENV)reaper.GetEnvelopeName(ENV_NEW);
        if time2 <= time1 then return false end;
        reaper.PreventUIRefresh(123456);reaper.Undo_BeginBlock();
        local timeNew2,newLength,DimmyTr,Goto_DimmyActive
        -----
        local T = {time1=time1,time2=time2,timeNew1=timeNew1,timeNew2=timeNew1+(time2-time1)};
        if ENV == ENV_NEW then;
            reaper.InsertTrackAtIndex(0,false);local track = reaper.GetTrack(0,0);
            local envTr = reaper.GetTrackEnvelopeByChunkName(track,"<VOLENV2");
            ENV_NEW=envTr; DimmyTr = true;
        end;
        local Env_T = {ENV=ENV,ENV_NEW=ENV_NEW};
        ::Goto_Dimmy::
        if Goto_DimmyActive then;
            time1=T.timeNew1 time2=T.timeNew2 timeNew1=T.timeNew1 timeNew2=T.timeNew2;
             ENV = Env_T.ENV_NEW;ENV_NEW=Env_T.ENV;
        end;
        -----
        ::GotoMOVE::;
        if not tonumber(timeNew1)or timeNew1 < 0 then timeNew1 = time1 end;
        local timeNew2 = timeNew1+(time2-time1);
        local function m(x) if x < 0 then x = 0 end; return x end;
        local CountAutoItem = reaper.CountAutomationItems(ENV);
        for i = -1,CountAutoItem-1 do;
            if i == -1 then;
                local _,str = reaper.GetEnvelopeStateChunk(ENV_NEW,"",false);
                local str2 = str:gsub("POOLEDENV.-\n","")or"";
                reaper.SetEnvelopeStateChunk(ENV_NEW,str2,false);
                local _,value1,_,_,_ = reaper.Envelope_Evaluate(ENV_NEW,m(timeNew1-0.00001),0,0);
                local _,value2,_,_,_ = reaper.Envelope_Evaluate(ENV_NEW,m(timeNew2+0.00001),0,0);
                reaper.SetEnvelopeStateChunk(ENV_NEW,str,false);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew1-0.00001),value1,0,0,0,true);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew2+0.00001),value2,0,0,0,true);
                local _,str = reaper.GetEnvelopeStateChunk(ENV,"",false);
                local str2 = str:gsub("POOLEDENV.-\n","")or"";
                reaper.SetEnvelopeStateChunk(ENV,str2,false);
                local _,value1,_,_,_ = reaper.Envelope_Evaluate(ENV,m(time1-0.000001),0,0);
                local _,value2,_,_,_ = reaper.Envelope_Evaluate(ENV,m(time2+0.000001),0,0);
                reaper.SetEnvelopeStateChunk(ENV,str,false);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew1-0.000001),value1,0,0,0,true);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew2+0.000001),value2,0,0,0,true);
                reaper.DeleteEnvelopePointRangeEx(ENV_NEW,i,m(math.abs(timeNew1-0.0000001)),timeNew2+0.0000001);
                ----
                ::Res::
                for ii = reaper.CountAutomationItems(ENV_NEW)-1,0,-1 do;
                    local posIt = reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_POSITION" ,0,0);
                    local lengt = reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_LENGTH"   ,0,0);
                    local soffs = reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_STARTOFFS",0,0);
                    local prate = reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_PLAYRATE" ,0,0);
                    local po_id = reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_POOL_ID"  ,0,0);
                    if posIt < m(timeNew1) and posIt + lengt > m(timeNew1) and posIt + lengt <= m(timeNew2)then;
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_LENGTH",m(timeNew1)-posIt,1);
                    end;
                    if posIt < m(timeNew2) and posIt + lengt > m(timeNew2) and posIt >= m(timeNew1) then;
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_STARTOFFS",(m(timeNew2)-posIt)*prate+soffs,1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_POSITION",m(timeNew2),1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_LENGTH",(posIt+lengt)-m(timeNew2),1);
                    end;
                    if posIt < m(timeNew1) and posIt + lengt > m(timeNew2) then;
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_LENGTH",m(timeNew1)-posIt,1);
                        local NewAIt = reaper.InsertAutomationItem(ENV_NEW,po_id,posIt,lengt);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,NewAIt,"D_STARTOFFS",soffs,1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,NewAIt,"D_PLAYRATE" ,prate,1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,NewAIt,"D_STARTOFFS",(m(timeNew2)-posIt)*prate+soffs,1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,NewAIt,"D_POSITION",m(timeNew2),1);
                        reaper.GetSetAutomationItemInfo(ENV_NEW,NewAIt,"D_LENGTH",(posIt+lengt)-m(timeNew2),1);
                        goto Res;
                    end;
                    if posIt >= m(timeNew1) and posIt + lengt <= m(timeNew2) then;
                        reaper.GetSetAutomationItemInfo(ENV_NEW,ii,"D_POSITION",99^99,1);
                        local retval,str = reaper.GetEnvelopeStateChunk(ENV_NEW,"",false);
                        str2 = nil;
                        for var in str:gmatch(".-\n") do;
                            if(tonumber(var:match("POOLEDENVINST%s+%S+%s+(.-)%s.+\n"))or-1) > 99^98 then var="" end;
                            str2=(str2 or "")..var;
                        end;
                        reaper.SetEnvelopeStateChunk(ENV_NEW,str2,false);
                        goto Res;
                    end;
                    reaper.Envelope_SortPointsEx(ENV_NEW,ii);
                end;
            end;
            ----
            if GotoMOVEActive then goto GotoEXIT end;
            local POSIT = reaper.GetSetAutomationItemInfo(ENV,i,"D_POSITION" ,0,0);
            local LENGT = reaper.GetSetAutomationItemInfo(ENV,i,"D_LENGTH"   ,0,0);
            local SOFFS = reaper.GetSetAutomationItemInfo(ENV,i,"D_STARTOFFS",0,0);
            local PRATE = reaper.GetSetAutomationItemInfo(ENV,i,"D_PLAYRATE" ,0,0);
            local PO_ID = reaper.GetSetAutomationItemInfo(ENV,i,"D_POOL_ID"  ,0,0);
            if POSIT < m(time2) and POSIT+LENGT > m(time1) then;  
                NewAutoIt = reaper.InsertAutomationItem(ENV_NEW,PO_ID,m((POSIT-time1)+timeNew1),LENGT);
                reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_STARTOFFS",SOFFS,1);
                reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_PLAYRATE" ,PRATE,1);
            end;
            if i == -1 then;
                local CountEnvPoint = reaper.CountEnvelopePointsEx(ENV,i);
                for i2 = 1,CountEnvPoint do;
                    local retval,time,value,shape,tension,selected = reaper.GetEnvelopePointEx(ENV,i,i2-1);
                    if time >= m(time1) and time <= m(time2) --[[and i == -1 or i>=0]] then;
                        reaper.InsertEnvelopePointEx(ENV_NEW,i,(time-m(time1))+m(timeNew1),value,shape,tension,selected,true);
                    end;
                end;
            end;
            if NewAutoIt then;
                if POSIT < m(time1) and POSIT + LENGT > m(time1) then;
                    reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_STARTOFFS",(m(time1)-POSIT)*PRATE+SOFFS,1);
                    reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_POSITION",m(timeNew1),1);
                    if POSIT+LENGT>=m(time2) then newLength=m(time2)-m(time1) else newLength=POSIT+LENGT-m(time1) end;
                    reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_LENGTH",newLength,1);
                elseif POSIT >= time1 and POSIT < time2 then;
                    if POSIT+LENGT>=m(time2) then newLength = m(time2)-POSIT else newLength = POSIT+LENGT-POSIT end;
                    reaper.GetSetAutomationItemInfo(ENV_NEW,NewAutoIt,"D_LENGTH",newLength,1);
                end;
            end;
            NewAutoIt = nil;
        end;
        ::GotoEXIT::;
        for i = reaper.CountAutomationItems(ENV_NEW)-1,-1,-1 do;
            reaper.Envelope_SortPointsEx(ENV_NEW,i);
        end;
        if not GotoMOVEActive then;
            if Move == true then ENV_NEW = ENV timeNew1 = nil GotoMOVEActive = true goto GotoMOVE end;
        end;
        ---
        GotoMOVEActive = nil;
        if not Goto_DimmyActive and DimmyTr then;Goto_DimmyActive = true goto Goto_Dimmy;
        elseif Goto_DimmyActive and DimmyTr then;reaper.DeleteTrack(reaper.GetTrack(0,0))end;
        ---
        reaper.Undo_EndBlock("CopyMoveEnvelopeRangeByTime",0);reaper.PreventUIRefresh(-123456);
        return true
    end;
    -------------------------------------------------------------------------------------------
    
    
    
    
    
    
    
