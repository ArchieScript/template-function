   
   -- НЕ РАБОТАЕТ
   
   https://forum.cockos.com/showthread.php?t=240385
   
   
   local function GetSetSectionFromActionList(section,set);
        local hWnd_action = reaper.JS_Window_Find("Actions",true);
        if not hWnd_action then return end;
        local combo = reaper.JS_Window_FindChildByID(hWnd_action,1317);
        if set == 1 or set == true then;
            reaper.JS_WindowMessage_Send(combo,"CB_SETCURSEL",section or 0,0,0,0);
        end;
        local sectionName = reaper.JS_Window_GetTitle(combo,"");
        local sectionID = reaper.JS_WindowMessage_Send(combo,"CB_GETCURSEL",0,0,0,0);
        return sectionID,sectionName;
    end;
    
    
    
    
    
    
    
