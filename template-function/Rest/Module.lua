








    -------------Module.lua-----------------------------------------------
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

    package.path = package.path..";"..Module_Path.."./?.lua"
    Mod = require "Module"
    ------------------------http://k-pavel.ru/moduli-v-lua/



    Mod.Action()  bla bla bla










