






    -- dofile ([filename])  --  http://marker.to/nZ5S78


    -- Запустить скрипт скриптом / даже не добавленный в reaper

-----------

     local script_path = [[C:\Путь к скрипту без скрипта]]
    
     dofile(script_path .. "/" .. "скрипт.lua") 
     
     
-----------     
     
     
     
     
     
     
     
-------   
    -- local info = debug.getinfo(1,'S');
    -- local script_path = info.source:match([[^@?(.*[\/])[^\/]-$]]):match('(.*)\\')
-------
  
-------
    -- local is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context()
    -- local script_path,script_name = filename:match("(.+)[\\](.+)") 
-------













