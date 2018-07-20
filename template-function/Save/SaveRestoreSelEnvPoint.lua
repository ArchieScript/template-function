




   Сохранить востановить выделенные точки автоматизации   (работает со всеми точками автоэлемент(autoitem),огиб.на элементе)
                   
                   
                   SaveRest = 1 Сохронить Save
                   SaveRest = 2 Востановить Restore




    local function SaveRestoreSelEnvPoint(Env, SaveRest) 
        if SaveRest == 1 then selT = {} end
        if SaveRest == 1 then timT = {} end
        local t
        local CountAutoItem = reaper.CountAutomationItems(Env)
        for i = -1,CountAutoItem -1  do 
            local CountPoint =  reaper.CountEnvelopePointsEx(Env,i)
            for i1 = 1,CountPoint do 
                local _,time,_,_,_,sel = reaper.GetEnvelopePointEx(Env,i,i1-1)
                if SaveRest == 1 then
                    if not tonumber(t)then t = 0 end; t = t + 1
                    selT[t] = sel  
                    timT[t] = time               
                else  
                    for iT = 0, #timT do
                        if time == timT[iT] then
                            reaper.SetEnvelopePointEx(Env,i,i1-1,nil,nil,nil,nil,selT[iT],nil)
                        end
                    end  
                end      
            end    
        end 
    end
   
   
   
   
   
   
   
   
   
   
