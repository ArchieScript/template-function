




   Сохранить востановить выделенные точки автоматизации   (работает со всеми точками автоэлемент(autoitem),огиб.на элементе)
                   
                   
                   SaveRest = 1 Сохронить Save
                   SaveRest = 2 Востановить Restore

                     ------------------------------


                          -- Сохранение Востановление точек по времени /  подходит для удаления

    local function SaveRestoreSelEnvPoint(Env, SaveRest) 
        local t
        if SaveRest == 1 then selT = {};timeT = {} end
        local CountAutoItem = reaper.CountAutomationItems(Env)
        for i = -1,CountAutoItem -1  do 
            local CountPoint =  reaper.CountEnvelopePointsEx(Env,i)
            for i1 = 1,CountPoint do 
                local _,time,_,_,_,sel = reaper.GetEnvelopePointEx(Env,i,i1-1)
                if SaveRest == 1 then
                    if not tonumber(t)then t = 0 end; t = t + 1
                    selT[t] = sel  
                    timeT[t] = time               
                else  
                    for iT = 0, #timeT do
                        if time == timeT[iT] then
                            reaper.SetEnvelopePointEx(Env,i,i1-1,nil,nil,nil,nil,selT[iT],nil)
                        end
                    end  
                end      
            end    
        end 
    end 
   
   
   
   
   
   


---------------
          -- Сохранение Востановление точек по номеру /  не кректно раб. с авто элементами при удалении


   local selT 
   local function SaveRestoreSelEnvPoint(Env, SaveRest) 
       local t = nil
       if SaveRest == 1 then selT = {} end
       local CountAutoItem = reaper.CountAutomationItems(Env)
       for i = -1,CountAutoItem -1  do 
           local CountPoint =  reaper.CountEnvelopePointsEx(Env,i)
           for i1 = 1,CountPoint do 
               if SaveRest == 1 then
                   if not tonumber(t)then t = 0 end t = t + 1
                   local _,_,value,_,_,sel = reaper.GetEnvelopePointEx(Env,i,i1-1)
                   selT[t-1] = sel                 
               else  
                   if not tonumber(t)then t = (-1) end t = t + 1
                   for iT = 0, #selT  do
                       if iT == t then
                           reaper.SetEnvelopePointEx(Env,i,i1-1,nil,nil,nil,nil,selT[iT],nil)
                       end
                   end  
               end      
          end    
       end 
   end 
   
   
   
   
