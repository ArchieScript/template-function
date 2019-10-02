    
    
     --( НЕ ПРОИЗВОДИТЕЛЬНО !!! )
    -- Копировать / Переместить Диапазон Конверта(track) По Времени в конверте или с конверта на конверт.
    
    
    
    function CopyMove_EnvTr_PointsInRangeOfTime_SWS(ENV,ENV_NEW,time1,time2,timeNew1,Move,Undo);
        local function Convert_Env_ValueInValueAndInPercent_SWS(envelope,valPoint,PerVal);
            reaper.BR_EnvFree(reaper.BR_EnvAlloc(envelope,true),true);
            local _,_,_,_,_,_,min,max,_,_,faderS = reaper.BR_EnvGetProperties(reaper.BR_EnvAlloc(envelope,true));
            local interval = (max - min);
            if PerVal == 0 then return (valPoint-min)/interval*100;
            elseif PerVal == 1 then return (valPoint/100)*interval + min;
            end;
        end;
        reaper.GetEnvelopeName(ENV)reaper.GetEnvelopeName(ENV_NEW);
        if time2 <= time1 then return false end;
        if ENV == ENV_NEW and time1 == timeNew1 then return false end;
        reaper.PreventUIRefresh(123456);
        if Undo == true or Undo == 1 then;
            reaper.Undo_BeginBlock();
        end;
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
                ----
                local _,str = reaper.GetEnvelopeStateChunk(ENV_NEW,"",false);
                local str2 = str:gsub("POOLEDENV.-\n","")or"";
                reaper.SetEnvelopeStateChunk(ENV_NEW,str2,false); 
                local _,value1,_,_,_ = reaper.Envelope_Evaluate(ENV_NEW,m(timeNew1-0.000005),0,0);
                local _,value2,_,_,_ = reaper.Envelope_Evaluate(ENV_NEW,m(timeNew2+0.000005),0,0);
                reaper.SetEnvelopeStateChunk(ENV_NEW,str,false);
                reaper.DeleteEnvelopePointRangeEx(ENV_NEW,i,m(math.abs(timeNew1-0.000005)),timeNew2+0.000005);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew1-0.000001),value1,0,0,0,true);
                reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew2+0.000001),value2,0,0,0,true);
                -----
                if ENV ~= ENV_NEW then;
                    local _,str = reaper.GetEnvelopeStateChunk(ENV,"",false);
                    local str2 = str:gsub("POOLEDENV.-\n","")or"";
                    reaper.SetEnvelopeStateChunk(ENV,str2,false);
                    local _,value1,_,_,_ = reaper.Envelope_Evaluate(ENV,m(time1-0.0000001),0,0);
                    local _,value2,_,_,_ = reaper.Envelope_Evaluate(ENV,m(time2+0.0000001),0,0);
                    reaper.SetEnvelopeStateChunk(ENV,str,false);
                    ---
                    local ScalingPre = reaper.GetEnvelopeScalingMode(ENV);
                    if ScalingPre == 1 then;
                        value1 = reaper.ScaleFromEnvelopeMode(ScalingPre,value1);--v min
                        value2 = reaper.ScaleFromEnvelopeMode(ScalingPre,value2);--v min
                    end;
                    local Perc1 = Convert_Env_ValueInValueAndInPercent_SWS(ENV,value1,0);
                    local Perc2 = Convert_Env_ValueInValueAndInPercent_SWS(ENV,value2,0);
                    value1 = Convert_Env_ValueInValueAndInPercent_SWS(ENV_NEW,Perc1,1);
                    value2 = Convert_Env_ValueInValueAndInPercent_SWS(ENV_NEW,Perc2,1);
                    local ScalingPost = reaper.GetEnvelopeScalingMode(ENV_NEW);
                    if ScalingPost == 1 then;
                        value1 = reaper.ScaleToEnvelopeMode(ScalingPost,value1)--v max
                        value2= reaper.ScaleToEnvelopeMode(ScalingPost,value2)--v max
                    end;
                    ---
                    reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew1-0.0000001),value1,0,0,0,true);
                    reaper.InsertEnvelopePointEx(ENV_NEW,i,m(timeNew2+0.0000001),value2,0,0,0,true);
                end;
                -----
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
                        local strT = {};
                        for var in str:gmatch(".-\n") do;
                            if(tonumber(var:match("POOLEDENVINST%s+%S+%s+(.-)%s.+\n"))or-1) > 99^98 then var="" end;
                            strT[#strT+1] = var;
                        end;
                        str2 = table.concat(strT);
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
                        -----
                        local ScalingPre = reaper.GetEnvelopeScalingMode(ENV);
                        if ScalingPre == 1 then;
                            value = reaper.ScaleFromEnvelopeMode(ScalingPre,value);--v min
                        end;
                        local Perc = Convert_Env_ValueInValueAndInPercent_SWS(ENV,value,0);
                        value = Convert_Env_ValueInValueAndInPercent_SWS(ENV_NEW,Perc,1);
                        local ScalingPost = reaper.GetEnvelopeScalingMode(ENV_NEW);
                        if ScalingPost == 1 then;
                            value = reaper.ScaleToEnvelopeMode(ScalingPost,value)--v max
                        end;
                        -----
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
            if Move == true or Move == 1 then ENV_NEW = ENV timeNew1 = nil GotoMOVEActive = true goto GotoMOVE end;
        end;
        ---
        GotoMOVEActive = nil;
        if not Goto_DimmyActive and DimmyTr then;Goto_DimmyActive = true goto Goto_Dimmy;
        elseif Goto_DimmyActive and DimmyTr then;reaper.DeleteTrack(reaper.GetTrack(0,0))end;
        ---
        local function ClearEnvelopeInTimeInterval(env,time1,time2,interval);
            local leftPoint  = reaper.GetEnvelopePointByTimeEx(env,-1,time1-0.00001);
            local RightPoint = reaper.GetEnvelopePointByTimeEx(env,-1,time2+0.00001);
            local timeEnd,check;
            for i = RightPoint,leftPoint,-1 do;
                local timeR = ({reaper.GetEnvelopePoint(env,i-0)})[2];
                local timeC = ({reaper.GetEnvelopePoint(env,i-1)})[2];
                local timeL = ({reaper.GetEnvelopePoint(env,i-2)})[2];
                if (timeR - timeL) <= interval then;
                    if not check then;
                        timeEnd = ({reaper.GetEnvelopePoint(env,reaper.CountEnvelopePoints(env)-1)})[2]+10^2;
                        check = true;
                    end;
                    reaper.SetEnvelopePoint(env,i-1,timeEnd,0,0,0,0,true);
                    reaper.DeleteEnvelopePointRange(env,timeEnd-0.001,timeEnd+0.001);
                end;
            end;
            if check then reaper.Envelope_SortPoints(env)end;
        end;
        ClearEnvelopeInTimeInterval(ENV_NEW,timeNew1-0.0001,timeNew1+0.0001,0.0001);
        ClearEnvelopeInTimeInterval(ENV_NEW,timeNew2-0.0001,timeNew2+0.0001,0.0001);
        ---
        if Undo == true or Undo == 1 then;
            reaper.Undo_EndBlock("CopyMoveEnvelopePointsInRangeOfTime",-1);
        end;
        reaper.PreventUIRefresh(-123456);
        return true;
    end;
    
    -- Копировать / Переместить Диапазон Конверта(track) По Времени в конверте или с конверта на конверт.
    -- ENV - Конверт с которого переместить.
    -- ENV_NEW - Конверт на который переместить  / ENV и ENV_NEW может быть один конверт.
    -- time1 / time2 - Диапазон конверта от time1 до time2 который нужно переместить.
    -- timeNew1 - Время, куда нужно переместить.
    -- Move: true переместить / false скопировать.
    -- Undo: false отключить undo, true обернуть в undo блок.
    -- SWS из-за "Convert_Env_ValueInValueAndInPercent_SWS"
    -- Маштабирование огибающей учтено (Scaling Mode)
    -- При успехе вернет true в противном случае false
    --====End===============End===============End===============End===============End====
