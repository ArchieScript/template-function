








    -------------Module.lua-----------------------------------------------https://k-pavel.ru/moduli-v-lua/
     -- Создаем файл / Module.lua - с содержимым и наполняем функциями --
    ---------------------------------------------------------------------- 


    local Module = {}

    function Module.Action()
       bla bla bla
    end


    return Module


    --------------///////////////////////---------------------------------
    -------------///////////////////////----------------------------------
    ------------///////////////////////-----------------------------------



    -------------------------------------------
     -- В скрипте прописываем путь к модулю --
    -------------------------------------------

    
    


    --  filename = select(2,reaper.get_action_context())
    --  ScriptPath, ScriptName = filename:match("(.+)[\\](.+)")

    Module_Path = [[путь к папке где лежит модуль]] 

    package.path = package.path..";"..Module_Path.."/?.lua"
    Mod = require "Module"
    ------------------------http://k-pavel.ru/moduli-v-lua/



    Mod.Action()  bla bla bla



















-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------






---------------------------------------------------
local function GetSubdirectoriesUpToLevelFive(Path);
  local T,Enu,s,h = {Path},reaper.EnumerateSubdirectories,"\\",math.huge; 
  for i=0,h do;f1 = Enu(Path,i);if f1 then;T[#T+1]=Path..s..f1;
    for i2=0,h do;f2=Enu(Path..s..f1,i2)if f2 then T[#T+1]=Path..s..f1..s..f2;
      for i3=0,h do;f3=Enu(Path..s..f1..s..f2,i3)if f3 then T[#T+1]=Path..s..f1..s..f2..s..f3;
        for i4=0,h do;f4 = Enu(Path..s..f1..s..f2..s..f3,i4)if f4 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4;
          for i5=0,h do;f5=Enu(Path..s..f1..s..f2..s..f3..s..f4,i5)if f5 then T[#T+1]=Path..s..f1..s..f2..s..f3..s..f4..s..f5;
          ----------
          end;if not f5 then break end;end;
        end;if not f4 then break end;end;
      end;if not f3 then break end;end;
    end;if not f2 then break end;end; 
  end;if not f1 then return T end;end;
end;
---
local function GetModule(Path,file)
  local FolPath,mod,Way = GetSubdirectoriesUpToLevelFive(Path) 
  for i=0,#FolPath do;if not FolPath[i]then FolPath[i]=select(2,reaper.get_action_context()):match("(.+)[\\]")end;
    for i2 = 0,math.huge do; local f = reaper.EnumerateFiles(FolPath[i],i2)
      if f == file then mod=true Way=FolPath[i]break end;if not f then break end;
    end; if mod then return mod,Way end;
  end----------------------------------
end------------------------------------
---------------------------------------
local found_mod,ScriptPath,Arc = GetModule(reaper.GetResourcePath(),"Arc_Function_lua.lua")
if not found_mod then reaper.ReaScriptError("Missing 'Arc_Function_lua' file,"
                        .." install ReaPack to install this file.") return end
package.path = package.path..";"..ScriptPath.."/?.lua"
Arc = require "Arc_Function_lua"
-------------------------------- 
  
  

 bla =  Arc.Action(id)



