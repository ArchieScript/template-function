

   -- Удалить Диапазон Огибающей



    
    function DeleteEnvelopeRangeEx(env,time1,time2,Undo);
        if Undo == true or Undo == 1 then;reaper.Undo_BeginBlock();Undo=1 end;
        reaper.PreventUIRefresh(11111);
        local function m(x) if x < 0 then x = 0 end; return x end;
        local _,str = reaper.GetEnvelopeStateChunk(env,"",false);
        local str2 = str:gsub("POOLEDENV.-\n","")or"";
        reaper.SetEnvelopeStateChunk(env,str2,false);
        local _,value1,_,_,_ = reaper.Envelope_Evaluate(env,m(time1-0.000005),0,0);
        local _,value2,_,_,_ = reaper.Envelope_Evaluate(env,m(time2+0.000005),0,0);
        reaper.SetEnvelopeStateChunk(env,str,false);
        reaper.DeleteEnvelopePointRangeEx(env,-1,m(math.abs(time1-0.000005)),time2+0.000005);
        reaper.InsertEnvelopePointEx(env,-1,m(time1-0.000001),value1,0,0,0,true);
        reaper.InsertEnvelopePointEx(env,-1,m(time2+0.000001),value2,0,0,0,true);
        ----
        ::Res::
        for i = reaper.CountAutomationItems(env)-1,0,-1 do;
            local posIt = reaper.GetSetAutomationItemInfo(env,i,"D_POSITION" ,0,0);
            local lengt = reaper.GetSetAutomationItemInfo(env,i,"D_LENGTH"   ,0,0);
            local soffs = reaper.GetSetAutomationItemInfo(env,i,"D_STARTOFFS",0,0);
            local prate = reaper.GetSetAutomationItemInfo(env,i,"D_PLAYRATE" ,0,0);
            local po_id = reaper.GetSetAutomationItemInfo(env,i,"D_POOL_ID"  ,0,0);
            if posIt < m(time1) and posIt + lengt > m(time1) and posIt + lengt <= m(time2)then;
                reaper.GetSetAutomationItemInfo(env,i,"D_LENGTH",m(time1)-posIt,1);
            end;
            if posIt < m(time2) and posIt + lengt > m(time2) and posIt >= m(time1) then;
                reaper.GetSetAutomationItemInfo(env,i,"D_STARTOFFS",(m(time2)-posIt)*prate+soffs,1);
                reaper.GetSetAutomationItemInfo(env,i,"D_POSITION",m(time2),1);
                reaper.GetSetAutomationItemInfo(env,i,"D_LENGTH",(posIt+lengt)-m(time2),1);
            end;
            if posIt < m(time1) and posIt + lengt > m(time2) then;
                reaper.GetSetAutomationItemInfo(env,i,"D_LENGTH",m(time1)-posIt,1);
                local NewAIt = reaper.InsertAutomationItem(env,po_id,posIt,lengt);
                reaper.GetSetAutomationItemInfo(env,NewAIt,"D_STARTOFFS",soffs,1);
                reaper.GetSetAutomationItemInfo(env,NewAIt,"D_PLAYRATE" ,prate,1);
                reaper.GetSetAutomationItemInfo(env,NewAIt,"D_STARTOFFS",(m(time2)-posIt)*prate+soffs,1);
                reaper.GetSetAutomationItemInfo(env,NewAIt,"D_POSITION",m(time2),1);
                reaper.GetSetAutomationItemInfo(env,NewAIt,"D_LENGTH",(posIt+lengt)-m(time2),1);
                goto Res;
            end;
            if posIt >= m(time1) and posIt + lengt <= m(time2) then;
                reaper.GetSetAutomationItemInfo(env,i,"D_POSITION",99^99,1);
                local retval,str = reaper.GetEnvelopeStateChunk(env,"",false);
                local strT = {};
                for var in str:gmatch(".-\n") do;
                    if(tonumber(var:match("POOLEDENVINST%s+%S+%s+(.-)%s.+\n"))or-1) > 99^98 then var="" end;
                    strT[#strT+1] = var;
                end;
                reaper.SetEnvelopeStateChunk(env,table.concat(strT),false);
                goto Res;
            end;
        end;
        reaper.Envelope_SortPoints(env);
        reaper.PreventUIRefresh(-11111);
        if Undo == 1 then;reaper.Undo_EndBlock("Delete Envelope Range",-1);end;
    end;
    
    -- Удалить Диапазон Огибающей
    -- time1,time2 = Удалить от time1 до time2
    -- Undo: false отключить undo, true обернуть в undo блок.
    --====End===============End===============End===============End===============End====
