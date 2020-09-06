--[[
   * Тест только на windows  /  Test only on windows.
   * Отчет об ошибке: Если обнаружите какие либо ошибки, то сообщите по одной из указанных ссылок ниже (*Website)
   * Bug Reports: If you find any errors, please report one of the links below (*Website)
   *
   * Category:    Various
   * Description: var; Quickly reassign hotkey(1)Popup.lua
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
    
    local SHIFT_X = -50;
    local SHIFT_Y = 15;
    
    local TITLE = 'title'; -- 'string' or nil/false
     
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
    
    
    local function OpenWebSite(path);
        local OS = reaper.GetOS();
        if OS == "OSX32" or OS == "OSX64" then;
            os.execute('open "'..path..'"');
        else;
            os.execute('start "" '..path);
        end;
    end;
    
    
    ---------------------------------------------------
    local _,scriptPath,secID,cmdID,_,_,_ = reaper.get_action_context();
    --local section = scriptPath:match('^.*[/\\](.+)$');
    local section = scriptPath:lower():match('^.*[/\\](.-)popup%s-%.%s-lua$');
    if not section then
        reaper.MB('Name Invalid','Woops',0)no_undo()return;
    end;
    ---------------------------------------------------
    
    local API_JS = reaper.APIExists('JS_Window_Find');
    if not API_JS then;
        reaper.MB('Missing extension reaper_js_ReaScriptAPI','Woops',0)no_undo()return;
    end;
    
    local exStateT = Arc.iniFileReadSectionLua(section,ArcFileIni);
    
    local STR = '';
    for i = 1,#exStateT do;
        local str2 = exStateT[i].val..'|';
        STR = STR..str2;
    end;
    
     
    ------------------------------------------------
    --local SHIFT_X = -50;local SHIFT_Y = 15;section
    local x,y = reaper.GetMousePosition();
    local x,y =  x+(SHIFT_X or 0),y+(SHIFT_Y or 0);
    local title = 'HIDE Win_'..section;
    gfx.init(title,0,0,0,x,y);
    gfx.x,gfx.y = gfx.screentoclient(x,y);
    ---
    local API_JS = reaper.APIExists('JS_Window_Find');
    if API_JS then;
        local Win = reaper.JS_Window_Find(title,true);
        if Win then;
            reaper.JS_Window_SetOpacity(Win,'ALPHA',0);
            reaper.JS_Window_Move(Win,-9999,-9999);
            gfx.x,gfx.y = gfx.screentoclient(x,y);
        end;
    end;
    ------------------------------------------------
    
    
    
    ------------------------------------------------
    if TITLE then;TITLE = '#'..tostring(TITLE)..'||';else;TITLE = '';end;
    
    local showmenu = gfx.showmenu(TITLE..
                                  STR..
                                  '|>Add/Remove|'..
                                  'Add|'..
                                  '>Remove|'..
                                  STR:gsub('|$','')..'|'..
                                  '<|'..
                                  '|Help|'..
                                  '<|'
                                  );
    if #TITLE > 0 then showmenu = showmenu-1 end;
    if showmenu <= 0 then no_undo() return end;                   
    if showmenu <= #exStateT then;
        -----
        -----
        --ACT_TGL
        local tglAct;
        if exStateT[showmenu].val:match('^!')then tglAct = '' else tglAct = '!'end;
        
        for i = 1,#exStateT do;
           exStateT[i].val = exStateT[i].val:gsub('^!*','');--:gsub('^[!%s]','');
        end;
        exStateT[showmenu].val = tglAct..exStateT[showmenu].val;
        iniFileWriteSectionLua(section,exStateT,ArcFileIni);
        -----
        -----
    elseif showmenu == #exStateT+1 then;
        -----
        -----
        --ADD
        ::restart_AddAction::
        local retval,retvals_csv = reaper.GetUserInputs
                                   ('Add action',2,'Add ID Action:,Add Name Action:,extrawidth=500,separator==','');
        if not retval then gfx.quit()no_undo() return end;
        id,act = retvals_csv:match('(.-)=(.*)');
        id = id:gsub('[%s]','');
        if act:match('^[!#><]+')then act = ' '..act end;
        if act:match('[!#><]+$')then act = act..' ' end;
        if(not id)or(#id==0)or(not act)or(#act:gsub('%s','')<1)then goto restart_AddAction end;
        Arc.iniFileWriteLua(section,id,act,ArcFileIni);
        -----
        -----
    elseif (showmenu >#exStateT+1)and(showmenu<=(#exStateT*2)+1)then;
       -----
       -----
       --REM
       table.remove(exStateT,(showmenu-#exStateT-1));
       iniFileWriteSectionLua(section,exStateT,ArcFileIni);
       -----
       ----- 
    elseif (showmenu > (#exStateT*2)+1)then;
        -----
        -----
        --HELP
        local str = 
        'Назначьте скрипт\n'.. 
        'Archie_var; Quickly reassign hotkey(1)Run.lua\n'.. 
        'на нужное сочетание клавиш, Затем перейдите к скрипту\n'..
        'Archie_var; Quickly reassign hotkey(1)Popup.lua\n'..  
        'и в нем добавьте нужные действия для переключения.\n'..
        'Назначьте данный скрипт на кнопку в тулбаре \n'..
        'и с легкостью переключайте действие на горячей клавише.\n'..
        'Получить больше информации можно здесь (ОК) \n\n\n'..
        'Assign the script\n'..
        'Archie_var; Quickly reassign hotkey(1)Run.lua\n'.. 
        'to the desired keyboard shortcut, then go to the script\n'..
        'Archie_var; Quickly reassign hotkey(1)Popup.lua\n'..  
        'and add the necessary actions for switching.\n'..
        'Assign this script to a button in the toolbar\n'..
        'and easily switch the action on the hotkey.\n'..
        'You can get more information here (OK)\n';
        -----
        local mb = reaper.MB(str,'Help',1)
        if mb == 1 then;
            OpenWebSite('___');
        end;
        -----
        -----
    end;
    
    
    
    
    
    
    
    
