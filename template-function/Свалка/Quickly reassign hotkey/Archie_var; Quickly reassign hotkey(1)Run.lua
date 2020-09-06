--[[
   * Тест только на windows  /  Test only on windows.
   * Отчет об ошибке: Если обнаружите какие либо ошибки, то сообщите по одной из указанных ссылок ниже (*Website)
   * Bug Reports: If you find any errors, please report one of the links below (*Website)
   *
   * Category:    Various
   * Description: var; Quickly reassign hotkey(1)Run.lua
   * Author:      Archie
   * Version:     1.0
   * AboutScript: ---
   * Website:     http://forum.cockos.com/showthread.php?t=212819
   *              http://rmmedia.ru/threads/134701/
   *              http://vk.com/reaarchie
   * DONATION:    http://money.yandex.ru/to/410018003906628
   * DONATION:    http://paypal.me/ReaArchie?locale.x=ru_RU
   * Customer:    Archie(---)
   * Gave idea:   Archie(---)
   * Provides:
   * Extension:   Reaper 6.12+ http://www.reaper.fm/
   *              SWS v.2.12.0 http://www.sws-extension.org/index.php
   *              reaper_js_ReaScriptAPI64 Repository - (ReaTeam Extensions) http://clck.ru/Eo5Nr or http://clck.ru/Eo5Lw
   *              Arc_Function_lua v.3.0.0+  (Repository: Archie-ReaScripts) http://clck.ru/EjERc
   * Changelog:   
   *              v.1.0 [060920]
   *                  + initialе
--]] 
    --======================================================================================
    --////////////  НАСТРОЙКИ  \\\\\\\\\\\\  SETTINGS  ////////////  НАСТРОЙКИ  \\\\\\\\\\\\
    --======================================================================================
    
    local HELP = true -- true/false
     
    --======================================================================================
    --////////////// SCRIPT \\\\\\\\\\\\\\  SCRIPT  //////////////  SCRIPT  \\\\\\\\\\\\\\\\
    --======================================================================================
    
    
    
    --=========================================
    local function MODULE(file);
        local E,A=pcall(dofile,file);if not(E)then;reaper.ShowConsoleMsg("\n\nError - "..debug.getinfo(1,'S').source:match('.*[/\\](.+)')..'\nMISSING FILE / ОТСУТСТВУЕТ ФАЙЛ!\n'..file:gsub('\\','/'))return;end;
        if not A.VersArcFun("2.9.0",file,'')then;A=nil;return;end;return A;
    end; local Arc = MODULE((reaper.GetResourcePath()..'/Scripts/Archie-ReaScripts/Functions/Arc_Function_lua.lua'):gsub('\\','/'));
    if not Arc then return end;
    local ArcFileIni = reaper.GetResourcePath():gsub('\\','/')..'/reaper-Archie.ini';
    --=========================================
    
    
    
    ---------------------------------------------------
    local _,scriptPath,secID,cmdID,_,_,_ = reaper.get_action_context();
    --local section = scriptPath:match('^.*[/\\](.+)$');
    local section = scriptPath:lower():match('^.*[/\\](.-)run%s-%.%s-lua$');
    if not section then
        reaper.MB('Name Invalid','Woops',0)no_undo()return;
    end;
    ---------------------------------------------------
    
    
    local exStateT = Arc.iniFileReadSectionLua(section,ArcFileIni);
    if #exStateT == 0 then;
        -----
        -----
        --HELP
        if HELP ~= false then;
            reaper.MB(
                      'Нет назначенных действий, смотрите инструкцию в скрипте\n'..
                   'Archie_var; Quickly reassign hotkey(n)Popup.lua\n\n' ..
                'There are no assigned actions, see the instructions in the script\n'..
             'Archie_var; Quickly reassign hotkey(n)Popup.lua'
          ,'Woops',0)no_undo()return;
        end;
        -----
        -----
    elseif #exStateT > 0 then;
        ----
        ----
        --ACT;
        local STR_ID;
        for i = 1,#exStateT do;
            if exStateT[i].val:match('^!')then;
                STR_ID = exStateT[i].key;
                break;
            end;
        end;
        if STR_ID then;
            Arc.Action(STR_ID);
            no_undo();
        end;
        ----
        ----
    else;
        no_undo();return;
    end;
    
    
    
    
    
    
    
