







  -- открыть консоль с сообщением

   --test = сообщение 
   
   при цикле / дефере
   --true  = очистить консоль
   --false = начать со следуюший строки




   --------------------------------------------------------------------------------------------------------------
   local function msg(pr,cl)r=reaper;if cl==true then r.ClearConsole()end;r.ShowConsoleMsg(tostring(pr..'\n'))end   
   --------------------------------------------------------------------------------------------------------------
   -- msg('test',true false )
   -------------------------- 






