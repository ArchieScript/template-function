




   Сохранить востановить выделенные точки автоматизации   (работает со всеми точками автоэлемент(autoitem),огиб.на элеминте)
                   
                   
                   SaveRest = 1 Сохронить Save
                   SaveRest = 2 Востановить Restore




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
   
   
   
   
   
   
   
   
   
   
